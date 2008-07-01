/*
   Copyright (c) 2006, 2007, 2008 Z RESEARCH, Inc. <http://www.zresearch.com>
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
#include "common-utils.h"


struct wb_conf;
struct wb_page;
struct wb_file;

struct wb_conf {
  size_t aggregate_size;
  char flush_behind;
};

struct wb_page {
  struct wb_page *next;
  struct wb_page *prev;
  struct wb_file *file;
  off_t offset;
  struct iovec *vector;
  int32_t count;
  dict_t *refs;
};

struct wb_file {
  int disabled;
  int disable_till;
  off_t offset;
  size_t size;
  int32_t refcount;
  int32_t op_ret;
  int32_t op_errno;
  struct wb_page pages;
  fd_t *fd;
  gf_lock_t lock;
};

typedef struct wb_conf wb_conf_t;
typedef struct wb_page wb_page_t;
typedef struct wb_file wb_file_t;

wb_file_t *
wb_file_ref (wb_file_t *file)
{
  LOCK (&file->lock);
  file->refcount++;
  UNLOCK (&file->lock);
  return file;
}

void
wb_file_unref (wb_file_t *file)
{
  int32_t refcount;

  LOCK (&file->lock);
  refcount = --file->refcount;
  UNLOCK (&file->lock);

  if (!refcount) {
      wb_page_t *page = file->pages.next;

      while (page != &file->pages) {
	wb_page_t *next = page->next;
	
	page->prev->next = page->next;
	page->next->prev = page->prev;
	
	if (page->vector)
	  free (page->vector);
	freee (page);
	
	page = next;
      }
      file->offset = 0;
      file->size = 0;

      LOCK_DESTROY (&file->lock);
      freee (file);
  }
}

int32_t
wb_sync_cbk (call_frame_t *frame,
             void *cookie,
             xlator_t *this,
             int32_t op_ret,
             int32_t op_errno,
	     struct stat *stbuf)
{
  wb_file_t *file = frame->local;

  if (op_ret == -1) {
    file->op_ret = op_ret;
    file->op_errno = op_errno;
  }

  frame->local = NULL;
  //  file->fd->inode->buf = *stbuf;

  wb_file_unref (file);

  STACK_DESTROY (frame->root);
  return 0;
}

int32_t
wb_sync (call_frame_t *frame,
         wb_file_t *file)
{
  size_t total_count = 0;
  size_t copied = 0;
  wb_page_t *page = file->pages.next;
  struct iovec *vector;
  call_frame_t *wb_frame;
  off_t offset;
  dict_t *refs;

  while (page != &file->pages) {
    total_count += page->count;
    page = page->next;
  }

  if (!total_count)
    return 0;

  vector = malloc (VECTORSIZE (total_count));

  page = file->pages.next;
  offset = file->pages.next->offset;

  refs = get_new_dict ();
  refs->is_locked = 1;

  while (page != &file->pages) {
    wb_page_t *next = page->next;
    size_t bytecount = VECTORSIZE (page->count);

    memcpy (((char *)vector)+copied,
	    page->vector,
	    bytecount);
    copied += bytecount;

    page->prev->next = page->next;
    page->next->prev = page->prev;

    dict_copy (page->refs, refs);
    dict_unref (page->refs);
    freee (page->vector);
    freee (page);

    page = next;
  }

  wb_frame = copy_frame (frame);
  wb_frame->local = wb_file_ref (file);
  wb_frame->root->req_refs = dict_ref (refs);

  STACK_WIND (wb_frame,
              wb_sync_cbk,
              FIRST_CHILD(wb_frame->this),
              FIRST_CHILD(wb_frame->this)->fops->writev,
              file->fd,
              vector,
              total_count,
              offset);

  dict_unref (refs);

  file->offset = 0;
  file->size = 0;

  freee (vector);
  return 0;
}

int32_t 
wb_stat_cbk (call_frame_t *frame,
             void *cookie,
             xlator_t *this,
             int32_t op_ret,
             int32_t op_errno,
             struct stat *buf)
{
  STACK_UNWIND (frame, 
                op_ret, 
                op_errno, 
                buf);

  return 0;
}

int32_t
wb_stat (call_frame_t *frame,
         xlator_t *this,
         loc_t *loc)
{
  wb_file_t *file = NULL;
  fd_t *iter_fd = NULL;

  if (loc->inode) {
    LOCK (&(loc->inode->lock));
    {
      list_for_each_entry (iter_fd, &(loc->inode->fds), inode_list) {
	if (dict_get (iter_fd->ctx, this->name)) {
	  file = data_to_ptr (dict_get (iter_fd->ctx, this->name));
	  break;
	}
      }
    }
    UNLOCK (&(loc->inode->lock));
    if (file)
      wb_sync (frame, file);
  }

  STACK_WIND (frame,
              wb_stat_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->stat,
              loc);
  return 0;
}

int32_t 
wb_fstat (call_frame_t *frame,
          xlator_t *this,
          fd_t *fd)
{
  wb_file_t *file;
  
  if (!dict_get (fd->ctx, this->name)) {
    gf_log (this->name, GF_LOG_ERROR, "returning EBADFD");
    STACK_UNWIND (frame, -1, EBADFD, NULL);
    return 0;
  }

  file = data_to_ptr (dict_get (fd->ctx, this->name));
  wb_sync (frame, file);

  /*
  list_for_each_entry (iter_fd, &(file->fd->inode->fds), inode_list) {
    wb_file_t *iter_file;
    if (dict_get (iter_fd->ctx, this->name)) {
      iter_file = data_to_ptr (dict_get (iter_fd->ctx, this->name));
      wb_sync (frame, iter_file);
    }
  }
  */

  STACK_WIND (frame,
              wb_stat_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->fstat,
              fd);
  return 0;
}

