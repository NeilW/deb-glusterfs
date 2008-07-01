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

#ifndef _CALL_STUB_H_
#define _CALL_STUB_H_

#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif

#include "xlator.h"
#include "stack.h"
#include "list.h"

typedef struct {
  struct list_head list;
  char wind;
  call_frame_t *frame;
  glusterfs_fop_t fop;

  union {
    /* lookup */
    struct {
      fop_lookup_t fn;
      loc_t loc;
      int32_t need_xattr;
    } lookup;
    struct {
      fop_lookup_cbk_t fn;
      int32_t op_ret, op_errno;
      inode_t *inode;
      struct stat buf;
      dict_t *dict;
    } lookup_cbk;

    /* stat */
    struct {
      fop_stat_t fn;
      loc_t loc;
    } stat;
    struct {
      fop_stat_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } stat_cbk;

    /* fstat */
    struct {
      fop_fstat_t fn;
      fd_t *fd;
    } fstat;
    struct {
      fop_fstat_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } fstat_cbk;

    /* chmod */
    struct {
      fop_chmod_t fn;
      loc_t loc;
      mode_t mode;
    } chmod;
    struct {
      fop_chmod_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } chmod_cbk;

    /* fchmod */
    struct {
      fop_fchmod_t fn;
      fd_t *fd;
      mode_t mode;
    } fchmod;
    struct {
      fop_fchmod_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } fchmod_cbk;

    /* chown */
    struct {
      fop_chown_t fn;
      loc_t loc;
      uid_t uid;
      gid_t gid;
    } chown;
    struct {
      fop_chown_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } chown_cbk;

    /* fchown */
    struct {
      fop_fchown_t fn;
      fd_t *fd;
      uid_t uid;
      gid_t gid;
    } fchown;
    struct {
      fop_fchown_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } fchown_cbk;

    /* truncate */
    struct {
      fop_truncate_t fn;
      loc_t loc;
      off_t off;
    } truncate;
    struct {
      fop_truncate_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } truncate_cbk;

    /* ftruncate */
    struct {
      fop_ftruncate_t fn;
      fd_t *fd;
      off_t off;
    } ftruncate;
    struct {
      fop_ftruncate_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } ftruncate_cbk;

    /* utimens */
    struct {
      fop_utimens_t fn;
      loc_t loc;
      struct timespec tv[2];
    } utimens;
    struct {
      fop_utimens_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } utimens_cbk;

    /* access */
    struct {
      fop_access_t fn;
      loc_t loc;
      int32_t mask;
    } access;
    struct {
      fop_access_cbk_t fn;
      int32_t op_ret, op_errno;
    } access_cbk;

    /* readlink */
    struct {
      fop_readlink_t fn;
      loc_t loc;
      size_t size;
    } readlink;
    struct {
      fop_readlink_cbk_t fn;
      int32_t op_ret, op_errno;
      const char *buf;
    } readlink_cbk;

    /* mknod */
    struct {
      fop_mknod_t fn;
      loc_t loc;
      mode_t mode;
      dev_t rdev;
    } mknod;
    struct {
      fop_mknod_cbk_t fn;
      int32_t op_ret, op_errno;
      inode_t *inode;
      struct stat buf;
    } mknod_cbk;

    /* mkdir */
    struct {
      fop_mkdir_t fn;
      loc_t loc;
      mode_t mode;
    } mkdir;
    struct {
      fop_mkdir_cbk_t fn;
      int32_t op_ret, op_errno;
      inode_t *inode;
      struct stat buf;
    } mkdir_cbk;

    /* unlink */
    struct {
      fop_unlink_t fn;
      loc_t loc;
    } unlink;
    struct {
      fop_unlink_cbk_t fn;
      int32_t op_ret, op_errno;
    } unlink_cbk;

    /* rmdir */
    struct {
      fop_rmdir_t fn;
      loc_t loc;
    } rmdir;
    struct {
      fop_rmdir_cbk_t fn;
      int32_t op_ret, op_errno;
    } rmdir_cbk;

    /* symlink */
    struct {
      fop_symlink_t fn;
      const char *linkname;
      loc_t loc;
    } symlink;
    struct {
      fop_symlink_cbk_t fn;
      int32_t op_ret, op_errno;
      inode_t *inode;
      struct stat buf;
    } symlink_cbk;

    /* rename */
    struct {
      fop_rename_t fn;
      loc_t old;
      loc_t new;
    } rename;
    struct {
      fop_rename_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat buf;
    } rename_cbk;

    /* link */
    struct {
      fop_link_t fn;
      loc_t oldloc;
      const char *newpath;
    } link;
    struct {
      fop_link_cbk_t fn;
      int32_t op_ret, op_errno;
      inode_t *inode;
      struct stat buf;
    } link_cbk;

    /* create */
    struct {
      fop_create_t fn;
      loc_t loc;
      int32_t flags;
      mode_t mode;
      fd_t *fd;
    } create;
    struct {
      fop_create_cbk_t fn;
      int32_t op_ret, op_errno;
      fd_t *fd;
      inode_t *inode;
      struct stat buf;
    } create_cbk;

    /* open */
    struct {
      fop_open_t fn;
      loc_t loc;
      int32_t flags;
      fd_t *fd;
    } open;
    struct {
      fop_open_cbk_t fn;
      int32_t op_ret, op_errno;
      fd_t *fd;
    } open_cbk;

    /* readv */
    struct {
      fop_readv_t fn;
      fd_t *fd;
      size_t size;
      off_t off;
    } readv;
    struct {
      fop_readv_cbk_t fn;
      int32_t op_ret;
      int32_t op_errno;
      struct iovec *vector;
      int32_t count;
      struct stat stbuf;
    } readv_cbk;

    /* writev */
    struct {
      fop_writev_t fn;
      fd_t *fd;
      struct iovec *vector;
      int32_t count;
      off_t off;
    } writev;
    struct {
      fop_writev_cbk_t fn;
      int32_t op_ret, op_errno;
      struct stat stbuf;
    } writev_cbk;

    /* flush */
    struct {
      fop_flush_t fn;
      fd_t *fd;
    } flush;
    struct {
      fop_flush_cbk_t fn;
      int32_t op_ret, op_errno;
    } flush_cbk;

    /* close */
    struct {
      fop_close_t fn;
      fd_t *fd;
    } close;
    struct {
      fop_close_cbk_t fn;
      int32_t op_ret, op_errno;
    } close_cbk;

    /* fsync */
    struct {
      fop_fsync_t fn;
      fd_t *fd;
      int32_t datasync;
    } fsync;
    struct {
      fop_fsync_cbk_t fn;
      int32_t op_ret, op_errno;
    } fsync_cbk;

    /* opendir */
    struct {
      fop_opendir_t fn;
      loc_t loc;
      fd_t *fd;
    } opendir;
    struct {
      fop_opendir_cbk_t fn;
      int32_t op_ret, op_errno;
      fd_t *fd;
    } opendir_cbk;

    /* getdents */
    struct {
      fop_getdents_t fn;
      fd_t *fd;
      size_t size;
      off_t off;
      int32_t flag;
    } getdents;
    struct {
      fop_getdents_cbk_t fn;
      int32_t op_ret;
      int32_t op_errno;
      dir_entry_t entries;
      int32_t count;
    } getdents_cbk;

    /* setdents */
    struct {
      fop_setdents_t fn;
      fd_t *fd;
      int32_t flags;
      dir_entry_t entries;
      int32_t count;
    } setdents;
    struct {
      fop_setdents_cbk_t fn;
      int32_t op_ret;
      int32_t op_errno;
    } setdents_cbk;

    /* closedir */
    struct {
      fop_closedir_t fn;
      fd_t *fd;
    } closedir;
    struct {
      fop_closedir_cbk_t fn;
      int32_t op_ret, op_errno;
    } closedir_cbk;

    /* fsyncdir */
    struct {
      fop_fsyncdir_t fn;
      fd_t *fd;
      int32_t datasync;
    } fsyncdir;
    struct {
      fop_fsyncdir_cbk_t fn;
      int32_t op_ret, op_errno;
    } fsyncdir_cbk;

    /* statfs */
    struct {
      fop_statfs_t fn;
      loc_t loc;
    } statfs;
    struct {
      fop_statfs_cbk_t fn;
      int32_t op_ret, op_errno;
      struct statvfs buf;
    } statfs_cbk;

    /* setxattr */
    struct {
      fop_setxattr_t fn;
      loc_t loc;
      dict_t *dict;
      int32_t flags;
    } setxattr;
    struct {
      fop_setxattr_cbk_t fn;
      int32_t op_ret, op_errno;
    } setxattr_cbk;

    /* getxattr */
    struct {
      fop_getxattr_t fn;
      loc_t loc;
    } getxattr;
    struct {
      fop_getxattr_cbk_t fn;
      int32_t op_ret, op_errno;
      dict_t *dict;
    } getxattr_cbk;

    /* removexattr */
    struct {
      fop_removexattr_t fn;
      loc_t loc;
      const char *name;
    } removexattr;
    struct {
      fop_removexattr_cbk_t fn;
      int32_t op_ret, op_errno;
    } removexattr_cbk;

    /* lk */
    struct {
      fop_lk_t fn;
      fd_t *fd;
      int32_t cmd;
      struct flock lock;
    } lk;
    struct {
      fop_lk_cbk_t fn;
      int32_t op_ret, op_errno;
      struct flock lock;
    } lk_cbk;

    /* readdir */
    struct {
      fop_readdir_t fn;
      fd_t *fd;
      size_t size;
      off_t off;
    } readdir;
    struct {
      fop_readdir_cbk_t fn;
      int32_t op_ret, op_errno;
      gf_dirent_t *entries;
    } readdir_cbk;
  } args;
} call_stub_t;

