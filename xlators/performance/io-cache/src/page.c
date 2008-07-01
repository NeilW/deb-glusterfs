/*
   Copyright (c) 2007, 2008 Z RESEARCH, Inc. <http://www.zresearch.com>
   This file is part of GlusterFS.

   GlusterFS is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published
   by the Free Software Foundation; either version 3 of the License,
   or (at your option) any later version.

   GlusterFS is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see
   <http://www.gnu.org/licenses/>.
*/

#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif

#include "glusterfs.h"
#include "logging.h"
#include "dict.h"
#include "xlator.h"
#include "io-cache.h"
#include <assert.h>
#include <sys/time.h>

ioc_page_t *
ioc_page_get (ioc_inode_t *ioc_inode,
	      off_t offset)
{
  ioc_table_t *table = ioc_inode->table;
  ioc_page_t *page = NULL;
  off_t rounded_offset = floor (offset, table->page_size);
  int8_t found = 0;

  if (list_empty (&ioc_inode->pages)) {
    return NULL;
  }

  list_for_each_entry (page, &ioc_inode->pages, pages) {
    if (page->offset == rounded_offset) {
      found = 1;
      break;
    }
  }

  /* was previously returning ioc_inode itself.., 1st of its type and found one more downstairs :O */
  if (!found){
    page = NULL;
  } else {
    /* push the page to the end of the lru list */
    list_move_tail (&page->page_lru, &ioc_inode->page_lru);
  }

  return page;
}


/*
 * ioc_page_destroy -
 *
 * @page:
 *
 */
int64_t
ioc_page_destroy (ioc_page_t *page)
{
  int64_t page_size = 0;

  page_size = page->size;

  if (page->waitq) {
    /* frames waiting on this page, do not destroy this page */
    page_size = -1;
  } else {

    list_del (&page->pages);
    list_del (&page->page_lru);
    
    gf_log (page->inode->table->xl->name, GF_LOG_DEBUG,
	    "destroying page = %p, offset = %lld && inode = %p",
	    page, page->offset, page->inode);
    
    if (page->vector){
      dict_unref (page->ref);
      free (page->vector);
      page->vector = NULL;
    }
    
    page->inode = NULL;
    
  }

  if (page_size != -1) {
    pthread_mutex_destroy (&page->page_lock);
    free (page);
  }

  return page_size;
}

/*
 * ioc_prune - prune the cache. we have a limit to the number of pages we
 *             can have in-memory.
 *
 * @table: ioc_table_t of this translator
 *
 */
int32_t
ioc_prune (ioc_table_t *table)
{
  ioc_inode_t *curr = NULL, *next_ioc_inode = NULL;
  ioc_page_t *page = NULL, *next = NULL;
  int32_t ret = -1;
  int32_t index = 0;
  uint64_t size_to_prune = 0;
  uint64_t size_pruned = 0;

  ioc_table_lock (table);
  
  size_to_prune = table->cache_used - table->cache_size;
  /* take out the least recently used inode */
  for (index=0; index < table->max_pri; index++) {
    
    list_for_each_entry_safe (curr, next_ioc_inode, &table->inode_lru[index], inode_lru) {
      /* prune page-by-page for this inode, till we reach the equilibrium */
      ioc_inode_lock (curr);
      list_for_each_entry_safe (page, next, &curr->page_lru, page_lru){
	/* done with all pages, and not reached equilibrium yet??
	 * continue with next inode in lru_list */
	size_pruned += page->size;
	ret = ioc_page_destroy (page);
	
	if (ret != -1)
	  table->cache_used -= ret;
	
	gf_log (table->xl->name,
		GF_LOG_DEBUG,
		"index = %d && table->cache_used = %"PRIu64" && table->cache_size = %"PRIu64, 
		index, table->cache_used, table->cache_size);
	
	if (size_pruned >= size_to_prune)
	  break;
      }
      if (list_empty (&curr->pages)) {
	list_del_init (&curr->inode_lru);
      }

      ioc_inode_unlock (curr);
      
      if (size_pruned >= size_to_prune)
	break;
    }

    if (size_pruned >= size_to_prune)
      break;
  }
    
  ioc_table_unlock (table);

  return 0;
}

