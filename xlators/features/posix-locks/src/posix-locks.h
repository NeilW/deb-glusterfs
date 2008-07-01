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

#ifndef __POSIX_LOCKS_H__
#define __POSIX_LOCKS_H__

#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif

#include "transport.h"
#include "stack.h"

struct __pl_fd;

struct __posix_lock {
  short fl_type;
  off_t fl_start;
  off_t fl_end;  

  short blocked;              /* waiting to acquire */
  struct flock *user_flock;   /* the flock supplied by the user */
  xlator_t *this;             /* required for blocked locks */
  fd_t *fd;

  struct __posix_lock *next;
  struct __posix_lock *prev;

  call_frame_t *frame;     

  /* These two together serve to uniquely identify each process
     across nodes */
  transport_t *transport;     /* to identify client node */
  pid_t client_pid;           /* pid of client process */
};
typedef struct __posix_lock posix_lock_t;

typedef enum {OP_READ, OP_WRITE} rw_op_t;
struct __pl_rw_req_t {
  call_frame_t *frame;
  xlator_t *this;
  fd_t *fd;
  rw_op_t op;
  struct iovec *vector; /* only for writev */
  int size;             /* for a readv, this is the size of the data we wish to read
                           for a writev, it is the count of struct iovec's */
  off_t offset;
  posix_lock_t *region;  
  struct __pl_rw_req_t *next;
  struct __pl_rw_req_t *prev;
};
typedef struct __pl_rw_req_t pl_rw_req_t;

/* The "simulated" inode. This contains a list of all the locks associated 
   with this file */

struct __pl_inode {
  posix_lock_t *locks;      /* list of locks on this inode */
  pl_rw_req_t *rw_reqs;     /* list of waiting r/w requests */
  int mandatory;            /* whether mandatory locking is enabled on this inode */
};
typedef struct __pl_inode pl_inode_t;

struct __pl_fd {
  int nonblocking;       /* whether O_NONBLOCK has been set */
};
typedef struct __pl_fd pl_fd_t;

typedef struct {
  pthread_mutex_t mutex;
  int mandatory;         /* true if mandatory locking is enabled */
} posix_locks_private_t;

#endif /* __POSIX_LOCKS_H__ */
