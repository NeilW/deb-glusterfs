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

#ifndef __IO_CACHE_H
#define __IO_CACHE_H

#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif


#include "glusterfs.h"
#include "logging.h"
#include "dict.h"
#include "xlator.h"
#include "common-utils.h"
#include "call-stub.h"
#include <sys/time.h>
#include <fnmatch.h>

#define IOC_PAGE_SIZE    (1024 * 128)   /* 128KB */
#define IOC_CACHE_SIZE   (32 * 1024 * 1024)

struct ioc_table;
struct ioc_local;
struct ioc_page;
struct ioc_inode;

struct ioc_priority {
  struct list_head list;
  char *pattern;
  uint32_t priority;
};

/*
 * ioc_waitq - this structure is used to represents the waiting 
 *             frames on a page
 *
 * @next: pointer to next object in waitq
 * @data: pointer to the frame which is waiting
 */
struct ioc_waitq {
  struct ioc_waitq *next;
  void *data;
  off_t pending_offset;
  size_t pending_size;
};

/*
 * ioc_fill - 
 *
 */
struct ioc_fill {
  struct list_head list;  /* list of ioc_fill structures of a frame */
  off_t offset;          
  size_t size;           
  struct iovec *vector;  
  int32_t count;
  dict_t *refs;
};

struct ioc_local {
  mode_t mode;
  int32_t flags;
  loc_t file_loc;
  off_t offset;
  size_t size;
  int32_t op_ret;
  int32_t op_errno;
  struct list_head fill_list;      /* list of ioc_fill structures */
  off_t pending_offset;            /* offset from this frame should continue */
  size_t pending_size;             /* size of data this frame is waiting on */
  struct ioc_inode *inode;
  int32_t wait_count;
  pthread_mutex_t local_lock;
  struct ioc_waitq *waitq;
  void *stub;
  fd_t *fd;
  
};

/*
 * ioc_page - structure to store page of data from file 
 *
 */
struct ioc_page {
  struct list_head pages;
  struct list_head page_lru;
  struct ioc_inode *inode;   /* inode this page belongs to */
  struct ioc_priority *priority;
  char dirty;
  char ready;
  struct iovec *vector;
  int32_t count;
  off_t offset;
  size_t size;
  struct ioc_waitq *waitq;
  dict_t *ref;
  pthread_mutex_t page_lock;
};

struct ioc_inode {
  struct ioc_table *table;
  struct list_head pages;      /* list of pages of this inode */
  struct list_head inode_list; /* list of inodes, maintained by io-cache translator */
  struct list_head inode_lru;
  struct list_head page_lru;
  struct ioc_waitq *waitq;
  pthread_mutex_t inode_lock;
  uint32_t weight;             /* weight of the inode, increases on each read */
  time_t mtime;             /* mtime of the server file when last cached */
  struct timeval tv;           /* time-stamp at last re-validate */
};

struct ioc_table {
  size_t page_size;
  uint64_t cache_size;
  uint64_t cache_used;
  struct list_head inodes; /* list of inodes cached */
  struct list_head active; 
  struct list_head *inode_lru;
  struct list_head priority_list;
  int32_t readv_count;
  pthread_mutex_t table_lock;
  xlator_t *xl;
  uint32_t inode_count;
  int32_t force_revalidate_timeout;
  int32_t max_pri;
};

typedef struct ioc_table ioc_table_t;
typedef struct ioc_local ioc_local_t;
typedef struct ioc_page ioc_page_t;
typedef struct ioc_inode ioc_inode_t;
typedef struct ioc_waitq ioc_waitq_t;
typedef struct ioc_fill ioc_fill_t;

void *
str_to_ptr (char *string);

char *
ptr_to_str (void *ptr);

int32_t 
ioc_readv_disabled_cbk (call_frame_t *frame,
			void *cookie,
			xlator_t *this,
			int32_t op_ret,
			int32_t op_errno,
			struct iovec *vector,
			int32_t count,
			struct stat *stbuf);

ioc_page_t *
ioc_page_get (ioc_inode_t *ioc_inode,
	      off_t offset);

ioc_page_t *
ioc_page_create (ioc_inode_t *ioc_inode,
		 off_t offset);

void
ioc_page_fault (ioc_inode_t *ioc_inode,
		call_frame_t *frame,
		fd_t *fd,
		off_t offset);