/*
 * ioc_page_create - create a new page. 
 *
 * @ioc_inode: 
 * @offset:
 *
 */
ioc_page_t *
ioc_page_create (ioc_inode_t *ioc_inode,
		 off_t offset)
{
  ioc_table_t *table = ioc_inode->table;
  ioc_page_t *page = NULL;
  off_t rounded_offset = floor (offset, table->page_size);
  ioc_page_t *newpage = calloc (1, sizeof (*newpage));
  
  if (ioc_inode)
    table = ioc_inode->table;
  else {
    return NULL;
  }
   
  newpage->offset = rounded_offset;
  newpage->inode = ioc_inode;
  pthread_mutex_init (&newpage->page_lock, NULL);

  list_add_tail (&newpage->page_lru, &ioc_inode->page_lru);
  list_add_tail (&newpage->pages, &ioc_inode->pages);

  page = newpage;

  gf_log ("io-cache", GF_LOG_DEBUG,
	  "returning new page %p", page);
  return page;
}

/* 
 * ioc_wait_on_page - pause a frame to wait till the arrival of a page. here we need to handle the case
 *                    when the frame who calls wait_on_page himself has caused page_fault 
 *
 * @page: page to wait on
 * @frame: call frame who is waiting on page
 *
 */
void
ioc_wait_on_page (ioc_page_t *page,
		  call_frame_t *frame,
		  off_t offset,
		  size_t size)
{
  ioc_waitq_t *waitq = calloc (1, sizeof (*waitq));
  ioc_local_t *local = frame->local;
  
  gf_log (frame->this->name, GF_LOG_DEBUG,
	  "frame(%p) waiting on page = %p, offset=%lld, size=%d",
	  frame, page, offset, size);

  waitq->data = frame;
  waitq->next = page->waitq;
  waitq->pending_offset = offset;
  waitq->pending_size = size;
  page->waitq = waitq;
  /* one frame can wait only once on a given page, 
   * local->wait_count is number of pages a frame is waiting on */
  ioc_local_lock (local);
  local->wait_count++;
  ioc_local_unlock (local);
}


/*
 * ioc_cache_still_valid - see if cached pages ioc_inode are still valid against given stbuf
 *
 * @ioc_inode:
 * @stbuf:
 *
 * assumes ioc_inode is locked
 */
int8_t
ioc_cache_still_valid (ioc_inode_t *ioc_inode,
		       struct stat *stbuf)
{
  int8_t cache_still_valid = 1;
  
#if 0
  if (!stbuf || (stbuf->st_mtime != ioc_inode->mtime) || 
      (stbuf->st_mtim.tv_nsec != ioc_inode->stbuf.st_mtim.tv_nsec))
#else
  if (!stbuf || (stbuf->st_mtime != ioc_inode->mtime))
#endif
    cache_still_valid = 0;

#if 0
  /* talk with avati@zresearch.com to enable this section */
  if (!ioc_inode->mtime && stbuf) {
    cache_still_valid = 1;
    ioc_inode->mtime = stbuf->st_mtime;
  }
#endif

  return cache_still_valid;
}


static int32_t
ioc_fault_cbk (call_frame_t *frame,
	       void *cookie,
	       xlator_t *this,
	       int32_t op_ret,
	       int32_t op_errno,
	       struct iovec *vector,
	       int32_t count,
	       struct stat *stbuf)
{
  ioc_local_t *local = frame->local;
  off_t offset = local->pending_offset;
  ioc_inode_t *ioc_inode = local->inode;
  ioc_table_t *table = ioc_inode->table;
  ioc_page_t *page = NULL;
  off_t trav_offset = 0;
  size_t payload_size = 0;
  int32_t destroy_size = 0;