int32_t
wb_truncate_cbk (call_frame_t *frame,
                 void *cookie,
                 xlator_t *this,
                 int32_t op_ret,
                 int32_t op_errno,
                 struct stat *buf)
{
  STACK_UNWIND (frame,
                op_ret,
                op_errno,
                buf);
  return 0;
}

int32_t 
wb_truncate (call_frame_t *frame,
             xlator_t *this,
             loc_t *loc,
             off_t offset)
{
  wb_file_t *file = NULL;
  fd_t *iter_fd = NULL;

  if (loc->inode) {
    LOCK (&(loc->inode->lock));
    {
      list_for_each_entry (iter_fd, &(loc->inode->fds), inode_list) {
	if (dict_get (iter_fd->ctx, this->name)) {
	  file = data_to_ptr (dict_get (iter_fd->ctx, this->name));
	  break;
	}
      }
    }
    UNLOCK (&(loc->inode->lock));
    
    if (file && (file->offset > offset))
      wb_sync (frame, file);
  }
  
  STACK_WIND (frame,
              wb_truncate_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->truncate,
              loc,
              offset);
  return 0;
}

int32_t
wb_ftruncate (call_frame_t *frame,
              xlator_t *this,
              fd_t *fd,
              off_t offset)
{
  wb_file_t *file;

  if (!dict_get (fd->ctx, this->name)) {
    gf_log (this->name, GF_LOG_ERROR, "returning EBADFD");
    STACK_UNWIND (frame, -1, EBADFD, NULL);
    return 0;
  }

  file = data_to_ptr (dict_get (fd->ctx, this->name));

  /*
  list_for_each_entry (iter_fd, &(file->fd->inode->fds), inode_list) {
    wb_file_t *iter_file;

    if (dict_get (iter_fd->ctx, this->name)) {
      iter_file = data_to_ptr (dict_get (iter_fd->ctx, this->name));

      wb_sync (frame, iter_file); 
    }
  }
  */

  if (file->offset > offset)
    wb_sync (frame, file);

  STACK_WIND (frame,
              wb_truncate_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->ftruncate,
              fd,
              offset);
  return 0;
} 

int32_t 
wb_utimens_cbk (call_frame_t *frame,
                void *cookie,
                xlator_t *this,
                int32_t op_ret,
                int32_t op_errno,
                struct stat *buf)
{
  STACK_UNWIND (frame,
                op_ret,
                op_errno,
                buf);
  return 0;
}

int32_t 
wb_utimens (call_frame_t *frame,
            xlator_t *this,
            loc_t *loc,
            struct timespec tv[2])
{
  wb_file_t *file = NULL;
  fd_t *iter_fd = NULL;

