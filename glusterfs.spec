# Copyright (c) 2007 Matt Paine <matt@mattsoftware.com>
# Copyright (c) 2008 Z RESEARCH, Inc. <http://www.zresearch.com>
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

# if you make changes, the it is advised to increment this number, and provide 
# a descriptive suffix to identify who owns or what the change represents
# e.g. release_version 2.MSW
%define release_version 1

# if you wish to compile an rpm without ibverbs support, compile like this...
# rpmbuild -ta glusterfs-1.3.10.tar.gz --without ibverbs
%define with_ibverbs %{?_without_ibverbs:0}%{?!_without_ibverbs:1}

# if you wish to compile an rpm without building the client RPMs...
# rpmbuild -ta glusterfs-1.3.10.tar.gz --without client
%define with_client %{?_without_client:0}%{?!_without_client:1}


Summary: GNU Cluster File System
Name: glusterfs
Version: 1.3.10
Release: %release_version
License: GPLv3 or later
Group: System Environment/Base
Vendor: Z RESEARCH Inc
Packager: glusterfs-support@zresearch.com
BuildRoot: %_tmppath/%name-%version-%release-root
%if %with_client
BuildRequires: fuse-devel
%endif
%if %with_ibverbs
BuildRequires: libibverbs-devel
%endif
BuildRequires: libtool
BuildRequires: byacc bison flex
BuildRequires: gcc
BuildRequires: make
URL: ftp://ftp.zresearch.com/pub/gluster/glusterfs/1.3/glusterfs-1.3.10.tar.gz
Source: %name-%version.tar.gz

%description
GlusterFS is a clustered file-system capable of scaling to several
peta-bytes. It aggregates various storage bricks over Infiniband RDMA
or TCP/IP interconnect into one large parallel network file
system. GlusterFS is one of the most sophisticated file system in
terms of features and extensibility.  It borrows a powerful concept
called Translators from GNU Hurd kernel. Much of the code in GlusterFS
is in userspace and easily manageable.

%if %with_client
This package provides the FUSE based GlusterFS client.
%endif


%package devel
Summary: GlusterFS Development Libraries
Group: Development/Libraries
Requires: %name = %version

%description devel
GlusterFS is a clustered file-system capable of scaling to several
peta-bytes. It aggregates various storage bricks over Infiniband RDMA
or TCP/IP interconnect into one large parallel network file
system. GlusterFS is one of the most sophisticated file system in
terms of features and extensibility.  It borrows a powerful concept
called Translators from GNU Hurd kernel. Much of the code in GlusterFS
is in userspace and easily manageable.

This package provides the development libraries.


%prep
# then -n argument says that the unzipped version is NOT %name-%version
#%setup -n %name-%version
%setup


%build
%if "%{with_client}" == "0"
%define client_options --disable-fuse-client
%endif
%if "%{with_ibverbs}" == "0"
%define ibverbs_options --disable-ibverbs
%endif

%configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libdir=%_libdir %{?client_options:%client_options} %{?ibverbs_options:%ibverbs_options} 
%{__make}


%install
%{__rm} -rf $RPM_BUILD_ROOT
%{__make} install DESTDIR=$RPM_BUILD_ROOT
%{__rm} -rf $RPM_BUILD_ROOT/share/
%{__mkdir_p} $RPM_BUILD_ROOT/usr/include/glusterfs
%{__mkdir_p} $RPM_BUILD_ROOT/var/log/glusterfs
%{__cp} %_builddir/%name-%version/libglusterfs/src/*.h $RPM_BUILD_ROOT/usr/include/glusterfs/


%files 
%doc AUTHORS ChangeLog COPYING INSTALL NEWS README
%_libdir
%dir /var/log/glusterfs
%exclude %_libdir/*.a
%exclude %_libdir/*.la
%doc /usr/share/doc/glusterfs/examples
%config /etc/glusterfs
%_prefix/sbin/glusterfs
%_prefix/sbin/glusterfsd
%_mandir/man8/glusterfs.8.gz

%if %with_client
/sbin/mount.glusterfs
%endif

%files devel
%doc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS
%_libdir/*.a
%exclude %_libdir/*.la
%_prefix/include
%exclude /usr/include/glusterfs/y.tab.h


%post
ldconfig -n %_libdir

%clean
%{__rm} -rf $RPM_BUILD_ROOT


%changelog
* Sat Apr 19 2008 Amar Tumballi <amar@zresearch.com> - 1.3.8pre6
- Merged common, client and server packages into one package.

* Fri Apr 11 2008 Harshavardhana <harsha@zresearch.com> - 1.3.8pre5
- Changed many hardcoded variables to standard rpm variables. Removed
  *.la unnecessary for the release.  Python option removed as it
  is not present with the coming releases. 
 
* Tue Feb 12 2008 Harshavardhana <harsha@zresearch.com> - 1.3.8
- Replaced configure_options with different names for each configure
  options as it is observed that configure_options never get appended 
  with extra options provided. 

* Wed Jan 16 2008 Matt Paine <matt@mattsoftware.com> - 1.3.8
- Change all /usr/libx directory references to %_libdir
- Added new switch to enable build without building client RPMS

* Sun Jan 6 2008 Anand V. Avati <avati@zresearch.com> - 1.3.8
- glusterfs-booster.so back in libdir

* Fri Nov 09 2007 Harshavardhana Ranganath <harsha@zresearch.com> -  1.3.8
- Bumped to new version fixed problem with build for new glusterfs-booster.so
  inside /usr/bin

* Sun Oct 18 2007 Harshavardhana Ranganath <harsha@zresearch.com> - 1.3.7
- Bumped to new version

* Sun Oct 18 2007 Harshavardhana Ranganath <harsha@zresearch.com> - 1.3.6
- Bumped to new version
  
* Sun Oct 14 2007 Harshavardhana Ranganath <harsha@zresearch.com> - 1.3.5
- Bumped to new version
 
* Tue Oct 09 2007 Harshavardhana Ranganath <harsha@zresearch.com> - 1.3.4
- Bumped to new version
 
* Tue Oct 02 2007 Harshavardhana Ranganath <harsha@zresearch.com> - 1.3.3
- Bumped to new version

* Tue Oct 02 2007 Harshavardhana Ranganath <harsha@zresearch.com> - 1.3.2
- Bumped to new version 
 
* Thu Sep 20 2007 Harshavardhana Ranganath <harsha@zresearch.com> - 1.3.1
- built new rpms with ibverbs seperate

* Sat Aug 4 2007 Matt Paine <matt@mattsoftware.com> - 1.3.pre7
- Added support to build rpm without ibverbs support (use --without ibverbs switch)

* Sun Jul 15 2007 Matt Paine <matt@mattsoftware.com> - 1.3.pre6
- Initial spec file