  trav_offset = offset;  
  payload_size = op_ret;

  ioc_inode_lock (ioc_inode);

  if (op_ret == -1 || (op_ret >= 0 && !ioc_cache_still_valid(ioc_inode, stbuf))) {
    gf_log (ioc_inode->table->xl->name, GF_LOG_DEBUG,
	    "cache for inode(%p) is invalid. flushing all pages", ioc_inode);
    destroy_size = __ioc_inode_flush (ioc_inode);
  }

  if (op_ret >= 0)
    ioc_inode->mtime = stbuf->st_mtime;

  gettimeofday (&ioc_inode->tv, NULL);

  if (op_ret < 0) {
    /* error, readv returned -1 */
    page = ioc_page_get (ioc_inode, offset);
    if (page)
      ioc_page_error (page, op_ret, op_errno);
  } else {
    gf_log (ioc_inode->table->xl->name, GF_LOG_DEBUG,
	    "op_ret = %d", op_ret);
    page = ioc_page_get (ioc_inode, offset);
    if (!page) {
      /* page was flushed */
      /* some serious bug ? */
      gf_log (this->name, GF_LOG_DEBUG,
	      "wasted copy: %lld[+%d] ioc_inode=%p", 
	      offset, table->page_size, ioc_inode);
    } else {
      if (page->vector) {
	dict_unref (page->ref);
	free (page->vector);
	page->vector = NULL;
      }

      /* keep a copy of the page for our cache */
      page->vector = iov_dup (vector, count);
      page->count = count;
      if (frame->root->rsp_refs) {
	page->ref = dict_ref (frame->root->rsp_refs);
      } else {
	/* TODO: we have got a response to our request and no data */
      }
      page->size = op_ret;
      if (page->waitq) {
	/* wake up all the frames waiting on this page, including 
	 * the frame which triggered fault */
	ioc_page_wakeup (page);
      }
    }
  }
  ioc_inode_unlock (ioc_inode);

  if (page) {
    if (page->size) {
      ioc_table_lock (table);
      table->cache_used += page->size;
      ioc_table_unlock (table);
    }
  }

  if (destroy_size) {
    ioc_table_lock (table);
    table->cache_used -= destroy_size;
    ioc_table_unlock (table);
  }

  if (ioc_need_prune (ioc_inode->table)) {
    ioc_prune (ioc_inode->table);
  }

  gf_log (this->name, GF_LOG_DEBUG, "fault frame %p returned", frame);
  pthread_mutex_destroy (&local->local_lock);

  STACK_DESTROY (frame->root);
  return 0;
}

/*
 * ioc_page_fault -
 * 
 * @ioc_inode:
 * @frame:
 * @fd:
 * @offset:
 *
 */
void
ioc_page_fault (ioc_inode_t *ioc_inode,
		call_frame_t *frame,
		fd_t *fd,
		off_t offset)
{
  ioc_table_t *table = ioc_inode->table;
  call_frame_t *fault_frame = copy_frame (frame);
  ioc_local_t *fault_local = calloc (1, sizeof (ioc_local_t));

  fault_frame->local = fault_local;
  pthread_mutex_init (&fault_local->local_lock, NULL);

  INIT_LIST_HEAD (&fault_local->fill_list);
  fault_local->pending_offset = offset;
  fault_local->pending_size = table->page_size;
  fault_local->inode = ioc_inode;

  gf_log (frame->this->name, GF_LOG_DEBUG,
	  "stack winding page fault for offset = %lld with frame %p",
	  offset, fault_frame);

  STACK_WIND (fault_frame, ioc_fault_cbk,
	      FIRST_CHILD(fault_frame->this),
	      FIRST_CHILD(fault_frame->this)->fops->readv,
	      fd, table->page_size, offset);
  return;
}