  if (loc->inode) {
    LOCK (&(loc->inode->lock));
    {
      list_for_each_entry (iter_fd, &(loc->inode->fds), inode_list) {
	if (dict_get (iter_fd->ctx, this->name)) {
	  file = data_to_ptr (dict_get (iter_fd->ctx, this->name));
	  break;
	}
      }
    }
    UNLOCK (&(loc->inode->lock));

    if (file) 
      wb_sync (frame, file);
  }

  STACK_WIND (frame,
              wb_utimens_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->utimens,
              loc,
              tv);
  return 0;
}

int32_t
wb_open_cbk (call_frame_t *frame,
             void *cookie,
             xlator_t *this,
             int32_t op_ret,
             int32_t op_errno,
             fd_t *fd)
{
  int32_t flags;
  if (op_ret != -1) {
    wb_file_t *file = calloc (1, sizeof (*file));

    file->pages.next = &file->pages;
    file->pages.prev = &file->pages;
    file->fd= fd;
    file->disable_till = 1048576;

    dict_set (fd->ctx,
	      this->name,
	      data_from_static_ptr (file));

    /* If mandatory locking has been enabled on this file,
       we disable caching on it */

    if ((fd->inode->st_mode & S_ISGID) && !(fd->inode->st_mode & S_IXGRP))
      file->disabled = 1;

    /* If O_DIRECT then, we disable chaching */
    if (frame->local) {
      flags = *((int32_t *)frame->local);
      if (flags & O_DIRECT)
        file->disabled = 1;
    }
    LOCK_INIT (&file->lock);
    wb_file_ref (file);
  }

  STACK_UNWIND (frame, op_ret, op_errno, fd);
  return 0;
}

int32_t
wb_open (call_frame_t *frame,
         xlator_t *this,
         loc_t *loc,
         int32_t flags,
	 fd_t *fd)
{
  frame->local = calloc (1, sizeof(int32_t));
  *((int32_t *)frame->local) = flags;
  STACK_WIND (frame,
              wb_open_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->open,
              loc,
              flags,
	      fd);
  return 0;
}

int32_t
wb_create_cbk (call_frame_t *frame,
               void *cookie,
               xlator_t *this,
               int32_t op_ret,
               int32_t op_errno,
               fd_t *fd,
               inode_t *inode,
               struct stat *buf)
{
  if (op_ret != -1) {
    wb_file_t *file = calloc (1, sizeof (*file));

    file->pages.next = &file->pages;
    file->pages.prev = &file->pages;
    file->fd= fd;
    file->disable_till = 1048576;

    dict_set (fd->ctx,
              this->name,
              data_from_static_ptr (file));

    /* 
     * If mandatory locking has been enabled on this file,
     * we disable caching on it
     */
    if ((fd->inode->st_mode & S_ISGID) && 
	!(fd->inode->st_mode & S_IXGRP)) {
      file->disabled = 1;
    }

    LOCK_INIT (&file->lock);
    wb_file_ref (file);
  }

  STACK_UNWIND (frame,
                op_ret,
                op_errno,
                fd,
                inode,
                buf);
  return 0;
}

int32_t
wb_create (call_frame_t *frame,
           xlator_t *this,
	   loc_t *loc,
           int32_t flags,
           mode_t mode,
	   fd_t *fd)
{
  STACK_WIND (frame,
              wb_create_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->create,
	      loc,
              flags,
              mode,
	      fd);
  return 0;
}

int32_t 
wb_writev_cbk (call_frame_t *frame,
               void *cookie,
               xlator_t *this,
               int32_t op_ret,
               int32_t op_errno,
	       struct stat *stbuf)
{
  GF_ERROR_IF_NULL (this);

  STACK_UNWIND (frame, op_ret, op_errno, stbuf);
  return 0;
}