void
ioc_wait_on_page (ioc_page_t *page,
		  call_frame_t *frame,
		  off_t offset,
		  size_t size);

void
ioc_page_wakeup (ioc_page_t *page);

void
ioc_page_flush (ioc_page_t *page);

void
ioc_page_error (ioc_page_t *page,
		int32_t op_ret,
		int32_t op_errno);
void
ioc_page_purge (ioc_page_t *page);

ioc_inode_t *
ioc_inode_ref (ioc_inode_t *ioc_inode);

void
ioc_inode_unref (ioc_inode_t *ioc_inode);

void
ioc_inode_unref_locked (ioc_inode_t *ioc_inode);

void
ioc_frame_return (call_frame_t *frame);

void
ioc_frame_fill (ioc_page_t *page,
		call_frame_t *frame,
		off_t offset,
		size_t size);

#define ioc_inode_lock(ioc_inode)                     \
do {                                                  \
  gf_log (ioc_inode->table->xl->name, GF_LOG_DEBUG,   \
	  "locked inode(%p)", ioc_inode);             \
  pthread_mutex_lock (&ioc_inode->inode_lock);        \
} while (0)


#define ioc_inode_unlock(ioc_inode)                   \
do {                                                  \
  gf_log (ioc_inode->table->xl->name, GF_LOG_DEBUG,   \
	  "unlocked inode(%p)", ioc_inode);           \
  pthread_mutex_unlock (&ioc_inode->inode_lock);      \
} while (0)


#define ioc_table_lock(table)                         \
do {                                                  \
  gf_log (table->xl->name, GF_LOG_DEBUG,              \
	  "locked table(%p)", table);                 \
  pthread_mutex_lock (&table->table_lock);            \
} while (0)


#define ioc_table_unlock(table)                       \
do {                                                  \
  gf_log (table->xl->name, GF_LOG_DEBUG,              \
	  "unlocked table(%p)", table);               \
  pthread_mutex_unlock (&table->table_lock);          \
} while (0)


#define ioc_local_lock(local)                          \
do {                                                   \
  gf_log (local->inode->table->xl->name, GF_LOG_DEBUG, \
	  "locked local(%p)", local);                  \
  pthread_mutex_lock (&local->local_lock);             \
} while (0)


#define ioc_local_unlock(local)                        \
do {                                                   \
  gf_log (local->inode->table->xl->name, GF_LOG_DEBUG, \
	  "unlocked local(%p)", local);                \
  pthread_mutex_unlock (&local->local_lock);           \
} while (0)


#define ioc_page_lock(page)                            \
do {                                                   \
  gf_log (page->inode->table->xl->name, GF_LOG_DEBUG,  \
	  "locked page(%p)", page);                    \
  pthread_mutex_lock (&page->page_lock);               \
} while (0)


#define ioc_page_unlock(page)                          \
do {                                                   \
  gf_log (page->inode->table->xl->name, GF_LOG_DEBUG,  \
	  "unlocked page(%p)", page);                  \
  pthread_mutex_unlock (&page->page_lock);             \
} while (0)


static inline uint64_t
time_elapsed (struct timeval *now,
	      struct timeval *then)
{
  uint64_t sec = now->tv_sec - then->tv_sec;

  if (sec)
    return sec;
  
  return 0;
}

ioc_inode_t *
ioc_inode_search (ioc_table_t *table,
		  inode_t *inode);

void 
ioc_inode_destroy (ioc_inode_t *ioc_inode);

ioc_inode_t *
ioc_inode_update (ioc_table_t *table,
		  inode_t *inode,
		  uint32_t weight);

int64_t 
ioc_page_destroy (ioc_page_t *page);

int32_t
__ioc_inode_flush (ioc_inode_t *ioc_inode);

void
ioc_inode_flush (ioc_inode_t *ioc_inode);

void
ioc_inode_wakeup (call_frame_t *frame, 
		  ioc_inode_t *ioc_inode, 
		  struct stat *stbuf);

int8_t
ioc_cache_still_valid (ioc_inode_t *ioc_inode,
		       struct stat *stbuf);

int32_t
ioc_prune (ioc_table_t *table);

int32_t
ioc_need_prune (ioc_table_t *table);

#endif /* __READ_AHEAD_H */