call_stub_t *
fop_lookup_stub (call_frame_t *frame,
		 fop_lookup_t fn,
		 loc_t *loc,
		 int32_t need_xattr);

call_stub_t *
fop_lookup_cbk_stub (call_frame_t *frame,
		     fop_lookup_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno,
		     inode_t *inode,
		     struct stat *buf,
		     dict_t *dict);
call_stub_t *
fop_stat_stub (call_frame_t *frame,
	       fop_stat_t fn,
	       loc_t *loc);
call_stub_t *
fop_stat_cbk_stub (call_frame_t *frame,
		   fop_stat_cbk_t fn,
		   int32_t op_ret,
		   int32_t op_errno,
		   struct stat *buf);
call_stub_t *
fop_fstat_stub (call_frame_t *frame,
		fop_fstat_t fn,
		fd_t *fd);
call_stub_t *
fop_fstat_cbk_stub (call_frame_t *frame,
		    fop_fstat_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno,
		    struct stat *buf);
call_stub_t *
fop_chmod_stub (call_frame_t *frame,
		fop_chmod_t fn,
		loc_t *loc,
		mode_t mode);
call_stub_t *
fop_chmod_cbk_stub (call_frame_t *frame,
		    fop_chmod_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno,
		    struct stat *buf);
call_stub_t *
fop_fchmod_stub (call_frame_t *frame,
		 fop_fchmod_t fn,
		 fd_t *fd,
		 mode_t mode);