void
ioc_frame_fill (ioc_page_t *page,
		call_frame_t *frame,
		off_t offset,
		size_t size)
{
  ioc_local_t *local = frame->local;
  ioc_fill_t *fill = NULL;
  off_t src_offset = 0;
  off_t dst_offset = 0;
  ssize_t copy_size = 0;
  ioc_inode_t *ioc_inode = page->inode;
  
  gf_log (frame->this->name, GF_LOG_DEBUG,
	  "frame (%p) offset = %lld && size = %d && page->size = %d && wait_count = %d", 
	  frame, offset, size, page->size, local->wait_count);

  /* immediately move this page to the end of the page_lru list */
  list_move_tail (&page->page_lru, &ioc_inode->page_lru);
  /* fill from local->pending_offset to local->pending_size */
  if (local->op_ret != -1 && page->size) {
    if (offset > page->offset)
      /* offset is offset in file, convert it to offset in 
       * page */
      src_offset = offset - page->offset;
    else
      /* local->pending_offset is in previous page. do not fill until we
       * have filled all previous pages 
       */
      dst_offset = page->offset - offset;

    /* we have to copy from offset to either end of this page or till the 
     * requested size */
    copy_size = min (page->size - src_offset,
		     size - dst_offset);

    if (copy_size < 0) {
      /* if page contains fewer bytes and the required offset
	 is beyond the page size in the page */
      copy_size = src_offset = 0;
    }
    
    gf_log (page->inode->table->xl->name, GF_LOG_DEBUG,
	    "copy_size = %d && src_offset = %lld && dst_offset = %lld",
	    copy_size, src_offset, dst_offset);

    {
      ioc_fill_t *new = calloc (1, sizeof (*new));
      new->offset = page->offset;
      new->size = copy_size;
      new->refs = dict_ref (page->ref);
      new->count = iov_subset (page->vector,
			       page->count,
			       src_offset,
			       src_offset + copy_size,
			       NULL);
      new->vector = calloc (new->count, sizeof (struct iovec));
      new->count = iov_subset (page->vector,
			       page->count,
			       src_offset,
			       src_offset + copy_size,
			       new->vector);

      /* add the ioc_fill to fill_list for this frame */
      if (list_empty (&local->fill_list)) {
	/* if list is empty, then this is the first time we are filling 
	 * frame, add the ioc_fill_t to the end of list */
	list_add_tail (&new->list, &local->fill_list);
      } else {
	int8_t found = 0;
	/* list is not empty, we need to look for where this offset fits in 
	 * list */
	list_for_each_entry (fill, &local->fill_list, list) {
	    if (fill->offset > new->offset) {
	      found = 1;
	      break;
	    }
	}

	if (found) {
	  found = 0;
	  list_add_tail (&new->list, &fill->list);
	} else {
	  list_add_tail (&new->list, &local->fill_list);
	}
      }
    }
    local->op_ret += copy_size;
  }
}

/*
 * ioc_frame_unwind - frame unwinds only from here 
 *
 * @frame: call frame to unwind
 *
 * to be used only by ioc_frame_return(), when a frame has finished waiting on all pages, required
 *
 */