int32_t
wb_writev (call_frame_t *frame,
           xlator_t *this,
           fd_t *fd,
           struct iovec *vector,
           int32_t count,
           off_t offset)
{
  wb_file_t *file;
  wb_conf_t *conf = this->private;
  call_frame_t *wb_frame;
  dict_t *ref = NULL;
  struct stat buf = {0, };
  size_t size = iov_length (vector, count);

  if (!dict_get (fd->ctx, this->name)) {
    gf_log (this->name, GF_LOG_ERROR, "returning EBADFD");
    STACK_UNWIND (frame, -1, EBADFD, NULL);
    return 0;
  }

  file = data_to_ptr (dict_get (fd->ctx, this->name));
  
  if (file->disabled || file->disable_till) {
    if (size > file->disable_till) {
      file->disable_till = 0;
    } else {
      file->disable_till -= size;
    }

    STACK_WIND (frame, 
                wb_writev_cbk,
                FIRST_CHILD (frame->this), 
                FIRST_CHILD (frame->this)->fops->writev,
                file->fd, 
                vector, 
                count, 
                offset);
    return 0;
  }

  if (file->op_ret == -1) {
    /* delayed error delivery */
    gf_log (this->name, GF_LOG_ERROR, "delayed error : %d", file->op_errno);
    STACK_UNWIND (frame, -1, file->op_errno, &buf);
    file->op_ret = 0;
    return 0;
  }

  if (offset != file->offset)
    wb_sync (frame, file);

  wb_frame = copy_frame (frame);
  ref = dict_ref (frame->root->req_refs);

  /* FIXME: sending back a dummy stat buffer */
  STACK_UNWIND (frame, iov_length (vector, count), 0, &buf); /* liar! liar! :O */

  file->offset = (offset + iov_length (vector, count));
  {
    wb_page_t *page = calloc (1, sizeof (*page));

    page->vector = iov_dup (vector, count);
    page->count = count;
    page->offset = offset;
    page->refs = ref;

    page->next = &file->pages;
    page->prev = file->pages.prev;
    page->next->prev = page;
    page->prev->next = page;

    file->size += iov_length (vector, count);
  }

  if (file->size >= conf->aggregate_size) {
    wb_sync (wb_frame, file);
  }

  STACK_DESTROY (wb_frame->root);
  return 0;
}

int32_t
wb_readv_cbk (call_frame_t *frame,
              void *cookie,
              xlator_t *this,
              int32_t op_ret,
              int32_t op_errno,
              struct iovec *vector,
              int32_t count,
	      struct stat *stbuf)
{
  STACK_UNWIND (frame, op_ret, op_errno, vector, count, stbuf);
  return 0;
}

int32_t
wb_readv (call_frame_t *frame,
          xlator_t *this,
          fd_t *fd,
          size_t size,
          off_t offset)
{
  wb_file_t *file;

  if (!dict_get (fd->ctx, this->name)) {
    gf_log (this->name, GF_LOG_ERROR, "returning EBADFD");
    STACK_UNWIND (frame, -1, EBADFD, NULL);
    return 0;
  }

  file = data_to_ptr (dict_get (fd->ctx, this->name));
  wb_sync (frame, file);

  /*
  list_for_each_entry (iter_fd, &(file->fd->inode->fds), inode_list) {
    wb_file_t *iter_file;
    if (dict_get (iter_fd->ctx, this->name)) {
      iter_file = data_to_ptr (dict_get (iter_fd->ctx, this->name));
      wb_sync (frame, iter_file);
    }
  }
  */

  STACK_WIND (frame,
              wb_readv_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->readv,
              fd,
              size,
              offset);

  return 0;
}

int32_t
wb_ffr_cbk (call_frame_t *frame,
            void *cookie,
            xlator_t *this,
            int32_t op_ret,
            int32_t op_errno)
{
  wb_file_t *file = frame->local;
  if (file->op_ret == -1) {
    op_ret = file->op_ret;
    op_errno = file->op_errno;

    file->op_ret = 0;
  }

  frame->local = NULL;
  wb_file_unref (file);
  STACK_UNWIND (frame, op_ret, op_errno);
  return 0;
}

int32_t
wb_ffr_bg_cbk (call_frame_t *frame,
	       void *cookie,
	       xlator_t *this,
	       int32_t op_ret,
	       int32_t op_errno)
{
  wb_file_t *file = frame->local;

  if (file->op_ret == -1) {
    op_ret = file->op_ret;
    op_errno = file->op_errno;

    file->op_ret = 0;
  }
  
  frame->local = NULL;
  wb_file_unref (file);
  STACK_DESTROY (frame->root);
  return 0;
}