call_stub_t *
fop_fchmod_cbk_stub (call_frame_t *frame,
		     fop_fchmod_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno,
		     struct stat *buf);
call_stub_t *
fop_chown_stub (call_frame_t *frame,
		fop_chown_t fn,
		loc_t *loc,
		uid_t uid,
		gid_t gid);

call_stub_t *
fop_chown_cbk_stub (call_frame_t *frame,
		    fop_chown_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno,
		    struct stat *buf);

call_stub_t *
fop_fchown_stub (call_frame_t *frame,
		 fop_fchown_t fn,
		 fd_t *fd,
		 uid_t uid,
		 gid_t gid);

call_stub_t *
fop_fchown_cbk_stub (call_frame_t *frame,
		     fop_fchown_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno,
		     struct stat *buf);

call_stub_t *
fop_truncate_stub (call_frame_t *frame,
		   fop_truncate_t fn,
		   loc_t *loc,
		   off_t off);

call_stub_t *
fop_truncate_cbk_stub (call_frame_t *frame,
		       fop_truncate_cbk_t fn,
		       int32_t op_ret,
		       int32_t op_errno,
		       struct stat *buf);

call_stub_t *
fop_ftruncate_stub (call_frame_t *frame,
		    fop_ftruncate_t fn,
		    fd_t *fd,
		    off_t off);

call_stub_t *
fop_ftruncate_cbk_stub (call_frame_t *frame,
			fop_ftruncate_cbk_t fn,
			int32_t op_ret,
			int32_t op_errno,
			struct stat *buf);

call_stub_t *
fop_utimens_stub (call_frame_t *frame,
		  fop_utimens_t fn,
		  loc_t *loc,
		  struct timespec tv[2]);

call_stub_t *
fop_utimens_cbk_stub (call_frame_t *frame,
		      fop_utimens_cbk_t fn,
		      int32_t op_ret,
		      int32_t op_errno,
		      struct stat *buf);

call_stub_t *
fop_access_stub (call_frame_t *frame,
		 fop_access_t fn,
		 loc_t *loc,
		 int32_t mask);

call_stub_t *
fop_access_cbk_stub (call_frame_t *frame,
		     fop_access_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno);

call_stub_t *
fop_readlink_stub (call_frame_t *frame,
		   fop_readlink_t fn,
		   loc_t *loc,
		   size_t size);