static void
ioc_frame_unwind (call_frame_t *frame)
{
  ioc_local_t *local = frame->local;
  ioc_fill_t *fill = NULL, *next = NULL;
  int32_t count = 0;
  struct iovec *vector = NULL;
  int32_t copied = 0;
  dict_t *refs = NULL;
  struct stat stbuf = {0,};
  int32_t op_ret = 0;

  //  ioc_local_lock (local);
  refs = get_new_dict ();
  refs->is_locked = 1;

  frame->local = NULL;

  if (list_empty (&local->fill_list)) {
    gf_log (frame->this->name, GF_LOG_DEBUG,
	    "frame(%p) has 0 entries in local->fill_list (offset = %lld && size = %d)",
	    frame, local->offset, local->size);
  }

  list_for_each_entry (fill, &local->fill_list, list) {
    count += fill->count;
  }

  vector = calloc (count, sizeof (*vector));
  
  list_for_each_entry_safe (fill, next, &local->fill_list, list) {
    memcpy (((char *)vector) + copied,
	    fill->vector,
	    fill->count * sizeof (*vector));
    
    copied += (fill->count * sizeof (*vector));

    dict_copy (fill->refs, refs);

    list_del (&fill->list);
    dict_unref (fill->refs);
    free (fill->vector);
    free (fill);
  }
  
  frame->root->rsp_refs = dict_ref (refs);
  
  op_ret = iov_length (vector, count);
  gf_log (frame->this->name, GF_LOG_DEBUG,
	  "frame(%p) unwinding with op_ret=%d", frame, op_ret);

  //  ioc_local_unlock (local);

  STACK_UNWIND (frame,
		op_ret,
		local->op_errno,
		vector,
		count,
		&stbuf);

  dict_unref (refs);
    
  pthread_mutex_destroy (&local->local_lock);
  free (local);
  free (vector);

  return;
}

/*
 * ioc_frame_return -
 * @frame:
 *
 * to be called only when a frame is waiting on an in-transit page
 */
void
ioc_frame_return (call_frame_t *frame)
{
  ioc_local_t *local = frame->local;
  int32_t wait_count;
  assert (local->wait_count > 0);

  ioc_local_lock (local);
  wait_count = --local->wait_count;
  ioc_local_unlock (local);

  if (!wait_count) {
    ioc_frame_unwind (frame);
  } 

  return;
}

/* 
 * ioc_page_wakeup -
 * @page:
 *
 * to be called only when a frame is waiting on an in-transit page
 */
void
ioc_page_wakeup (ioc_page_t *page)
{
  ioc_waitq_t *waitq = NULL, *trav = NULL;
  call_frame_t *frame = NULL;

  waitq = page->waitq;
  page->waitq = NULL;

  trav = waitq;
  page->ready = 1;
  gf_log (page->inode->table->xl->name, GF_LOG_DEBUG,
	  "page is %p && waitq = %p", page, waitq);
  
  for (trav = waitq; trav; trav = trav->next) {
    frame = trav->data; 
    ioc_frame_fill (page, frame, trav->pending_offset, trav->pending_size);
    /* we return to the frame, rest is left to frame to decide, 
     * whether to unwind or to wait for rest
     * of the region to be available */
    ioc_frame_return (frame);
  }

  for (trav = waitq; trav;) {
    ioc_waitq_t *next = trav->next;
    free (trav);
    trav = next;
  }
}


/*
 * ioc_page_error -
 * @page:
 * @op_ret:
 * @op_errno:
 *
 */
void
ioc_page_error (ioc_page_t *page,
		int32_t op_ret,
		int32_t op_errno)
{
  ioc_waitq_t *waitq = NULL, *trav = NULL;
  call_frame_t *frame = NULL;
  int64_t ret = 0;
  ioc_table_t *table = NULL;

  waitq = page->waitq;
  page->waitq = NULL;
  
  gf_log (page->inode->table->xl->name, GF_LOG_DEBUG,
	  "page error for page = %p & waitq = %p", page, waitq);

  for (trav = waitq; trav; trav = trav->next) {
    ioc_local_t *local = NULL;

    frame = trav->data;

    local = frame->local;
    ioc_local_lock (local);

    if (local->op_ret != -1) {
      local->op_ret = op_ret;
      local->op_errno = op_errno;
    }
    ioc_local_unlock (local);
    ioc_frame_return (frame);
  }

  for (trav = waitq; trav;) {
    ioc_waitq_t *next = trav->next;
    free (trav);
    trav = next;
  }

  table = page->inode->table;
  ret = ioc_page_destroy (page);

  if (ret != -1) {
    table->cache_used -= ret;
  }
}
