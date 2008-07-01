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

#ifndef _COMMON_UTILS_H
#define _COMMON_UTILS_H

#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif

#include <stdint.h>
#include <sys/uio.h>
#include <netdb.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <pthread.h>
#ifndef GF_BSD_HOST_OS
#include <alloca.h>
#endif 

void trap (void);

#include "logging.h"
#include "glusterfs.h"

#define EEEEKS (void *)0xeeeeeeee

#ifdef DEBUG
#define TRAP_ON(cond) if (cond) { gf_log ("trapper", GF_LOG_CRITICAL, "condition `%s' asserted", #cond); trap (); }

#define freee(ptr) do { assert (ptr != EEEEKS); /* memset ((void *)ptr, 0xe, sizeof (*ptr)); */ free ((void *)ptr); ptr = EEEEKS; } while(0)

#else /* DEBUG */

#define freee(ptr) free((void *)ptr)
#define TRAP_ON(cond)

#endif /* DEBUG */

void set_global_ctx_ptr (glusterfs_ctx_t *ctx);
int32_t gf_full_read (int32_t fd, char *buf, int32_t size);
int32_t gf_full_write (int32_t fd, const char *buf, int32_t size);

int32_t gf_full_readv (int32_t fd, const struct iovec *vector, int32_t count);
int32_t gf_full_writev (int32_t fd, const struct iovec *vector, int32_t count);
in_addr_t gf_resolve_ip (const char *hostname, void **dnscache);
int64_t gf_str_to_long_long (const char *number);

void glusterfs_stats (int32_t signum);
#if HAVE_BACKTRACE
void gf_print_trace (int32_t signal);
#endif /* HAVE_BACKTRACE */

#define VECTORSIZE(count) (count * (sizeof (struct iovec)))

#if HAVE_SPINLOCK
#define LOCK_INIT(x)    pthread_spin_init (x, 0)
#define LOCK(x)         pthread_spin_lock (x)
#define UNLOCK(x)       pthread_spin_unlock (x)
#define LOCK_DESTROY(x) pthread_spin_destroy (x)
//#define LOCK_INITIALIZER PTHREAD_MUTEX_INITIALIZER

typedef pthread_spinlock_t gf_lock_t;
#else
#define LOCK_INIT(x)    pthread_mutex_init (x, 0)
#define LOCK(x)         pthread_mutex_lock (x)
#define UNLOCK(x)       pthread_mutex_unlock (x)
#define LOCK_DESTROY(x) pthread_mutex_destroy (x)
//#define LOCK_INITIALIZER PTHREAD_MUTEX_INITIALIZER

typedef pthread_mutex_t gf_lock_t;
#endif /* HAVE_SPINLOCK */

static inline void
iov_free (struct iovec *vector,
	  int32_t count)
{
  int i;

  for (i=0; i<count; i++)
    freee (vector[i].iov_base);

  freee (vector);
}

static inline int32_t
iov_length (const struct iovec *vector,
	    int32_t count)
{
  int32_t i;
  size_t size = 0;

  for (i=0; i<count; i++)
    size += vector[i].iov_len;

  return size;
}

static inline struct iovec *
iov_dup (struct iovec *vector,
	 int32_t count)
{
  int32_t bytecount = (count * sizeof (struct iovec));
  int32_t i;
  struct iovec *newvec = malloc (bytecount);

  for (i=0;i<count;i++) {
    newvec[i].iov_len = vector[i].iov_len;
    newvec[i].iov_base = vector[i].iov_base;
  }

  return newvec;
}

static inline int32_t
iov_subset (struct iovec *orig,
	    int32_t orig_count,
	    off_t src_offset,
	    off_t dst_offset,
	    struct iovec *new)
{
  int32_t new_count = 0;
  int32_t i;
  off_t offset = 0;

  for (i=0; i<orig_count; i++) {
    if ((offset + orig[i].iov_len >= src_offset) && 
	(offset <= dst_offset)) {
      if (new) {
	size_t start_offset = 0, end_offset = orig[i].iov_len;
	if (src_offset >= offset) {
	  start_offset = (src_offset - offset);
	}
	if (dst_offset <= (offset + orig[i].iov_len)) {
	  end_offset = (dst_offset - offset);
	}
	new[new_count].iov_base = orig[i].iov_base + start_offset;
	new[new_count].iov_len = end_offset - start_offset;
      }
      new_count++;
    }
    offset += orig[i].iov_len;
  }

  return new_count;
}

static inline void
iov_unload (char *buf,
	    const struct iovec *vector,
	    int32_t count)
{
  int32_t i;
  int32_t copied = 0;

  for (i=0; i<count; i++) {
    memcpy (buf + copied, vector[i].iov_base, vector[i].iov_len);
    copied += vector[i].iov_len;
  }
}

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))
#define roof(a,b) ((((a)+(b)-1)/((b)?(b):1))*(b))
#define floor(a,b) (((a)/((b)?(b):1))*(b))


static inline void *
memdup (const void *ptr, size_t size)
{
  void *newptr = malloc (size);
  memcpy (newptr, ptr, size);
  return newptr;
}

#endif /* _COMMON_UTILS_H */