call_stub_t *
fop_readlink_cbk_stub (call_frame_t *frame,
		       fop_readlink_cbk_t fn,
		       int32_t op_ret,
		       int32_t op_errno,
		       const char *path);

call_stub_t *
fop_mknod_stub (call_frame_t *frame,
		fop_mknod_t fn,
		loc_t *loc,
		mode_t mode,
		dev_t rdev);

call_stub_t *
fop_mknod_cbk_stub (call_frame_t *frame,
		    fop_mknod_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno,
		    inode_t *inode,
		    struct stat *buf);

call_stub_t *
fop_mkdir_stub (call_frame_t *frame,
		fop_mkdir_t fn,
		loc_t *loc,
		mode_t mode);

call_stub_t *
fop_mkdir_cbk_stub (call_frame_t *frame,
		    fop_mkdir_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno,
		    inode_t *inode,
		    struct stat *buf);

call_stub_t *
fop_unlink_stub (call_frame_t *frame,
		 fop_unlink_t fn,
		 loc_t *loc);

call_stub_t *
fop_unlink_cbk_stub (call_frame_t *frame,
		     fop_unlink_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno);

call_stub_t *
fop_rmdir_stub (call_frame_t *frame,
		fop_rmdir_t fn,
		loc_t *loc);

call_stub_t *
fop_rmdir_cbk_stub (call_frame_t *frame,
		    fop_rmdir_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno);

call_stub_t *
fop_symlink_stub (call_frame_t *frame,
		  fop_symlink_t fn,
		  const char *linkname,
		  loc_t *loc);

call_stub_t *
fop_symlink_cbk_stub (call_frame_t *frame,
		      fop_symlink_cbk_t fn,
		      int32_t op_ret,
		      int32_t op_errno,
		      inode_t *inode,
		      struct stat *buf);

call_stub_t *
fop_rename_stub (call_frame_t *frame,
		 fop_rename_t fn,
		 loc_t *oldloc,
		 loc_t *newloc);

call_stub_t *
fop_rename_cbk_stub (call_frame_t *frame,
		     fop_rename_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno,
		     struct stat *buf);

call_stub_t *
fop_link_stub (call_frame_t *frame,
	       fop_link_t fn,
	       loc_t *oldloc,
	       const char *newpath);

call_stub_t *
fop_link_cbk_stub (call_frame_t *frame,
		   fop_link_cbk_t fn,
		   int32_t op_ret,
		   int32_t op_errno,
		   inode_t *inode,
		   struct stat *buf);

call_stub_t *
fop_create_stub (call_frame_t *frame,
		 fop_create_t fn,
		 loc_t *loc,
		 int32_t flags,
		 mode_t mode, fd_t *fd);

call_stub_t *
fop_create_cbk_stub (call_frame_t *frame,
		     fop_create_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno,
		     fd_t *fd,
		     inode_t *inode,
		     struct stat *buf);

call_stub_t *
fop_open_stub (call_frame_t *frame,
	       fop_open_t fn,
	       loc_t *loc,
	       int32_t flags,
	       fd_t *fd);

call_stub_t *
fop_open_cbk_stub (call_frame_t *frame,
		   fop_open_cbk_t fn,
		   int32_t op_ret,
		   int32_t op_errno,
		   fd_t *fd);

call_stub_t *
fop_readv_stub (call_frame_t *frame,
		fop_readv_t fn,
		fd_t *fd,
		size_t size,
		off_t off);

call_stub_t *
fop_readv_cbk_stub (call_frame_t *frame,
		    fop_readv_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno,
		    struct iovec *vector,
		    int32_t count,
		    struct stat *stbuf);

call_stub_t *
fop_writev_stub (call_frame_t *frame,
		 fop_writev_t fn,
		 fd_t *fd,
		 struct iovec *vector,
		 int32_t count,
		 off_t off);

call_stub_t *
fop_writev_cbk_stub (call_frame_t *frame,
		     fop_writev_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno,
		     struct stat *stbuf);

call_stub_t *
fop_flush_stub (call_frame_t *frame,
		fop_flush_t fn,
		fd_t *fd);

call_stub_t *
fop_flush_cbk_stub (call_frame_t *frame,
		    fop_flush_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno);

call_stub_t *
fop_close_stub (call_frame_t *frame,
		fop_close_t fn,
		fd_t *fd);

call_stub_t *
fop_close_cbk_stub (call_frame_t *frame,
		    fop_close_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno);

