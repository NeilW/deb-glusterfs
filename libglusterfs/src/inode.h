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

#ifndef _INODE_H
#define _INODE_H

#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif

#include <stdint.h>
#include <sys/types.h>

struct _inode_table;
typedef struct _inode_table inode_table_t;

struct _inode;
typedef struct _inode inode_t;

#include "list.h"
#include "xlator.h"

struct _inode_table {
  pthread_mutex_t lock;
  size_t hashsize;
  char *name;
  inode_t *root;
  xlator_t *xl;
  uint32_t lru_limit, lru_size;
  struct list_head *inode_hash;
  struct list_head *name_hash;
  struct list_head active;
  struct list_head lru;         /* lru.prev is the least recently used */
};

struct _dentry {
  struct list_head inode_list;
  struct list_head name_hash;
  inode_t *inode;
  char *name;
  struct _inode *parent;
};

struct _inode {
  gf_lock_t lock;         /* used for ->fds */
  inode_table_t *table;   /* the view this inode belongs to */
  uint64_t nlookup;       /* number of lookups done */
  uint64_t generation;    /* generation */
  uint32_t ref;           /* references to this structure */
  ino_t ino;              /* inode number in the storage (persistent) */
  mode_t st_mode;         /* what kind of file */
  struct list_head fds;   /* list head of open fd's */
  dict_t *ctx;            /* per xlator private */
  //  struct stat buf;
  struct _dentry dentry;  /* name relation */
  struct list_head inode_hash;
  struct list_head list;  /* table->active or active->lru depending on ref */
  //  void *private;          /* to be used by the manager of inode_table_t */
}__attribute__((__packed__));

inode_table_t *
inode_table_new (size_t lru_limit, xlator_t *xl);

int32_t
inode_table_prune (inode_table_t *table, struct list_head *pick);

inode_t *
inode_search (inode_table_t *table,
	      ino_t ino,
	      const char *name);

inode_t *
inode_update (inode_table_t *table,
	      inode_t *parent,
	      const char *name,
	      struct stat *stbuf);

inode_t *
inode_parent (inode_t *inode, ino_t par);

inode_t *
inode_ref (inode_t *inode);

inode_t *
inode_unref (inode_t *inode);

inode_t *
inode_lookup (inode_t *inode);

inode_t *
inode_forget (inode_t *inode,
	      uint64_t nlookup);

inode_t *
inode_rename (inode_table_t *table,
	      inode_t *olddir,
	      const char *oldname,
	      inode_t *newdir,
	      const char *newname,
	      struct stat *stbuf);

void
inode_unlink (inode_table_t *table,
	      inode_t *parent,
	      const char *name);

size_t
inode_path (inode_t *inode,
	    const char *name,
	    char *buf,
	    size_t size);

void
inode_destroy (inode_t *inode);

void
inode_unhash_name (inode_table_t *table, inode_t *inode);
	      
#endif /* _INODE_H */
