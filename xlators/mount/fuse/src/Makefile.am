# Copyright (c) 2006, 2007, 2008 Z RESEARCH, Inc. <http://www.zresearch.com>
# This file is part of GlusterFS.
#
# GlusterFS is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# GlusterFS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


noinst_HEADERS = fuse-extra.h 

xlator_PROGRAMS = fuse.so
xlatordir = $(libdir)/glusterfs/$(PACKAGE_VERSION)/xlator/mount
fuse_so_SOURCES = fuse-bridge.c fuse-extra.c

fuse_so_CFLAGS = -DFUSE_USE_VERSION=26 -fPIC -Wall -pthread \
	$(GF_DARWIN_BUNDLE_CFLAGS) -I$(top_srcdir)/libglusterfs/src \
	-D$(GF_HOST_OS) -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE  \
	-DDATADIR=\"$(localstatedir)\" -DCONFDIR=\"$(sysconfdir)/glusterfs\"
fuse_so_LDFLAGS = -shared -nostartfiles $(GF_DARWIN_BUNDLE_CFLAGS)
fuse_so_LDADD = -lfuse $(GF_DARWIN_FUSE_LDADD)  \
		$(top_builddir)/libglusterfs/src/libglusterfs.la


CLEANFILES = *~