static int32_t
wb_flush (call_frame_t *frame,
          xlator_t *this,
          fd_t *fd)
{
  wb_conf_t *conf = this->private;
  wb_file_t *file;
  call_frame_t *flush_frame;

  if (!dict_get (fd->ctx, this->name)) {
    gf_log (this->name, GF_LOG_ERROR, "returning EBADFD");
    STACK_UNWIND (frame, -1, EBADFD);
    return 0;
  }

  file = data_to_ptr (dict_get (fd->ctx, this->name));

  if (conf->flush_behind && (!file->disabled)) {
    flush_frame = copy_frame (frame);
    
    STACK_UNWIND (frame, file->op_ret, file->op_errno); // liar! liar! :O

    flush_frame->local = wb_file_ref (file);

    wb_sync (flush_frame, file);

    STACK_WIND (flush_frame,
                wb_ffr_bg_cbk,
                FIRST_CHILD(this),
                FIRST_CHILD(this)->fops->flush,
                fd);
  } else {
    frame->local = wb_file_ref (file);
    
    wb_sync (frame, file);


    STACK_WIND (frame,
		wb_ffr_cbk,
		FIRST_CHILD(this),
		FIRST_CHILD(this)->fops->flush,
		fd);
  }

  return 0;
}

int32_t
wb_fsync (call_frame_t *frame,
          xlator_t *this,
          fd_t *fd,
          int32_t datasync)
{
  wb_file_t *file;

  if (!dict_get (fd->ctx, this->name)) {
    gf_log (this->name, GF_LOG_ERROR, "returning EBADFD");
    STACK_UNWIND (frame, -1, EBADFD);
    return 0;
  }

  file = data_to_ptr (dict_get (fd->ctx, this->name));
  wb_sync (frame, file);

  frame->local = wb_file_ref (file);

  STACK_WIND (frame,
              wb_ffr_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->fsync,
              fd,
              datasync);
  return 0;
}

int32_t
wb_close (call_frame_t *frame,
          xlator_t *this,
          fd_t *fd)
{
  wb_file_t *file;

  if (!dict_get (fd->ctx, this->name)) {
    gf_log (this->name, GF_LOG_ERROR, "returning EBADFD");
    STACK_UNWIND (frame, -1, EBADFD);
    return 0;
  }

  file = data_to_ptr (dict_get (fd->ctx, this->name));
  dict_del (fd->ctx, this->name);

  wb_sync (frame, file);

  frame->local = wb_file_ref (file);

  wb_file_unref (file);

  STACK_WIND (frame,
              wb_ffr_cbk,
              FIRST_CHILD(this),
              FIRST_CHILD(this)->fops->close,
              fd);
  return 0;
}

int32_t 
init (xlator_t *this)
{
  dict_t *options = this->options;
  wb_conf_t *conf;

  if (!this->children || this->children->next) {
    gf_log (this->name,
	    GF_LOG_ERROR,
	    "FATAL: write-behind (%s) not configured with exactly one child",
	    this->name);
    return -1;
  }

  conf = calloc (1, sizeof (*conf));

  conf->aggregate_size = 0;
  if (dict_get (options, "aggregate-size")) {
    conf->aggregate_size = gf_str_to_long_long (data_to_str (dict_get (options,
								       "aggregate-size")));
  }
  gf_log (this->name,
    GF_LOG_DEBUG,
    "using aggregate-size = %d", conf->aggregate_size);

  conf->flush_behind = 0;  
  if (dict_get (options, "flush-behind")) {
    if ((!strcasecmp (data_to_str (dict_get (options, "flush-behind")),
		      "on")) ||
	(!strcasecmp (data_to_str (dict_get (options, "flush-behind")),
		      "yes"))) {
      gf_log (this->name,
	      GF_LOG_DEBUG,
	      "%s: enabling flush-behind",
	      this->name);
      conf->flush_behind = 1;
    }
  }

  this->private = conf;
  return 0;
}

void
fini (xlator_t *this)
{
  wb_conf_t *conf = this->private;

  freee (conf);
  return;
}

struct xlator_fops fops = {
  .writev      = wb_writev,
  .open        = wb_open,
  .create      = wb_create,
  .readv       = wb_readv,
  .flush       = wb_flush,
  .fsync       = wb_fsync,
  .close       = wb_close,
  .stat        = wb_stat,
  .fstat       = wb_fstat,
  .truncate    = wb_truncate,
  .ftruncate   = wb_ftruncate,
  .utimens     = wb_utimens,
};

struct xlator_mops mops = {
};