call_stub_t *
fop_fsync_stub (call_frame_t *frame,
		fop_fsync_t fn,
		fd_t *fd,
		int32_t datasync);

call_stub_t *
fop_fsync_cbk_stub (call_frame_t *frame,
		    fop_fsync_cbk_t fn,
		    int32_t op_ret,
		    int32_t op_errno);

call_stub_t *
fop_opendir_stub (call_frame_t *frame,
		  fop_opendir_t fn,
		  loc_t *loc, fd_t *fd);

call_stub_t *
fop_opendir_cbk_stub (call_frame_t *frame,
		      fop_opendir_cbk_t fn,
		      int32_t op_ret,
		      int32_t op_errno,
		      fd_t *fd);

call_stub_t *
fop_getdents_stub (call_frame_t *frame,
		   fop_getdents_t fn,
		   fd_t *fd,
		   size_t size,
		   off_t off,
		   int32_t flag);

call_stub_t *
fop_getdents_cbk_stub (call_frame_t *frame,
		      fop_getdents_cbk_t fn,
		      int32_t op_ret,
		      int32_t op_errno,
		      dir_entry_t *entries,
		      int32_t count);

call_stub_t *
fop_setdents_stub (call_frame_t *frame,
		   fop_setdents_t fn,
		   fd_t *fd,
		   int32_t flags,
		   dir_entry_t *entries,
		   int32_t count);

call_stub_t *
fop_setdents_cbk_stub (call_frame_t *frame,
		       fop_setdents_cbk_t fn,
		       int32_t op_ret,
		       int32_t op_errno);

call_stub_t *
fop_closedir_stub (call_frame_t *frame,
		   fop_closedir_t fn,
		   fd_t *fd);

call_stub_t *
fop_closedir_cbk_stub (call_frame_t *frame,
		       fop_closedir_cbk_t fn,
		       int32_t op_ret,
		       int32_t op_errno);

call_stub_t *
fop_fsyncdir_stub (call_frame_t *frame,
		   fop_fsyncdir_t fn,
		   fd_t *fd,
		   int32_t datasync);

call_stub_t *
fop_fsyncdir_cbk_stub (call_frame_t *frame,
		       fop_fsyncdir_cbk_t fn,
		       int32_t op_ret,
		       int32_t op_errno);

call_stub_t *
fop_statfs_stub (call_frame_t *frame,
		 fop_statfs_t fn,
		 loc_t *loc);

call_stub_t *
fop_statfs_cbk_stub (call_frame_t *frame,
		     fop_statfs_cbk_t fn,
		     int32_t op_ret,
		     int32_t op_errno,
		     struct statvfs *buf);

call_stub_t *
fop_setxattr_stub (call_frame_t *frame,
		   fop_setxattr_t fn,
		   loc_t *loc,
		   dict_t *dict,
		   int32_t flags);

call_stub_t *
fop_setxattr_cbk_stub (call_frame_t *frame,
		       fop_setxattr_cbk_t fn,
		       int32_t op_ret,
		       int32_t op_errno);

call_stub_t *
fop_getxattr_stub (call_frame_t *frame,
		   fop_getxattr_t fn,
		   loc_t *loc);

call_stub_t *
fop_getxattr_cbk_stub (call_frame_t *frame,
		       fop_getxattr_cbk_t fn,
		       int32_t op_ret,
		       int32_t op_errno,
		       dict_t *value);

call_stub_t *
fop_removexattr_stub (call_frame_t *frame,
		      fop_removexattr_t fn,
		      loc_t *loc,
		      const char *name);

call_stub_t *
fop_removexattr_cbk_stub (call_frame_t *frame,
			  fop_removexattr_cbk_t fn,
			  int32_t op_ret,
			  int32_t op_errno);
call_stub_t *
fop_lk_stub (call_frame_t *frame,
	     fop_lk_t fn,
	     fd_t *fd,
	     int32_t cmd,
	     struct flock *lock);

call_stub_t *
fop_lk_cbk_stub (call_frame_t *frame,
		 fop_lk_cbk_t fn,
		 int32_t op_ret,
		 int32_t op_errno,
		 struct flock *lock);

call_stub_t *
fop_readdir_stub (call_frame_t *frame,
		  fop_readdir_t fn,
		  fd_t *fd,
		  size_t size,
		  off_t off);

call_stub_t *
fop_readdir_cbk_stub (call_frame_t *frame,
		      fop_readdir_t fn,
		      int32_t op_ret,
		      int32_t op_errno,
		      gf_dirent_t *entries);

void call_resume (call_stub_t *stub);
#endif
