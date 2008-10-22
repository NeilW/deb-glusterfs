2008-09-02 15:35:33 GMT	Anand V. Avati <avati@80x25.org>	patch-797

    Summary:
      more paranoid fixes against possible IB hangs
    Revision:
      glusterfs--mainline--2.5--patch-797

    
    

    modified files:
     configure.ac libglusterfs/src/revision.h
     transport/ib-verbs/ib-verbs.c


2008-08-26 09:41:11 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-796

    Summary:
      
	 * fix to server hang in ib_verbs_quota_get when the client has disconnected due to call-bail.
    Revision:
      glusterfs--mainline--2.5--patch-796


    modified files:
     libglusterfs/src/revision.h transport/ib-verbs/ib-verbs.c


2008-08-20 00:03:53 GMT	Amar Tumballi <amar@80x25.org>	patch-795

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-795

    
    * fixes a problem with recv thread exit in ib-verbs. Also added, logging of return values

    modified files:
     libglusterfs/src/revision.h transport/ib-verbs/ib-verbs.c


2008-08-11 10:15:44 GMT	Amar Tumballi <amar@80x25.org>	patch-794

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-794

    
    * added so_LDADD = libglusterfs.la in Makefile.am (so build with gcc-4.3.1 works fine) - Thanks to Mateusz Korniak 
    
    * small fix to handle EEXIST in unify_mkdir_cbk
    

    modified files:
     auth/ip/src/Makefile.am auth/login/src/Makefile.am
     libglusterfs/src/revision.h scheduler/alu/src/Makefile.am
     scheduler/nufa/src/Makefile.am
     scheduler/random/src/Makefile.am scheduler/rr/src/Makefile.am
     scheduler/switch/src/Makefile.am
     transport/ib-sdp/client/src/Makefile.am
     transport/ib-sdp/server/src/Makefile.am
     transport/ib-verbs/client/src/Makefile.am
     transport/ib-verbs/server/src/Makefile.am
     transport/tcp/client/src/Makefile.am
     transport/tcp/server/src/Makefile.am
     transport/unix/client/src/Makefile.am
     transport/unix/server/src/Makefile.am
     xlators/cluster/afr/src/Makefile.am
     xlators/cluster/stripe/src/Makefile.am
     xlators/cluster/unify/src/Makefile.am
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/Makefile.am
     xlators/encryption/rot-13/src/Makefile.am
     xlators/features/filter/src/Makefile.am
     xlators/features/fixed-id/src/Makefile.am
     xlators/features/posix-locks/src/Makefile.am
     xlators/features/trash/src/Makefile.am
     xlators/mount/fuse/src/Makefile.am
     xlators/performance/booster/src/Makefile.am
     xlators/performance/io-cache/src/Makefile.am
     xlators/performance/io-threads/src/Makefile.am
     xlators/performance/read-ahead/src/Makefile.am
     xlators/performance/write-behind/src/Makefile.am
     xlators/protocol/client/src/Makefile.am
     xlators/protocol/server/src/Makefile.am
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/Makefile.am


2008-08-04 07:19:41 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-793

    Summary:
      
	 * afrfdp would've been freed after sync_file_cnt number of STACK_WINDs and afr would crash in the next iteration of for loop.
    Revision:
      glusterfs--mainline--2.5--patch-793

    
    

    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c


2008-07-29 22:55:55 GMT	Amar Tumballi <amar@80x25.org>	patch-792

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-792

    * fix for a notify issue in stripe.

    modified files:
     libglusterfs/src/revision.h
     xlators/cluster/stripe/src/stripe.c


2008-07-24 17:21:18 GMT	Amar Tumballi <amar@80x25.org>	patch-791

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-791

    
    * checksum made as an fop
    * checksum fop added to io-threads

    modified files:
     libglusterfs/src/call-stub.c libglusterfs/src/call-stub.h
     libglusterfs/src/defaults.c libglusterfs/src/glusterfs.h
     libglusterfs/src/revision.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/bdb/src/bdb.c
     xlators/storage/posix/src/posix.c


2008-07-18 10:52:53 GMT	Amar Tumballi <amar@80x25.org>	patch-790

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-790

    
    * a corner case fix in unify-self-heal (when afr is used as namespace volume)

    modified files:
     libglusterfs/src/revision.h
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/protocol/client/src/client-protocol.c


2008-07-17 06:09:14 GMT	Amar Tumballi <amar@80x25.org>	patch-789

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-789

    * a fix for checksum being corrupted due to reply thread in server protocol. 
      - THIS IS A MAIN BUG, which made first time 'ls -l'  slower over this release. 

    modified files:
     configure.ac libglusterfs/src/revision.h
     xlators/protocol/server/src/server-protocol.c


2008-06-27 09:40:14 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-788

    Summary:
      
	* fix to setuid/gid getting cleared during creation of hardlink. An lchown at the end of posix_link was causing the bug. Hence removed it. 
          Reviewer: Avati
    Revision:
      glusterfs--mainline--2.5--patch-788

    Keywords: 
    

    modified files:
     libglusterfs/src/revision.h xlators/storage/posix/src/posix.c


2008-06-26 10:04:00 GMT	Amar Tumballi <amar@80x25.org>	patch-787

    Summary:
      fixes in unify rename
    Revision:
      glusterfs--mainline--2.5--patch-787

    Thanks to 'NovA' for bug report

    modified files:
     libglusterfs/src/revision.h xlators/cluster/unify/src/unify.c


2008-06-20 07:16:49 GMT	Anand V. Avati <avati@80x25.org>	patch-786

    Summary:
      set pool and this pointer while sending close to EINTR'ed open/create
    Revision:
      glusterfs--mainline--2.5--patch-786

    
    

    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-06-19 10:50:01 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-785

    Summary:
      prefious fix did not have the fix. checking in again.
    Revision:
      glusterfs--mainline--2.5--patch-785


    modified files:
     libglusterfs/src/revision.h libglusterfs/src/xlator.c


2008-06-18 05:36:13 GMT	Amar Tumballi <amar@80x25.org>	patch-784

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-784

    
    * fixes the issue with xlator.c notify.

    modified files:
     libglusterfs/src/revision.h libglusterfs/src/xlator.c


2008-06-18 04:13:22 GMT	Amar Tumballi <amar@80x25.org>	patch-783

    Summary:
      unify opendir sent only to namespace
    Revision:
      glusterfs--mainline--2.5--patch-783

    
    

    modified files:
     libglusterfs/src/revision.h xlators/cluster/unify/src/unify.c


2008-06-18 03:18:02 GMT	Amar Tumballi <amar@80x25.org>	patch-782

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-782

    
    Patches applied:
    
     * gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-144
       xlator->parent is replaced by xlator->parents (i.e a list of pointers to parent xlators.
    

    modified files:
     glusterfs/src/fetch-spec.c glusterfs/src/glusterfs.c
     libglusterfs/src/defaults.c libglusterfs/src/revision.h
     libglusterfs/src/spec.y libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c

    new patches:
     gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-144


2008-06-15 17:23:41 GMT	Amar Tumballi <amar@80x25.org>	patch-781

    Summary:
      stripe over afr fix.
    Revision:
      glusterfs--mainline--2.5--patch-781

    * fixes afr_setxattr so that it can send request even if loc->inode is NULL.
    
    

    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c


2008-06-15 01:57:14 GMT	Amar Tumballi <amar@80x25.org>	patch-780

    Summary:
      unify rename fix
    Revision:
      glusterfs--mainline--2.5--patch-780

    * Fix for unify rename creating duplicate entries.
    
    

    modified files:
     libglusterfs/src/revision.h xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2008-06-12 19:50:26 GMT	Anand V. Avati <avati@80x25.org>	patch-779

    Summary:
      set st_mode in inode of server-protocol _cbk functions
    Revision:
      glusterfs--mainline--2.5--patch-779

    
    

    modified files:
     commit.sh libglusterfs/src/revision.h
     xlators/protocol/server/src/server-protocol.c


2008-06-09 16:35:05 GMT	Amar Tumballi <amar@80x25.org>	patch-778

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-778

    * reduce the ENOSYS logs in fuse_*lk_cbk()

    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-06-08 12:41:01 GMT	Anand V. Avati <avati@80x25.org>	patch-777

    Summary:
      frame loss fixes in AFR
    Revision:
      glusterfs--mainline--2.5--patch-777

    
    

    modified files:
     xlators/cluster/afr/src/afr.c


2008-06-08 12:38:05 GMT	Anand V. Avati <avati@80x25.org>	patch-776

    Summary:
      locks around dict_del
    Revision:
      glusterfs--mainline--2.5--patch-776

    
    

    modified files:
     libglusterfs/src/dict.c


2008-06-06 03:14:22 GMT	Anand V. Avati <avati@80x25.org>	patch-775

    Summary:
      close fds properly when EINTR is received
    Revision:
      glusterfs--mainline--2.5--patch-775

    
    

    modified files:
     libglusterfs/src/revision.h
     transport/tcp/server/src/tcp-server.c
     xlators/cluster/afr/src/afr.c
     xlators/mount/fuse/src/fuse-bridge.c


2008-06-01 07:31:45 GMT	Amar Tumballi <amar@80x25.org>	patch-774

    Summary:
      Fixes the issue of notify causing mutliple thread creation for same job in fuse-bridge
    Revision:
      glusterfs--mainline--2.5--patch-774

    * It got introduced in previous patch (773).
    
    Patches applied:
    
     * gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-138
       fix for #23449
    

    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c

    new patches:
     gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-138


2008-05-28 21:09:28 GMT	Amar Tumballi <amar@80x25.org>	patch-773

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-773

    * fixes in fuse-bridge (to create fuse thread in notify() rather than init())
      - gowda fixed it in glusterfs--mainline--3.0 branch, patch-105
    
    * fixes in mount.glusterfs.in to handle different transport options

    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c
     xlators/mount/fuse/utils/mount.glusterfs.in


2008-05-23 20:32:45 GMT	Amar Tumballi <amar@80x25.org>	patch-772

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-772

    * minor bug fix in access () path - should help to make solaris fuse work fine.

    modified files:
     libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c


2008-05-21 17:15:18 GMT	Amar Tumballi <amar@80x25.org>	patch-771

    Summary:
      minor fixes
    Revision:
      glusterfs--mainline--2.5--patch-771

    * fix for mount.glusterfs to handle duplicate mounts. (Thanks to Mattias)
    
    * fix in the log msg not to print errors in self-healing for EEXIST errno.
    

    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/utils/mount.glusterfs.in
     xlators/storage/posix/src/posix.c


2008-05-13 20:50:53 GMT	Amar Tumballi <amar@80x25.org>	patch-770

    Summary:
      BSD compilation fixes.
    Revision:
      glusterfs--mainline--2.5--patch-770

    * Fixed BSD compilation issues. Thanks to Harshavardhana <harsh@zresearch.com> for patch.
    
    * Now posix_readdir() has telldir() for d_off, hence no ifdefs in posix.
    
    * Removed setrlimit for DARWIN OS, as it was always failing on Darwin machines.

    modified files:
     libglusterfs/src/common-utils.h libglusterfs/src/revision.h
     scheduler/alu/src/Makefile.am scheduler/nufa/src/Makefile.am
     scheduler/random/src/Makefile.am scheduler/rr/src/Makefile.am
     scheduler/switch/src/Makefile.am
     transport/ib-sdp/client/src/Makefile.am
     transport/ib-sdp/server/src/Makefile.am
     transport/ib-verbs/client/src/Makefile.am
     transport/ib-verbs/server/src/Makefile.am
     transport/tcp/client/src/Makefile.am
     transport/tcp/server/src/Makefile.am
     transport/unix/client/src/Makefile.am
     transport/unix/server/src/Makefile.am
     xlators/cluster/stripe/src/Makefile.am
     xlators/encryption/rot-13/src/Makefile.am
     xlators/features/filter/src/Makefile.am
     xlators/features/fixed-id/src/Makefile.am
     xlators/features/trash/src/Makefile.am
     xlators/performance/io-threads/src/Makefile.am
     xlators/performance/read-ahead/src/Makefile.am
     xlators/performance/write-behind/src/Makefile.am
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2008-05-12 21:54:43 GMT	Amar Tumballi <amar@80x25.org>	patch-769

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-769

    * Fixes the server hang in case of client disconnects.

    modified files:
     configure.ac libglusterfs/src/revision.h
     libglusterfs/src/transport.c transport/ib-verbs/ib-verbs.c
     transport/ib-verbs/server/src/ib-verbs-server.c


2008-05-12 19:40:53 GMT	Anand V. Avati <avati@80x25.org>	patch-768

    Summary:
      afr_lk was storing pointer on the stack to lock structure. now copies structure.
    Revision:
      glusterfs--mainline--2.5--patch-768

    Reviewed by: amar
    
    

    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h


2008-05-12 18:53:21 GMT	Anand V. Avati <avati@80x25.org>	patch-767

    Summary:
      default timeout to 42 seconds. check timeout every 10 seconds instead of every timeout interval
    Revision:
      glusterfs--mainline--2.5--patch-767

    
    

    modified files:
     commit.sh libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c


2008-05-12 18:48:02 GMT	Anand V. Avati <avati@80x25.org>	patch-766

    Summary:
      setting SO_SNDTIMEO and SO_RCVTIMEO in tcp/server to 15 seconds
    Revision:
      glusterfs--mainline--2.5--patch-766

    
    

    modified files:
     libglusterfs/src/revision.h
     transport/tcp/server/src/tcp-server.c


2008-05-09 11:18:22 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-765

    Summary:
      setdents/getdents now supports symlinks. Hence in AFR selfheal, healing of symlinks is supported.
    Revision:
      glusterfs--mainline--2.5--patch-765

    
    
    Patches applied:
    
     * gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-91
       setdents/getdents now supports symlinks. Hence in AFR selfheal, healing of symlinks is supported.
    

    modified files:
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c

    new patches:
     gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-91


2008-05-08 12:45:20 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-764

    Summary:
      fixed typo in io-cache/page.c
    Revision:
      glusterfs--mainline--2.5--patch-764

    
    

    modified files:
     libglusterfs/src/revision.h
     xlators/performance/io-cache/src/page.c


2008-05-08 10:16:07 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-763

    Summary:
      refer to the previous changelog entry
    Revision:
      glusterfs--mainline--2.5--patch-763

    
    

    modified files:
     libglusterfs/src/revision.h
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/page.c


2008-05-08 10:10:34 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-762

    Summary:
      io-cache bug fix
    Revision:
      glusterfs--mainline--2.5--patch-762

    * bug details: io-cache searches for a page in cache, finds it and sends a revaildate requests. some more pages
                 from the same inode are requested for and io-cache appends all the pages to the inode's waiting
                 list. while appending to waiting list, io-cache never checked for duplicate entries, i.e, same
                 page waiting more than once for revalidate. 
                   the situation when same page is waiting more than once for revalidate to return, first 
                 wakeup_page() on that page clears all the pending frames on that page. since the page doesn't 
                 have any waiting frames, page may get destroyed any time. if the page gets destroyed before, 
                 wakeup_page() is called for all waiting instances on revalidate, then we have a danglinglin page
                 pointer in inode's waiting list. 
      fix:
        * once a page decides that it is going for revalidate, it changes its state to 'in-transit', instead of
          'ready', this step makes sure that revalidate is done only once per page at a given instance.

    modified files:
     libglusterfs/src/revision.h


2008-05-07 08:57:50 GMT	Amar Tumballi <amar@80x25.org>	patch-761

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-761

    linking issues in MAC OS X port fixed. 

    modified files:
     libglusterfs/src/revision.h xlators/mount/fuse/src/Makefile.am
     xlators/performance/booster/src/Makefile.am


2008-04-26 03:57:04 GMT	Amar Tumballi <amar@80x25.org>	patch-760

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-760

    * a small fix in Makefile.am of booster to compile over MAC OS X

    modified files:
     libglusterfs/src/revision.h
     xlators/performance/booster/src/Makefile.am


2008-04-25 06:39:29 GMT	Amar Tumballi <amar@80x25.org>	patch-759

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-759

    * mount.glusterfs.in: Copyright changes (added 2008)
    
    * posix: posix_setxattr(), added key in the log when the call fails.

    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/utils/mount.glusterfs.in
     xlators/storage/posix/src/posix.c


2008-04-25 05:34:11 GMT	Amar Tumballi <amar@80x25.org>	patch-758

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-758

    * changes are only in Copyright part of the code. (updated to 2008 copyright)
    * Added copyright information to Makefile.am

    modified files:
     INSTALL Makefile.am THANKS auth/Makefile.am
     auth/ip/Makefile.am auth/ip/src/Makefile.am
     auth/login/Makefile.am auth/login/src/Makefile.am
     extras/glusterfs-mode.el extras/glusterfs.vim
     extras/specgen.scm glusterfs.spec.in glusterfs/Makefile.am
     glusterfs/src/Makefile.am libglusterfs/Makefile.am
     libglusterfs/src/Makefile.am libglusterfs/src/revision.h
     libglusterfs/src/spec.l libglusterfs/src/spec.y
     scheduler/Makefile.am scheduler/alu/Makefile.am
     scheduler/alu/src/Makefile.am scheduler/nufa/Makefile.am
     scheduler/nufa/src/Makefile.am scheduler/random/Makefile.am
     scheduler/random/src/Makefile.am scheduler/rr/Makefile.am
     scheduler/rr/src/Makefile.am scheduler/switch/Makefile.am
     scheduler/switch/src/Makefile.am transport/Makefile.am
     transport/ib-sdp/Makefile.am
     transport/ib-sdp/client/Makefile.am
     transport/ib-sdp/client/src/Makefile.am
     transport/ib-sdp/server/Makefile.am
     transport/ib-sdp/server/src/Makefile.am
     transport/ib-verbs/Makefile.am
     transport/ib-verbs/client/Makefile.am
     transport/ib-verbs/client/src/Makefile.am
     transport/ib-verbs/server/Makefile.am
     transport/ib-verbs/server/src/Makefile.am
     transport/tcp/Makefile.am transport/tcp/client/Makefile.am
     transport/tcp/client/src/Makefile.am
     transport/tcp/server/Makefile.am
     transport/tcp/server/src/Makefile.am
     transport/unix/Makefile.am transport/unix/client/Makefile.am
     transport/unix/client/src/Makefile.am
     transport/unix/server/Makefile.am
     transport/unix/server/src/Makefile.am
     xlators/bindings/Makefile.am
     xlators/bindings/python/Makefile.am
     xlators/cluster/Makefile.am xlators/cluster/afr/Makefile.am
     xlators/cluster/afr/src/Makefile.am
     xlators/cluster/afr/src/afr_self_heal.c
     xlators/cluster/stripe/Makefile.am
     xlators/cluster/stripe/src/Makefile.am
     xlators/cluster/unify/Makefile.am
     xlators/cluster/unify/src/Makefile.am
     xlators/debug/Makefile.am xlators/debug/trace/Makefile.am
     xlators/debug/trace/src/Makefile.am
     xlators/encryption/Makefile.am
     xlators/encryption/rot-13/Makefile.am
     xlators/encryption/rot-13/src/Makefile.am
     xlators/features/Makefile.am
     xlators/features/filter/Makefile.am
     xlators/features/filter/src/Makefile.am
     xlators/features/fixed-id/Makefile.am
     xlators/features/fixed-id/src/Makefile.am
     xlators/features/posix-locks/Makefile.am
     xlators/features/posix-locks/src/Makefile.am
     xlators/features/trash/Makefile.am
     xlators/features/trash/src/Makefile.am
     xlators/meta/Makefile.am xlators/meta/src/Makefile.am
     xlators/mount/Makefile.am xlators/mount/fuse/Makefile.am
     xlators/mount/fuse/src/Makefile.am
     xlators/mount/fuse/utils/Makefile.am
     xlators/performance/Makefile.am
     xlators/performance/booster/Makefile.am
     xlators/performance/booster/src/Makefile.am
     xlators/performance/io-cache/Makefile.am
     xlators/performance/io-cache/src/Makefile.am
     xlators/performance/io-threads/Makefile.am
     xlators/performance/io-threads/src/Makefile.am
     xlators/performance/read-ahead/Makefile.am
     xlators/performance/read-ahead/src/Makefile.am
     xlators/performance/stat-prefetch/Makefile.am
     xlators/performance/stat-prefetch/src/Makefile.am
     xlators/performance/write-behind/Makefile.am
     xlators/performance/write-behind/src/Makefile.am
     xlators/protocol/Makefile.am
     xlators/protocol/client/Makefile.am
     xlators/protocol/client/src/Makefile.am
     xlators/protocol/server/Makefile.am
     xlators/protocol/server/src/Makefile.am
     xlators/storage/Makefile.am xlators/storage/bdb/Makefile.am
     xlators/storage/bdb/src/Makefile.am
     xlators/storage/posix/Makefile.am
     xlators/storage/posix/src/Makefile.am


2008-04-25 03:18:41 GMT	Amar Tumballi <amar@80x25.org>	patch-757

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-757

    * changes in notify structure of PARENT_UP event, as FUSE->init() is done before other translators. 

    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c


2008-04-24 21:46:02 GMT	Amar Tumballi <amar@80x25.org>	patch-756

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-756

    * Enhancement in setrlimit (), now its called in init of posix, serverprotocol and client protocol.
    * Removed from glusterfs.c

    modified files:
     glusterfs/src/glusterfs.c libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2008-04-24 06:32:57 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-755

    Summary:
      Fixed a few FIXMEs.
    Revision:
      glusterfs--mainline--2.5--patch-755


    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c


2008-04-23 21:33:31 GMT	Amar Tumballi <amar@80x25.org>	patch-754

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-754

    * Log changes in unify*.c
    
    * Fixes wrong entries seen in log file, (high entry count for files) in unify_lookup

    modified files:
     libglusterfs/src/revision.h
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2008-04-23 19:58:11 GMT	Amar Tumballi <amar@80x25.org>	patch-753

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-753

    * Warning messages added when setrlimit() fails. 
    * Because on few nodes setrlimit (INIFINITY) fails, limit for openfd will be retried for 1M.

    modified files:
     glusterfs/src/glusterfs.c libglusterfs/src/revision.h


2008-04-23 01:59:16 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-752

    Summary:
      AFR lookup_cbk will pass on the xattr of the latest subvol to the upper xlators.
    Revision:
      glusterfs--mainline--2.5--patch-752


    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h


2008-04-21 01:27:22 GMT	Amar Tumballi <amar@80x25.org>	patch-751

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-751

    * critical bug fix.
    
      - Fail to setup GlusterFS over ib-verbs transport, when connected, server recieves the log,
     "header corrupted".
    
      - Reason: Change in the order of FUSE initialization.
    
      - Fix: Initialize the FUSE before any other translator (matters for client side only).

    modified files:
     glusterfs/src/glusterfs.c libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-04-20 19:08:35 GMT	Amar Tumballi <amar@80x25.org>	patch-750

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-750

    * Fixes for compilation on Solaris
      - removed d_type from dirent structure.
      - added #include <alloca.h> in common_utils.h
      - removed signalhandler_t variable from glusterfs.c
    
    

    modified files:
     glusterfs/src/glusterfs.c libglusterfs/src/common-utils.h
     libglusterfs/src/revision.h xlators/storage/posix/src/posix.c


2008-04-19 23:58:17 GMT	Amar Tumballi <amar@80x25.org>	patch-749

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-749

    * Enhancement to glusterfs.spec.in so that there will be only single rpm 
      instead of common, client and server.

    modified files:
     glusterfs.spec.in libglusterfs/src/revision.h


2008-04-17 18:22:00 GMT	Amar Tumballi <amar@80x25.org>	patch-748

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-748

    * Fixed a conflict error in write-behind, due to which, "option flush-behind" was always 'off', hence not giving desired output for small file performances.

    modified files:
     libglusterfs/src/revision.h
     xlators/performance/write-behind/src/write-behind.c


2008-04-16 09:14:00 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-747

    Summary:
      making first and latest 0 incase it is -1, so that statptr[-1] is not accessed.
    Revision:
      glusterfs--mainline--2.5--patch-747


    modified files:
     xlators/cluster/afr/src/afr.c


2008-04-16 08:33:49 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-746

    Summary:
      memory was referenced after STACK_UNWIND() use "cnt" counter to break out of the loop.
    Revision:
      glusterfs--mainline--2.5--patch-746


    modified files:
     xlators/cluster/afr/src/afr_self_heal.c


2008-04-16 08:29:47 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-745

    Summary:
      Changes for not creating missing files and directories. This will be taken care by the selfheal during directory lookup when it detects version mismatch.
    Revision:
      glusterfs--mainline--2.5--patch-745


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2008-04-15 15:51:15 GMT	Amar Tumballi <amar@80x25.org>	patch-744

    Summary:
      minor fixes
    Revision:
      glusterfs--mainline--2.5--patch-744

    * removed the warning of unsed variables in client-protocol.c
    
    * added io-threads translator to the example client vol spec file.
    

    modified files:
     doc/glusterfs-client.vol.sample libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c


2008-04-15 15:41:39 GMT	Amar Tumballi <amar@80x25.org>	patch-743

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-743

    * Added feature to fetch spec files from server based on IP addr extension. If this file doesn't exists, fetch will fall back to older method of common spec files.

    modified files:
     libglusterfs/src/revision.h
     xlators/protocol/server/src/server-protocol.c


2008-04-15 15:34:21 GMT	Amar Tumballi <amar@80x25.org>	patch-742

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-742

    
    * fixes for other OS porting. Compiled over freebsd, Mac OS X
    * need to compile over Open Solaris.

    modified files:
     configure.ac glusterfs/src/glusterfs.c
     libglusterfs/src/compat.h libglusterfs/src/revision.h
     xlators/cluster/afr/src/Makefile.am
     xlators/cluster/afr/src/afr_self_heal.c
     xlators/cluster/unify/src/Makefile.am
     xlators/performance/booster/src/Makefile.am
     xlators/performance/booster/src/entry.c


2008-04-15 11:26:34 GMT	Anand V. Avati <avati@80x25.org>	patch-741

    Summary:
      lock read ahead conf while adding new ra_file_t in ra_open_cbk and ra_create_cbk - caused random memory corruption
    Revision:
      glusterfs--mainline--2.5--patch-741

    

    modified files:
     libglusterfs/src/revision.h
     xlators/performance/read-ahead/src/read-ahead.c


2008-04-11 18:26:59 GMT	Amar Tumballi <amar@80x25.org>	patch-740

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-740

    * patch for 'glusterfs.spec.in' (RPM spec file) from Harshavardhana (harsha@zresearch.com)
    
    

    modified files:
     glusterfs.spec.in libglusterfs/src/revision.h


2008-04-10 21:02:28 GMT	Amar Tumballi <amar@80x25.org>	patch-739

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-739

    * removed bindings/python from the build, as more work needs to be done in that. It will be part of archive, but not part of releases for 1.3.x anymore.

    modified files:
     configure.ac libglusterfs/src/revision.h xlators/Makefile.am


2008-04-10 10:33:38 GMT	Vikas Gorur <vikas@80x25.org>	patch-738

    Summary:
      fixes insert_and_merge infinite loop bug reported by Andrea Barisani
    Revision:
      glusterfs--mainline--2.5--patch-738

    posix-locks.c: off-by-one error in subtract_locks fixed
    
    Reviewed by: avati

    modified files:
     libglusterfs/src/revision.h
     xlators/features/posix-locks/src/posix-locks.c


2008-04-09 07:58:26 GMT	Anand V. Avati <avati@80x25.org>	patch-737

    Summary:
      fixes for booster
    Revision:
      glusterfs--mainline--2.5--patch-737

    
    
    Patches applied:
    
     * gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-22
       fixed fd leak in booster ldpreload client
    
     * gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-24
       log level of disconnection messages changed to DEBUG
    

    modified files:
     libglusterfs/src/revision.h transport/ib-sdp/ib-sdp.c
     transport/tcp/tcp.c transport/unix/unix.c
     xlators/performance/booster/src/entry.c

    new patches:
     gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-22
     gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-24


2008-04-06 03:06:22 GMT	Amar Tumballi <amar@80x25.org>	patch-736

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-736

    
    * Removed bdb from configure.ac and Makefile.
    
    NOTE: The BDB translator will be supported only in 'glusterfs--mainline--3.0' branch. And this branch will be freezed for any new features/translators, but will continue to get bug fixes.

    modified files:
     configure.ac libglusterfs/src/revision.h
     xlators/storage/Makefile.am


2008-04-06 03:00:35 GMT	Amar Tumballi <amar@80x25.org>	patch-735

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-735

    * memleak fix in stripe_readv_cbk().
    
    * change in stripe_setxattr () for enabling init() time check from above layers. 

    modified files:
     libglusterfs/src/revision.h
     xlators/cluster/stripe/src/stripe.c


2008-04-03 19:01:28 GMT	Amar Tumballi <amar@80x25.org>	patch-734

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-734

    * small fix in unify for not returning ESTALE based on inode generation numbers when 'option self-heal off' is given.

    modified files:
     libglusterfs/src/revision.h xlators/cluster/unify/src/unify.c


2008-04-03 18:57:49 GMT	Amar Tumballi <amar@80x25.org>	patch-733

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-733

    * Fix for the Segfault which is seen when glusterfs is built with no fuse module. But glusterfs command is given with a mountpoint.

    modified files:
     libglusterfs/src/revision.h libglusterfs/src/xlator.c


2008-04-03 18:00:16 GMT	Amar Tumballi <amar@80x25.org>	patch-732

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-732

    * fix in schedulers to error out when the value of min-free-disk is more than 100% :O

    modified files:
     libglusterfs/src/revision.h scheduler/alu/src/alu.c
     scheduler/nufa/src/nufa.c scheduler/random/src/random.c
     scheduler/rr/src/rr.c


2008-04-03 11:37:00 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-731

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-731

    
    
    Patches applied:
    
     * gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-15
       Changed Makefile.ams so that the dependencies are built first if they are not present.
    

    modified files:
     glusterfs-guts/src/Makefile.am glusterfs/src/Makefile.am
     libglusterfs/src/revision.h

    new patches:
     gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-15


2008-04-03 08:20:03 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-730

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-730

    
    
    Patches applied:
    
     * gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-13
       Documentation related to auth
    

    new files:
     doc/.arch-ids/authentication.txt.id doc/authentication.txt

    modified files:
     libglusterfs/src/revision.h

    new patches:
     gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-13


2008-04-02 16:47:08 GMT	Amar Tumballi <amar@80x25.org>	patch-729

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-729

    * Added man page
    
    * transport/ib-verbs: changed the logging priority in ib-verbs-disconnect().

    new files:
     doc/.arch-ids/glusterfs.8.id doc/glusterfs.8

    modified files:
     doc/Makefile.am libglusterfs/src/revision.h
     transport/ib-verbs/ib-verbs.c


2008-04-02 11:28:59 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-728

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-728

    
    
    Patches applied:
    
     * gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-10
       
    	* authentication of client port in auth/ip
    	* copy options dict to request dict in client before sending SETVOLUME to server
    
     * raghavendra@zresearch.com/glusterfs--server-port-authentication--1.0--base-0
       tag of gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-8
    
     * raghavendra@zresearch.com/glusterfs--server-port-authentication--1.0--patch-1
       
    

    modified files:
     auth/ip/src/ip.c libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c

    new patches:
     gluster@sv.gnu.org/glusterfs--mainline--3.0--patch-10
     raghavendra@zresearch.com/glusterfs--server-port-authentication--1.0--base-0
     raghavendra@zresearch.com/glusterfs--server-port-authentication--1.0--patch-1


2008-04-01 17:04:43 GMT	Amar Tumballi <amar@80x25.org>	patch-727

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-727

    
    * Logging improvements.

    modified files:
     libglusterfs/src/revision.h xlators/cluster/unify/src/unify.c
     xlators/mount/fuse/src/fuse-bridge.c
     xlators/storage/posix/src/posix.c


2008-03-29 20:30:07 GMT	Amar Tumballi <amar@80x25.org>	patch-726

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-726

    * a fix in checksum_cbk, which had a typo bug which used to STACK_UNWIND with INVAL for the proper result

    modified files:
     libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c


2008-03-28 14:51:43 GMT	Anand V. Avati <avati@80x25.org>	patch-725

    Summary:
      ref/unref io buffers during afr sync file (self heal)
    Revision:
      glusterfs--mainline--2.5--patch-725

    reviewed by: krishna

    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c


2008-03-28 11:55:02 GMT	Anand V. Avati <avati@80x25.org>	patch-724

    Summary:
      fixed logging bug in unify_create_cbk
    Revision:
      glusterfs--mainline--2.5--patch-724


    modified files:
     libglusterfs/src/revision.h xlators/cluster/unify/src/unify.c


2008-03-28 11:43:36 GMT	Anand V. Avati <avati@80x25.org>	patch-723

    Summary:
      fix in afr_writev to handle refs
    Revision:
      glusterfs--mainline--2.5--patch-723


    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c


2008-03-28 09:03:43 GMT	Anand V. Avati <avati@80x25.org>	patch-722

    Summary:
      added mutexes around namespace locks
    Revision:
      glusterfs--mainline--2.5--patch-722

    reviewed by: bulde

    modified files:
     libglusterfs/src/lock.c libglusterfs/src/revision.h


2008-03-27 06:45:21 GMT	Amar Tumballi <amar@80x25.org>	patch-721

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-721

    * unify returns ENODATA instead of EIO for getxattr call if file is present only in namespace.
    
    * stripe: minor correction in logging.
    
    * afr_writev_cbk: small fix.

    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c


2008-03-26 19:19:28 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-720

    Summary:
      Fixed infinite loop bug in lk() code of afr and also a bug in unify:unif_opendir_cbk which was accessing *cookie as prev_frame while cookie was the xlator ptr as STACK_WIND_COOKIE call was being used to make stack wind.
    Revision:
      glusterfs--mainline--2.5--patch-720


    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify.c


2008-03-26 03:38:34 GMT	Amar Tumballi <amar@80x25.org>	patch-719

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-719

    * error checks and logging added in client protocol. 
    * set 'type' and 'op' fields in server protocol too. 
    * removed log in posix_setxattr() when errno is ENOENT (FileNotFound).
    * added more check and logging in libglusterfs/src/lock.c

    modified files:
     libglusterfs/src/lock.c libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2008-03-25 08:32:13 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-718

    Summary:
      Correcting a race condition in afr selfheal. main selfheal function was looping on asp->entries while it was being modified in the lookup cbk.
    Revision:
      glusterfs--mainline--2.5--patch-718

    
    

    modified files:
     xlators/cluster/afr/src/afr.h
     xlators/cluster/afr/src/afr_self_heal.c


2008-03-25 05:40:53 GMT	Amar Tumballi <amar@80x25.org>	patch-717

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-717

    * Fixes a bug (which causes segfaults of afr or stripe volumes) which was introduced by me in patch 714 (handling extended attribute support).

    modified files:
     libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c


2008-03-24 20:08:59 GMT	Amar Tumballi <amar@80x25.org>	patch-716

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-716

    * more logging added. 

    modified files:
     libglusterfs/src/revision.h
     xlators/cluster/stripe/src/stripe.c
     xlators/mount/fuse/src/fuse-bridge.c


2008-03-24 19:57:50 GMT	Amar Tumballi <amar@80x25.org>	patch-715

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-715

    * more logging added. 

    modified files:
     libglusterfs/src/revision.h
     xlators/cluster/stripe/src/stripe.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/mount/fuse/src/fuse-bridge.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/write-behind/src/write-behind.c


2008-03-24 07:19:01 GMT	Amar Tumballi <amar@80x25.org>	patch-714

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-714

    
    * cluster/afr:
      cluster/stripe:
    	- Added msgs when the subvolume is not supporting Extended Attribute suport of exported filesystem.
    
    

    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h
     xlators/cluster/stripe/src/stripe.c


2008-03-24 07:06:04 GMT	Amar Tumballi <amar@80x25.org>	patch-713

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-713

    * scheduler/alu.c:
     	- Removed a exit(1), and made it return -1;
    
    * libglusterfs/*:
      xlators/protocol/*:
      xlators/storage/posix.c:
    	- Added more argument checking and logging in case of failures.

    modified files:
     libglusterfs/src/authenticate.c libglusterfs/src/call-stub.c
     libglusterfs/src/common-utils.c libglusterfs/src/compat.c
     libglusterfs/src/dict.c libglusterfs/src/epoll.c
     libglusterfs/src/fd.c libglusterfs/src/hashfn.c
     libglusterfs/src/inode.c libglusterfs/src/lock.c
     libglusterfs/src/logging.c libglusterfs/src/poll.c
     libglusterfs/src/protocol.c libglusterfs/src/revision.h
     libglusterfs/src/scheduler.c libglusterfs/src/spec.y
     libglusterfs/src/stack.h libglusterfs/src/timer.c
     libglusterfs/src/transport.c libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h scheduler/alu/src/alu.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2008-03-20 22:32:26 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-712

    Summary:
      Directory selfheal, now this is not done in one shot wrt getdents/setents. It is done in batches, hence scales well.
    Revision:
      glusterfs--mainline--2.5--patch-712


    new files:
     xlators/cluster/afr/src/.arch-ids/afr_self_heal.c.id
     xlators/cluster/afr/src/afr_self_heal.c

    modified files:
     libglusterfs/src/glusterfs.h
     xlators/cluster/afr/src/Makefile.am
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h
     xlators/storage/posix/src/posix.c


2008-03-20 21:14:44 GMT	Amar Tumballi <amar@80x25.org>	patch-711

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-711

    * fixes in argp_parse, to get the proper options in case long option not given. Tested over MAC OS X. works. (over GNU/Linux, if it has argp.h, its not required). some testing on Open Solaris and FreeBSD is required.
    
    * Fixes in MAC_OS_X part of posix_readdir(). 
    
    -- with this patchset, tested over MAC OS X for iozone, dbench, and bonnie++ (with '-n 0'). Bonnie++ fails when -n 1 or other option (other than 0) is given. Still investigating. No problems seen with any i/o operatins.
    
    
    

    modified files:
     glusterfs/src/glusterfs.c libglusterfs/src/compat.c
     libglusterfs/src/revision.h xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2008-03-19 00:57:00 GMT	Amar Tumballi <amar@80x25.org>	patch-710

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-710

    * small check added in fuse-bridge, so the '/' path is handled.
    

    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-03-18 19:31:34 GMT	Anand V. Avati <avati@80x25.org>	patch-709

    Summary:
      inode revalidation failure does not cause dentry unlink
    Revision:
      glusterfs--mainline--2.5--patch-709


    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-03-18 17:34:08 GMT	Amar Tumballi <amar@80x25.org>	patch-708

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-708

    
    * transport/ib-verbs.c: reverted back a small logging change. It caused the hang effect while using ib-verbs transport.
    
    * xlators/cluster/unify.c: added extensive logging. That is all the places where error is returned, Unify logs it.
    
    * {*.c,*.h}: changed _STACK_WIND() to STACK_WIND_COOKIE()
    

    modified files:
     libglusterfs/src/revision.h libglusterfs/src/stack.h
     scheduler/alu/src/alu.c scheduler/nufa/src/nufa.c
     scheduler/random/src/random.c scheduler/rr/src/rr.c
     transport/ib-verbs/ib-verbs.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/features/trash/src/trash.c xlators/meta/src/meta.c
     xlators/performance/booster/src/booster.c


2008-03-18 17:28:12 GMT	Anand V. Avati <avati@80x25.org>	patch-707

    Summary:
      fuse_thread_proc - break out on errno = ENODEV (compatibility with fuse 2.6.x)
    Revision:
      glusterfs--mainline--2.5--patch-707


    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-03-15 18:18:08 GMT	Amar Tumballi <amar@80x25.org>	patch-706

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-706

    * glusterfs/src/glusterfs.c: Minor changes to handle relative path for mountpoint.
    
    * fuse-bridge.c, configure.ac, compat.h: Darwin (MAC OS X) porting related changes.
    	- configure.ac: removed 'ib-sdp' from transport list
    	- compat.h: #define'd 'sighandler_t' to 'sig_t'
    	- fuse_bridge.c: sending "-o noexec" as macfuse mount_fusefs option.
    			 removed check for ENOEMPTY in unlink_cbk()'s gf_log.

    modified files:
     configure.ac glusterfs/src/glusterfs.c
     libglusterfs/src/compat.h libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-03-14 00:24:56 GMT	Amar Tumballi <amar@80x25.org>	patch-705

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-705

    * xlators/cluster/unify: Added a warning message when unify has only one subvolume
    
    * xlators/protocol/server: Fixed issues with missing handshake message in case of handshake failure.
    
    * libglusterfs/{glusterfs.h,common_utils.c}, glusterfs/src/glusterfs.c:
     	- Added dumping spec file for SIGUSR2 and SIGSEGV signal
    
    * INSTALL: minor update.

    modified files:
     INSTALL glusterfs/src/glusterfs.c
     libglusterfs/src/common-utils.c libglusterfs/src/glusterfs.h
     libglusterfs/src/revision.h xlators/cluster/unify/src/unify.c
     xlators/protocol/server/src/server-protocol.c


2008-03-12 06:51:18 GMT	Amar Tumballi <amar@80x25.org>	patch-704

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-704

    * storage/posix.c: added extra "option export-statfs-size no" which 
    	can solve the wrong 'df' output issue when the same disk
    	partition exported two times.
    
    * scheduler/nufa: Added feature to support multiple "local-volume-name"s 
    	to nufa scheduler.
    	Also changed the default minimum size from 5% to 15%.
    
    * updated doc/translator-option.txt with new options added.
    
    * cluster/stripe, transport/ib-verbs: minor changes 
    	-> cluster/stripe: initializing op_errno to ENOTCONN in statfs().
    	-> transport/ib-verbs: log added even when ibv_poll_cq returns 0.
    
    * scheduler/switch: Added a TODO 
    	"option switch.nufa.local-volume-name <volume>"

    modified files:
     doc/translator-option.txt libglusterfs/src/revision.h
     scheduler/nufa/src/nufa.c scheduler/nufa/src/nufa.h
     scheduler/switch/src/switch.c transport/ib-verbs/ib-verbs.c
     xlators/cluster/stripe/src/stripe.c
     xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2008-03-11 17:11:07 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-703

    Summary:
      Added Berkeley-DB version check in configure.ac
    Revision:
      glusterfs--mainline--2.5--patch-703

    
    
    * configure checks for Berkeley-DB version and disables storage/bdb if version < 4.6.21

    modified files:
     configure.ac libglusterfs/src/revision.h


2008-03-11 11:34:44 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-702

    Summary:
      build scripts fixed to disable building fuse with --disable-fuse-client
    Revision:
      glusterfs--mainline--2.5--patch-702

    
    
    * changed 'FUSE_CLIENT_SUBDIR=glusterfs-fuse' to 'FUSE_CLIENT_SUBDIR=fuse'
    * changed 'SUBDIRS = fuse' to 'SUBDIRS = @FUSE_CLIENT_SUBDIR@' in xlator/mount/Makefile.am

    modified files:
     configure.ac libglusterfs/src/revision.h
     xlators/mount/Makefile.am


2008-03-11 05:30:06 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-701

    Summary:
      minor bdb changes
    Revision:
      glusterfs--mainline--2.5--patch-701

    
    
    * removed all depencies on (loc_t *)->parent in bdb.

    modified files:
     libglusterfs/src/revision.h xlators/storage/bdb/src/bdb.c


2008-03-11 04:49:43 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-700

    Summary:
      fuse-bridge changes reverted.
    Revision:
      glusterfs--mainline--2.5--patch-700

    * changes to fuse bridge are reverted.
     - now fuse_loc_fill() takes only doesn't take 'ino_t par'.

    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-03-10 21:03:05 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-699

    Summary:
      * bdb feature upgrades. * minor changes to inode.c. * addition of new member to loc_t. * added review comments to afr. * minor changes to fuse-bridge.
    Revision:
      glusterfs--mainline--2.5--patch-699

    
    * bdb feature upgrades
     - bdb now supports multiple directories with all directory related fop support, except for rmdir.
     - bdb supports open, read, write, close on regular files. read and write also support seek on regular files.
     - unlink, link, symlink, readlink are not supported. unlink support will be added soon.
    
    * minor changes to inode.c
     - inode_parent() call returns parent inode of a given inode_t, even when ino_t of parent is unknown. inode_parent() procedure arbitrarily choses a parent inode from dir-cache and returns the parent inode_t pointer to caller.
    
    * addition of new member to loc_t
     - loc_t now also has 'inode_t *parent' member to accomodate for parent inode pointer.
    
    * minor changes to fuse-bridge
     - fuse_loc_fill() procedure takes an extra parameter 'ino_t par', parent inode number. 
     - all calls to fuse_loc_fill() are now changed to explicitly specify parent inode number. earlier practice was to identify the single ino_t parameter as parent inode number, when 'name' of the entry was specified.
    
    
    

    modified files:
     glusterfs-guts/src/guts-trace.c libglusterfs/src/Makefile.am
     libglusterfs/src/inode.c libglusterfs/src/revision.h
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h
     xlators/mount/fuse/src/fuse-bridge.c
     xlators/storage/bdb/src/Makefile.am
     xlators/storage/bdb/src/bdb.c xlators/storage/bdb/src/bdb.h
     xlators/storage/posix/src/posix.c


2008-03-10 19:57:53 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-698

    Summary:
      selfheal code is not executed if none of child_errno[] is 0.
    Revision:
      glusterfs--mainline--2.5--patch-698


    modified files:
     xlators/cluster/afr/src/afr.c


2008-03-07 17:40:34 GMT	Amar Tumballi <amar@80x25.org>	patch-697

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-697

    * Closing Bug #22503. (missing --pidfile)
    
    * Enhancing backtrace to print missing frames and command line arguments in log file. 
    
    * Also added a signal handler to SIGUSR2 to print TLA version, command line arguments, missing frames.
    
    

    modified files:
     glusterfs/src/glusterfs.c libglusterfs/src/common-utils.c
     libglusterfs/src/common-utils.h libglusterfs/src/glusterfs.h
     libglusterfs/src/protocol.h libglusterfs/src/revision.h
     xlators/mount/fuse/src/fuse-bridge.c


2008-03-05 15:43:56 GMT	Amar Tumballi <amar@80x25.org>	patch-696

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-696

    * enables switch scheduler to send multiple patterns to one volume.

    modified files:
     libglusterfs/src/revision.h scheduler/switch/src/switch.c


2008-03-05 10:17:40 GMT	Vikas Gorur <vikas@80x25.org>	patch-695

    Summary:
      fixed bug #22484. Return EAGAIN when lock cannot be set
    Revision:
      glusterfs--mainline--2.5--patch-695

    Thanks to Li Daobing for spotting this.
    

    modified files:
     libglusterfs/src/revision.h
     xlators/features/posix-locks/src/posix-locks.c


2008-03-05 03:12:33 GMT	Amar Tumballi <amar@80x25.org>	patch-694

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-694

    * fixed issues seen in MAC OS X ('df', 'vim', 'emacs' not working)

    modified files:
     glusterfs/src/Makefile.am libglusterfs/src/revision.h
     xlators/mount/fuse/src/Makefile.am
     xlators/mount/fuse/src/fuse-bridge.c
     xlators/storage/posix/src/Makefile.am
     xlators/storage/posix/src/posix.c


2008-03-04 13:56:02 GMT	Vikas Gorur <vikas@80x25.org>	patch-693

    Summary:
      minor fix in posix-locks
    Revision:
      glusterfs--mainline--2.5--patch-693

    Changed the check
      op_ret == 0
    to 
      op_ret >= 0
    in pl_open_cbk in posix-locks.c
    
    Thanks to LI Daobing for reporting this.
    

    modified files:
     libglusterfs/src/revision.h
     xlators/features/posix-locks/src/posix-locks.c


2008-03-04 04:41:27 GMT	Vikas Gorur <vikas@80x25.org>	patch-692

    Summary:
      Use higher-order bits for random number in rr
    Revision:
      glusterfs--mainline--2.5--patch-692

    From rand(3):
    
    ``However, on older rand() implementations, and on current
      implementations on different systems, the lower-order bits are
      much less random than the higher- order bits.''
    
    ``If you want to generate a random integer between 1 and 10, you
      should always do it by using high-order bits, as in
           j = 1 + (int) (10.0 * (rand() / (RAND_MAX + 1.0)));
      and never by anything resembling
           j = 1 + (rand() % 10);''

    modified files:
     libglusterfs/src/revision.h scheduler/random/src/random.c


2008-02-29 06:36:32 GMT	Amar Tumballi <amar@80x25.org>	patch-691

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-691

    
    * disabling direct_io mode in case of MAC OS X by default.
    
    * removed warnings in unify,posix,client-protocol.
    
    * added header files in glusterfs-guts/Makefile.am

    modified files:
     configure.ac glusterfs-guts/src/Makefile.am
     glusterfs/src/glusterfs.c libglusterfs/src/revision.h
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2008-02-28 08:31:47 GMT	Vikas Gorur <vikas@80x25.org>	patch-690

    Summary:
      added porting.txt
    Revision:
      glusterfs--mainline--2.5--patch-690

    
    

    new files:
     doc/.arch-ids/porting.txt.id doc/porting.txt

    modified files:
     libglusterfs/src/revision.h


2008-02-27 15:48:29 GMT	Amar Tumballi <amar@80x25.org>	patch-689

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-689

    * fixes for MAC OS X compilation. 
    * generation number fix in fuse-bridge.c to handle ESTALE in MacFUSE.

    modified files:
     autogen.sh configure.ac glusterfs/src/glusterfs.c
     libglusterfs/src/revision.h xlators/mount/fuse/src/Makefile.am
     xlators/mount/fuse/src/fuse-bridge.c


2008-02-26 16:42:53 GMT	Anand V. Avati <avati@80x25.org>	patch-688

    Summary:
      fixed copyright in mount.glusterfs.in
    Revision:
      glusterfs--mainline--2.5--patch-688


    modified files:
     libglusterfs/src/revision.h
     xlators/mount/fuse/utils/mount.glusterfs.in


2008-02-26 15:23:49 GMT	Amar Tumballi <amar@80x25.org>	patch-687

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-687

    * cluster/afr: a fix in rename() to return the same inode number in stbuf.
    
    * storage/posix: added O_DIRECT option handling in writev(). It was already added to readv().
    

    modified files:
     libglusterfs/src/revision.h xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2008-02-26 14:19:18 GMT	Anand V. Avati <avati@80x25.org>	patch-686

    Summary:
      fuse xlator, single glusterfs/fsd binary
    Revision:
      glusterfs--mainline--2.5--patch-686

    merge from glusterfs--fuse-xlator--1.0

    new files:
     glusterfs/src/.arch-ids/Makefile.am.id
     glusterfs/src/Makefile.am xlators/mount/.arch-ids/=id
     xlators/mount/.arch-ids/Makefile.am.id
     xlators/mount/Makefile.am xlators/mount/fuse/.arch-ids/=id
     xlators/mount/fuse/.arch-ids/Makefile.am.id
     xlators/mount/fuse/Makefile.am
     xlators/mount/fuse/src/.arch-ids/=id
     xlators/mount/fuse/src/.arch-ids/Makefile.am.id
     xlators/mount/fuse/src/Makefile.am

    removed files:
     glusterfs-fuse/src/.arch-ids/Makefile.am.id
     glusterfs-fuse/src/Makefile.am glusterfs-shell/.arch-ids/=id
     glusterfs-shell/.arch-ids/Makefile.am.id
     glusterfs-shell/Makefile.am
     glusterfs-shell/examples/.arch-ids/=id
     glusterfs-shell/extensions/.arch-ids/=id
     glusterfs-shell/extensions/.arch-ids/Makefile.am.id
     glusterfs-shell/extensions/.arch-ids/commands.scm.id
     glusterfs-shell/extensions/.arch-ids/cp.scm.id
     glusterfs-shell/extensions/.arch-ids/hello.scm.id
     glusterfs-shell/extensions/.arch-ids/hello_test.scm.id
     glusterfs-shell/extensions/.arch-ids/mkdir.scm.id
     glusterfs-shell/extensions/.arch-ids/readdir.scm.id
     glusterfs-shell/extensions/.arch-ids/readfile.scm.id
     glusterfs-shell/extensions/.arch-ids/readlink.scm.id
     glusterfs-shell/extensions/.arch-ids/stat.scm.id
     glusterfs-shell/extensions/.arch-ids/test.scm.id
     glusterfs-shell/extensions/Makefile.am
     glusterfs-shell/extensions/commands.scm
     glusterfs-shell/extensions/cp.scm
     glusterfs-shell/extensions/hello.scm
     glusterfs-shell/extensions/hello_test.scm
     glusterfs-shell/extensions/mkdir.scm
     glusterfs-shell/extensions/readdir.scm
     glusterfs-shell/extensions/readfile.scm
     glusterfs-shell/extensions/readlink.scm
     glusterfs-shell/extensions/stat.scm
     glusterfs-shell/extensions/test.scm
     glusterfs-shell/src/.arch-ids/=id
     glusterfs-shell/src/.arch-ids/Makefile.am.id
     glusterfs-shell/src/.arch-ids/extensions.c.id
     glusterfs-shell/src/.arch-ids/extensions.h.id
     glusterfs-shell/src/.arch-ids/fops.c.id
     glusterfs-shell/src/.arch-ids/fops.h.id
     glusterfs-shell/src/.arch-ids/init.c.id
     glusterfs-shell/src/.arch-ids/interpreter.c.id
     glusterfs-shell/src/.arch-ids/interpreter.h.id
     glusterfs-shell/src/.arch-ids/primitives.c.id
     glusterfs-shell/src/.arch-ids/primitives.h.id
     glusterfs-shell/src/.arch-ids/shell.c.id
     glusterfs-shell/src/.arch-ids/shell.h.id
     glusterfs-shell/src/Makefile.am
     glusterfs-shell/src/extensions.c
     glusterfs-shell/src/extensions.h glusterfs-shell/src/fops.c
     glusterfs-shell/src/fops.h glusterfs-shell/src/init.c
     glusterfs-shell/src/interpreter.c
     glusterfs-shell/src/interpreter.h
     glusterfs-shell/src/primitives.c
     glusterfs-shell/src/primitives.h glusterfs-shell/src/shell.c
     glusterfs-shell/src/shell.h glusterfsd/.arch-ids/=id
     glusterfsd/.arch-ids/Makefile.am.id glusterfsd/Makefile.am
     glusterfsd/src/.arch-ids/=id
     glusterfsd/src/.arch-ids/Makefile.am.id
     glusterfsd/src/.arch-ids/glusterfsd.c.id
     glusterfsd/src/Makefile.am glusterfsd/src/glusterfsd.c

    modified files:
     Makefile.am configure.ac glusterfs/Makefile.am
     glusterfs/src/glusterfs.c glusterfs/src/glusterfsd.h
     libglusterfs/src/glusterfs.h libglusterfs/src/lock.c
     libglusterfs/src/revision.h xlators/Makefile.am
     xlators/mount/fuse/src/fuse-bridge.c

    renamed files:
     glusterfs-fuse/.arch-ids/=id
       ==> glusterfs/.arch-ids/=id
     glusterfs-fuse/.arch-ids/Makefile.am.id
       ==> glusterfs/.arch-ids/Makefile.am.id
     glusterfs-fuse/src/.arch-ids/=id
       ==> glusterfs/src/.arch-ids/=id
     glusterfs-fuse/src/.arch-ids/fetch-spec.c.id
       ==> glusterfs/src/.arch-ids/fetch-spec.c.id
     glusterfs-fuse/src/.arch-ids/fuse-bridge.c.id
       ==> xlators/mount/fuse/src/.arch-ids/fuse-bridge.c.id
     glusterfs-fuse/src/.arch-ids/fuse-extra.c.id
       ==> xlators/mount/fuse/src/.arch-ids/fuse-extra.c.id
     glusterfs-fuse/src/.arch-ids/fuse-extra.h.id
       ==> xlators/mount/fuse/src/.arch-ids/fuse-extra.h.id
     glusterfs-fuse/src/.arch-ids/glusterfs-fuse.h.id
       ==> glusterfs/src/.arch-ids/glusterfsd.h.id
     glusterfs-fuse/src/.arch-ids/glusterfs.c.id
       ==> glusterfs/src/.arch-ids/glusterfs.c.id
     glusterfs-fuse/src/fuse-bridge.c
       ==> xlators/mount/fuse/src/fuse-bridge.c
     glusterfs-fuse/src/fuse-extra.c
       ==> xlators/mount/fuse/src/fuse-extra.c
     glusterfs-fuse/src/fuse-extra.h
       ==> xlators/mount/fuse/src/fuse-extra.h
     glusterfs-fuse/src/glusterfs-fuse.h
       ==> glusterfs/src/glusterfsd.h
     glusterfs-fuse/utils/.arch-ids/=id
       ==> xlators/mount/fuse/utils/.arch-ids/=id
     glusterfs-fuse/utils/.arch-ids/Makefile.am.id
       ==> xlators/mount/fuse/utils/.arch-ids/Makefile.am.id
     glusterfs-fuse/utils/.arch-ids/mount.glusterfs.in.id
       ==> xlators/mount/fuse/utils/.arch-ids/mount.glusterfs.in.id

    new directories:
     glusterfs/.arch-ids glusterfs/src/.arch-ids xlators/mount
     xlators/mount/.arch-ids xlators/mount/fuse
     xlators/mount/fuse/.arch-ids xlators/mount/fuse/src
     xlators/mount/fuse/src/.arch-ids
     xlators/mount/fuse/utils/.arch-ids

    removed directories:
     glusterfs-fuse/.arch-ids glusterfs-fuse/src/.arch-ids
     glusterfs-fuse/utils/.arch-ids glusterfs-shell
     glusterfs-shell/.arch-ids glusterfs-shell/examples
     glusterfs-shell/examples/.arch-ids glusterfs-shell/extensions
     glusterfs-shell/extensions/.arch-ids glusterfs-shell/src
     glusterfs-shell/src/.arch-ids glusterfsd glusterfsd/.arch-ids
     glusterfsd/src glusterfsd/src/.arch-ids

    renamed directories:
     glusterfs-fuse
       ==> glusterfs
     glusterfs-fuse/utils
       ==> xlators/mount/fuse/utils

    new patches:
     avati@zresearch.com/glusterfs--fuse-xlator--1.0--base-0
     avati@zresearch.com/glusterfs--fuse-xlator--1.0--patch-1
     avati@zresearch.com/glusterfs--fuse-xlator--1.0--patch-2
     avati@zresearch.com/glusterfs--fuse-xlator--1.0--patch-3
     avati@zresearch.com/glusterfs--fuse-xlator--1.0--patch-4


2008-02-26 14:32:53 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-685

    Summary:
      fixed compiler warnings in afr resulted from my previous commit
    Revision:
      glusterfs--mainline--2.5--patch-685


    modified files:
     xlators/cluster/afr/src/afr.c


2008-02-26 10:52:50 GMT	Vikas Gorur <vikas@80x25.org>	patch-684

    Summary:
      Defined constants for POSIX lock types
    Revision:
      glusterfs--mainline--2.5--patch-684

    glusterfs.h: define constants for F_RDLCK, etc.
    server-protocol.c, client-protocol.c: change _lk calls to use the above
    constants, and avoid passing system-dependant numbers on the network.
    

    modified files:
     libglusterfs/src/glusterfs.h libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2008-02-26 10:58:27 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-683

    Summary:
      
	* fixed deadlock caused in a setup with afr on top of afr (second afr is mirrored namespace of unify). Bug was due to both afrs trying to heal the same file.
    Revision:
      glusterfs--mainline--2.5--patch-683


    modified files:
     xlators/cluster/afr/src/afr.c


2008-02-26 05:48:26 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-682

    Summary:
      Forgot to append path with a trailing '/'  in mop_unlock_impl in patch-679
    Revision:
      glusterfs--mainline--2.5--patch-682


    modified files:
     libglusterfs/src/lock.c


2008-02-25 23:52:32 GMT	Amar Tumballi <amar@80x25.org>	patch-681

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-681

    * added '--disable-bdb' option to configure.

    modified files:
     configure.ac extras/glusterfs-mode.el glusterfs.spec.in
     libglusterfs/src/revision.h xlators/storage/Makefile.am


2008-02-25 12:26:53 GMT	Vikas Gorur <vikas@80x25.org>	patch-680

    Summary:
      Mac OS X fixes
    Revision:
      glusterfs--mainline--2.5--patch-680

    posix.c: Use d_seekoff on Mac OS X.
    libglusterfs/src/authenticate.c: Made nested functions un-nested.
    

    modified files:
     Makefile.am glusterfs-fuse/src/fuse-bridge.c
     libglusterfs/src/authenticate.c libglusterfs/src/revision.h
     xlators/storage/posix/src/posix.c


2008-02-25 11:17:03 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-679

    Summary:
      
	* comment out frame->root->trans = NULL in server_protocol_cleanup, since mop_unlock_impl needs ptr to transport for clearing locks held by it
	* Add a trailing / to pathnames, so that locking mechanism works for files also.
    Revision:
      glusterfs--mainline--2.5--patch-679


    modified files:
     libglusterfs/src/lock.c
     xlators/protocol/server/src/server-protocol.c


2008-02-21 22:26:54 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-678

    Summary:
      glusterfs-guts version-0.0.0.009 committed for first time.
    Revision:
      glusterfs--mainline--2.5--patch-678

    * glusterfs-guts is a unit testing suite for glusterfs. glusterfs-guts can be run in two modes:
         1. trace mode - in this mode guts mounts glusterfs to a mount-point provided as command line argument. user can perform usual filesystem operations on the mount-point. difference from the normal glusterfs mount will be that guts logs each of the fop onto the tio (read trace-input-output) file, whose path should be specified on command-line while starting guts.
            command-line for starting guts in trace mode:
             glusterfs-guts -f <spec-file> -T <mount-point> -o <tio-file-path>
         2. replay mode - in this mode guts replays the filesystem operations onto unmounted glusterfs tree, by reading from the tio file specified on command-line.
            command-line for starting a single-threaded guts in replay mode:
             glusterfs-guts -f <spec-file> -t 1 -i <tio-file-path>
    
    * glusterfs-guts is not tested as of now. please do not use glusterfs-guts, unless you are testing glusterfs-guts itself. :O
    
    

    new files:
     glusterfs-guts/.arch-ids/=id
     glusterfs-guts/.arch-ids/Makefile.am.id
     glusterfs-guts/Makefile.am glusterfs-guts/src/.arch-ids/=id
     glusterfs-guts/src/.arch-ids/Makefile.am.id
     glusterfs-guts/src/.arch-ids/fuse-bridge.c.id
     glusterfs-guts/src/.arch-ids/fuse-extra.c.id
     glusterfs-guts/src/.arch-ids/fuse-extra.h.id
     glusterfs-guts/src/.arch-ids/fuse_kernel.h.id
     glusterfs-guts/src/.arch-ids/glusterfs-fuse.h.id
     glusterfs-guts/src/.arch-ids/glusterfs-guts.c.id
     glusterfs-guts/src/.arch-ids/glusterfs-guts.h.id
     glusterfs-guts/src/.arch-ids/guts-extra.c.id
     glusterfs-guts/src/.arch-ids/guts-lowlevel.h.id
     glusterfs-guts/src/.arch-ids/guts-parse.c.id
     glusterfs-guts/src/.arch-ids/guts-parse.h.id
     glusterfs-guts/src/.arch-ids/guts-replay.c.id
     glusterfs-guts/src/.arch-ids/guts-replay.h.id
     glusterfs-guts/src/.arch-ids/guts-tables.c.id
     glusterfs-guts/src/.arch-ids/guts-tables.h.id
     glusterfs-guts/src/.arch-ids/guts-trace.c.id
     glusterfs-guts/src/.arch-ids/guts-trace.h.id
     glusterfs-guts/src/Makefile.am
     glusterfs-guts/src/fuse-bridge.c
     glusterfs-guts/src/fuse-extra.c
     glusterfs-guts/src/fuse-extra.h
     glusterfs-guts/src/fuse_kernel.h
     glusterfs-guts/src/glusterfs-fuse.h
     glusterfs-guts/src/glusterfs-guts.c
     glusterfs-guts/src/glusterfs-guts.h
     glusterfs-guts/src/guts-extra.c
     glusterfs-guts/src/guts-lowlevel.h
     glusterfs-guts/src/guts-parse.c
     glusterfs-guts/src/guts-parse.h
     glusterfs-guts/src/guts-replay.c
     glusterfs-guts/src/guts-replay.h
     glusterfs-guts/src/guts-tables.c
     glusterfs-guts/src/guts-tables.h
     glusterfs-guts/src/guts-trace.c
     glusterfs-guts/src/guts-trace.h

    modified files:
     Makefile.am configure.ac libglusterfs/src/revision.h

    new directories:
     glusterfs-guts glusterfs-guts/.arch-ids glusterfs-guts/src
     glusterfs-guts/src/.arch-ids


2008-02-19 18:42:16 GMT	Amar Tumballi <amar@80x25.org>	patch-677

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-677

    * Added 'strorage/bdb' translator. === Not usable yet ===

    new files:
     xlators/storage/bdb/.arch-ids/=id
     xlators/storage/bdb/.arch-ids/Makefile.am.id
     xlators/storage/bdb/Makefile.am
     xlators/storage/bdb/src/.arch-ids/=id
     xlators/storage/bdb/src/.arch-ids/Makefile.am.id
     xlators/storage/bdb/src/.arch-ids/bdb.c.id
     xlators/storage/bdb/src/.arch-ids/bdb.h.id
     xlators/storage/bdb/src/Makefile.am
     xlators/storage/bdb/src/bdb.c xlators/storage/bdb/src/bdb.h

    modified files:
     configure.ac libglusterfs/src/revision.h
     xlators/storage/Makefile.am

    new directories:
     xlators/storage/bdb xlators/storage/bdb/.arch-ids
     xlators/storage/bdb/src xlators/storage/bdb/src/.arch-ids


2008-02-19 16:16:24 GMT	Anand V. Avati <avati@80x25.org>	patch-676

    Summary:
      notify event fixes in ib_verbs_tcp_notify
    Revision:
      glusterfs--mainline--2.5--patch-676


    modified files:
     libglusterfs/src/revision.h transport/ib-verbs/ib-verbs.c


2008-02-19 15:43:57 GMT	Anand V. Avati <avati@80x25.org>	patch-675

    Summary:
      forward the right event from ib_verbs_tcp_notify to xlator
    Revision:
      glusterfs--mainline--2.5--patch-675


    modified files:
     libglusterfs/src/revision.h transport/ib-verbs/ib-verbs.c


2008-02-19 07:34:55 GMT	Amar Tumballi <amar@80x25.org>	patch-674

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-674

    * extras/glusterfs-mode.el : 
    	Now more options are highlighted. 
    	Supports indentation.
    
    * protocol/client, protocol/server, libglusterfs/authenticate.c: 
       	Change in log level of few log messages.
    
    

    modified files:
     extras/glusterfs-mode.el libglusterfs/src/authenticate.c
     libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2008-02-19 05:10:40 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-673

    Summary:
      fixed build error introduced in my last commit
    Revision:
      glusterfs--mainline--2.5--patch-673


    modified files:
     xlators/protocol/server/src/server-protocol.c


2008-02-18 12:27:25 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-672

    Summary:
      Introducing reference counting of transports. A notification is sent and transport is destroyed when the refernce count reaches 0.
    Revision:
      glusterfs--mainline--2.5--patch-672

    
    

    modified files:
     libglusterfs/src/glusterfs.h libglusterfs/src/transport.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2008-02-18 11:02:00 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-671

    Summary:
      Fixed memory corruption due to writing beyond allocated memory in posix_readdir.
    Revision:
      glusterfs--mainline--2.5--patch-671


    modified files:
     xlators/storage/posix/src/posix.c


2008-02-18 03:12:10 GMT	Anand V. Avati <avati@80x25.org>	patch-670

    Summary:
      reverted d_off changes
    Revision:
      glusterfs--mainline--2.5--patch-670


    modified files:
     libglusterfs/src/revision.h xlators/storage/posix/src/posix.c


2008-02-18 02:46:22 GMT	Anand V. Avati <avati@80x25.org>	patch-669

    Summary:
      typo in posix-locks (endf)
    Revision:
      glusterfs--mainline--2.5--patch-669


    modified files:
     libglusterfs/src/revision.h
     xlators/features/posix-locks/src/posix-locks.c


2008-02-17 07:38:24 GMT	Anand V. Avati <avati@80x25.org>	patch-668

    Summary:
      define LLONG_MAX for old gcc
    Revision:
      glusterfs--mainline--2.5--patch-668


    modified files:
     libglusterfs/src/revision.h
     xlators/features/posix-locks/src/posix-locks.c


2008-02-16 19:09:36 GMT	Vikas Gorur <vikas@80x25.org>	patch-667

    Summary:
      Ported GlusterFS to Mac OS X
    Revision:
      glusterfs--mainline--2.5--patch-667

    configure.ac: 
      libtool is glibtool
      various Mac OS X specific variables
    
    libglusterfs: CFLAGS='-fnested-functions'
    
    common-utils.h: use mutexes if spinlocks not available.
    
    xlators/*; scheduler/*; auth/*: CFLAGS changes
    
    server-protocol.c, trace.c: converted nested functions to non-nested functions
    
    compat.h: prototypes for extended attribute functions
    
    fuse-bridge.c: option -o nonempty is not present on Mac OS X.
    
    compat.h: fixed argp_parse_ to handle non-option arguments as well. 
              wrote function argp_help to print --help message.

    modified files:
     auth/ip/src/Makefile.am auth/login/src/Makefile.am
     configure.ac glusterfs-fuse/src/Makefile.am
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/Makefile.am libglusterfs/src/common-utils.h
     libglusterfs/src/compat.c libglusterfs/src/compat.h
     libglusterfs/src/revision.h scheduler/alu/src/Makefile.am
     scheduler/nufa/src/Makefile.am
     scheduler/random/src/Makefile.am scheduler/rr/src/Makefile.am
     scheduler/switch/src/Makefile.am
     transport/ib-sdp/client/src/Makefile.am
     transport/ib-sdp/server/src/Makefile.am
     transport/tcp/client/src/Makefile.am
     transport/tcp/server/src/Makefile.am
     transport/unix/client/src/Makefile.am
     transport/unix/server/src/Makefile.am
     xlators/cluster/afr/src/Makefile.am
     xlators/cluster/stripe/src/Makefile.am
     xlators/cluster/unify/src/Makefile.am
     xlators/debug/trace/src/Makefile.am
     xlators/debug/trace/src/trace.c
     xlators/encryption/rot-13/src/Makefile.am
     xlators/features/filter/src/Makefile.am
     xlators/features/fixed-id/src/Makefile.am
     xlators/features/posix-locks/src/Makefile.am
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/trash/src/Makefile.am
     xlators/performance/booster/src/Makefile.am
     xlators/performance/booster/src/entry.c
     xlators/performance/io-cache/src/Makefile.am
     xlators/performance/io-threads/src/Makefile.am
     xlators/performance/read-ahead/src/Makefile.am
     xlators/performance/write-behind/src/Makefile.am
     xlators/protocol/client/src/Makefile.am
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/Makefile.am
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/Makefile.am
     xlators/storage/posix/src/posix.c


2008-02-15 18:54:10 GMT	Vikas Gorur <vikas@80x25.org>	patch-666

    Summary:
      changed ULONG_MAX to LLONG_MAX in posix-locks.c
    Revision:
      glusterfs--mainline--2.5--patch-666

    From LI Daobing:
    
    > if (flock->l_len == 0)
    >   lock->fl_end = ULONG_MAX;
    
    > fl_end is "signed long long" type pretty much everywhere. The main bug
    > here is that with 64bit systems ULONG_MAX gets converted to -1, and
    > l_len=0 locks break completely.
    
    > So, this should work better:
    > lock->fl_end = LLONG_MAX;
    
    Thanks to LI Daobing for this observation.

    modified files:
     libglusterfs/src/revision.h
     xlators/features/posix-locks/src/posix-locks.c


2008-02-15 06:50:32 GMT	Anand V. Avati <avati@80x25.org>	patch-665

    Summary:
      stat on proper path in checksum
    Revision:
      glusterfs--mainline--2.5--patch-665

    
    

    modified files:
     libglusterfs/src/revision.h
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2008-02-15 06:54:37 GMT	Amar Tumballi <amar@80x25.org>	patch-664

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-664

    * debug/trace: added mops->checksum call to the trace list
    * cluster/unify: handled a case where return value of getdents is -1.

    modified files:
     doc/translator-option.txt libglusterfs/src/revision.h
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/debug/trace/src/trace.c


2008-02-12 16:41:57 GMT	Anand V. Avati <avati@80x25.org>	patch-663

    Summary:
      include build time with date in --version output
    Revision:
      glusterfs--mainline--2.5--patch-663


    modified files:
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/revision.h


2008-02-12 12:36:56 GMT	Amar Tumballi <amar@80x25.org>	patch-662

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-662

    * gf_print_bracktrace(): enhanced the function to print the revision id.
    
    * misc:
      - client-protocol.c : removed warning 'gf_cmd uninitialised'
      - compat.c : changed order of definition of header files. (<dirent.h> before "compat.h")
      - translator-options.txt : updated with current options

    modified files:
     doc/translator-option.txt libglusterfs/src/common-utils.c
     libglusterfs/src/compat.c libglusterfs/src/revision.h
     xlators/protocol/client/src/client-protocol.c


2008-02-12 12:12:43 GMT	Anand V. Avati <avati@80x25.org>	patch-661

    Summary:
      updated glusterfs.spec (rpm build) from Matt Paine
    Revision:
      glusterfs--mainline--2.5--patch-661


    modified files:
     configure.ac glusterfs.spec.in


2008-02-12 10:23:42 GMT	Anand V. Avati <avati@80x25.org>	patch-660

    Summary:
      tla add'ed commit.sh :)
    Revision:
      glusterfs--mainline--2.5--patch-660


    new files:
     .arch-ids/commit.sh.id commit.sh


2008-02-12 10:15:23 GMT	Anand V. Avati <avati@80x25.org>	patch-659

    Summary:
      moved revision.h to libglusterfs/src/revision.h
    Revision:
      glusterfs--mainline--2.5--patch-659


    modified files:
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/Makefile.am libglusterfs/src/revision.h

    renamed files:
     .arch-ids/revision.h.id
       ==> libglusterfs/src/.arch-ids/revision.h.id
     revision.h
       ==> libglusterfs/src/revision.h


2008-02-12 10:04:44 GMT	Anand V. Avati <avati@80x25.org>	patch-658

    Summary:
      added repository revision to --version output. all developers should run ./commit.sh instead of 'tla commit'.
    Revision:
      glusterfs--mainline--2.5--patch-658


    new files:
     .arch-ids/revision.h.id revision.h

    modified files:
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c


2008-02-12 07:48:00 GMT	Anand V. Avati <avati@80x25.org>	patch-657

    Summary:
      updated copyright to 2008, updated configure script to not fail, but print configure summary at the end
    Revision:
      glusterfs--mainline--2.5--patch-657


    modified files:
     Makefile.am auth/ip/src/ip.c auth/login/src/login.c autogen.sh
     configure.ac glusterfs-fuse/src/Makefile.am
     glusterfs-fuse/src/fetch-spec.c
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/fuse-extra.c
     glusterfs-fuse/src/fuse-extra.h
     glusterfs-fuse/src/glusterfs-fuse.h
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/authenticate.c
     libglusterfs/src/authenticate.h libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/common-utils.c
     libglusterfs/src/common-utils.h libglusterfs/src/compat.c
     libglusterfs/src/compat.h libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/dict.c
     libglusterfs/src/dict.h libglusterfs/src/epoll.c
     libglusterfs/src/fd.c libglusterfs/src/fd.h
     libglusterfs/src/glusterfs.h libglusterfs/src/hashfn.c
     libglusterfs/src/hashfn.h libglusterfs/src/inode.c
     libglusterfs/src/inode.h libglusterfs/src/lock.c
     libglusterfs/src/lock.h libglusterfs/src/logging.c
     libglusterfs/src/logging.h libglusterfs/src/poll.c
     libglusterfs/src/protocol.c libglusterfs/src/protocol.h
     libglusterfs/src/scheduler.c libglusterfs/src/scheduler.h
     libglusterfs/src/stack.h libglusterfs/src/timer.c
     libglusterfs/src/timer.h libglusterfs/src/transport.c
     libglusterfs/src/transport.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h scheduler/alu/src/alu.c
     scheduler/alu/src/alu.h scheduler/nufa/src/nufa.c
     scheduler/nufa/src/nufa.h scheduler/random/src/random.c
     scheduler/random/src/random.h scheduler/rr/src/rr.c
     scheduler/rr/src/rr.h scheduler/switch/src/switch.c
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-sdp/ib-sdp.c transport/ib-sdp/ib-sdp.h
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c transport/ib-verbs/ib-verbs.h
     transport/ib-verbs/server/src/ib-verbs-server.c
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/src/tcp-server.c transport/tcp/tcp.c
     transport/tcp/tcp.h transport/unix/client/src/unix-client.c
     transport/unix/server/src/unix-server.c transport/unix/unix.c
     transport/unix/unix.h xlators/bindings/python/src/python.c
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c
     xlators/encryption/rot-13/src/rot-13.c
     xlators/encryption/rot-13/src/rot-13.h
     xlators/features/filter/src/filter.c
     xlators/features/filter/src/filter.h
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/posix-locks/src/posix-locks.h
     xlators/features/trash/src/trash.c xlators/meta/src/meta.c
     xlators/meta/src/meta.h xlators/meta/src/misc.c
     xlators/meta/src/misc.h xlators/meta/src/tree.c
     xlators/meta/src/tree.h xlators/meta/src/view.c
     xlators/meta/src/view.h
     xlators/performance/booster/src/booster.c
     xlators/performance/booster/src/booster.h
     xlators/performance/booster/src/bridge.c
     xlators/performance/booster/src/entry.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/read-ahead/src/read-ahead.h
     xlators/performance/stat-prefetch/src/stat-prefetch.c
     xlators/performance/stat-prefetch/src/stat-prefetch.h
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h
     xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2008-02-11 13:35:58 GMT	Amar Tumballi <amar@80x25.org>	patch-656

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-656

    * libglusterfs/src/compat.{h,c}: 
      - added dirfd patch by Harshavardhana R <harsha@zresearch.com>
      - corrected the return value of setxattr wrapper function.
    
    * xlators/cluster/unify:
      - unify rename rewrite.

    modified files:
     libglusterfs/src/compat.c libglusterfs/src/compat.h
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2008-02-11 14:37:53 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-655

    Summary:
      changed the dates in the copyright headers of previous commit to 2007, 2008 instead of 2008
    Revision:
      glusterfs--mainline--2.5--patch-655


    modified files:
     auth/ip/src/ip.c auth/login/src/login.c
     libglusterfs/src/authenticate.c
     libglusterfs/src/authenticate.h libglusterfs/src/fd.c
     libglusterfs/src/fd.h


2008-02-11 14:25:29 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-654

    Summary:
      Added copyright headers 
    Revision:
      glusterfs--mainline--2.5--patch-654


    modified files:
     auth/ip/src/ip.c auth/login/src/login.c
     libglusterfs/src/authenticate.c
     libglusterfs/src/authenticate.h libglusterfs/src/fd.c
     libglusterfs/src/fd.h


2008-02-09 21:59:12 GMT	Amar Tumballi <amar@80x25.org>	patch-653

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-653

    * libglusterfs/src/spec.y: 
    	Proper handling of errors in spec file.
    
    * libglusterfs/src/scheduler.c: 
    	Initialization errors while loading scheduler was causing 'exit(1)' changed it to  'return NULL', hence, proper umount happens in case of errors.
    
    * xlators/cluster/afr.c: 
    	Minor changes in output of init()'s error log messages.
    
    * xlators/protocol/server-protocol.c:
    	Added code to keep generation number, and st_mode of the newly created inode, incase of lookup_cbk. This avoids lots of ESTALE errors, which are seen if unify is loaded on server side.
    
    * xlators/cluster/unify.c:
    	Review for missing frames. And removed unnecessary if statements, and complex nestings.
    
    	

    modified files:
     libglusterfs/src/scheduler.c libglusterfs/src/spec.y
     xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/server/src/server-protocol.c


2008-02-08 12:17:53 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-652

    Summary:
      removed static modifier for fops in translators
    Revision:
      glusterfs--mainline--2.5--patch-652


    modified files:
     xlators/bindings/python/src/python.c
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/encryption/rot-13/src/rot-13.c
     xlators/features/filter/src/filter.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/trash/src/trash.c xlators/meta/src/meta.c
     xlators/performance/booster/src/booster.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/stat-prefetch/src/stat-prefetch.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2008-02-08 10:41:43 GMT	Anand V. Avati <avati@80x25.org>	patch-651

    Summary:
      make window-size optional on tcp/client too
    Revision:
      glusterfs--mainline--2.5--patch-651

    
    

    modified files:
     transport/tcp/client/src/tcp-client.c


2008-02-07 13:12:34 GMT	Anand V. Avati <avati@80x25.org>	patch-650

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-650

    dict.c: make _copy a standalone static function
    
    transport/tcp: make window size setting optional
    
    unify: getxattr return -1/EIO when files not reachable other than NS

    modified files:
     libglusterfs/src/dict.c transport/tcp/server/src/tcp-server.c
     xlators/cluster/unify/src/unify.c


2008-02-07 11:47:07 GMT	Amar Tumballi <amar@80x25.org>	patch-649

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-649

    
    * Fixes in unify/self-heal: 
      - issues of missing frame in lookup, and missing closedir() call to NS node is fixed.
    
    * Unify: 
      - fixed a issue with lookup, when it was returning ENOENT if the file is in only NS.

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2008-02-05 18:05:05 GMT	Amar Tumballi <amar@80x25.org>	patch-648

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-648

    * xlators/cluster/unify:
      -> unify.c:
         Fixes in all the places where 'need_break' logic was not appropriate. Thanks to 'Du', ie, Raghavendra G <raghavendra@zresearch.com>
    
      -> unify-self-heal.c:
         Fixed the hanging frame issue, in case of unify self-heal. 
         There was a corner case issue where, frame used to get destroyed because of wrong calculation of call_count. Fixed.
    
    

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2008-02-04 12:58:09 GMT	Amar Tumballi <amar@80x25.org>	patch-647

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-647

    
    * cluster/afr:
      - undid the change done in previous commit (memset 0, instead of ENOTCONN in create()
    
    * protocol/server: 
      - Bug : When AFR is on server side, ENOTCONN was not handled properly. Also seen missing unlink() calls in the same scenario.
        Fix : (ref: patch-640) Code similar to the one added in fuse-bridge.c:fuse_create(), is added in server_create().
    
    * cluster/unify: 
      - Bug : Missing chmod/chown/utimes/truncate calls
      - Fix : (ref: patch-640) While changing from background frames to the current frame, missing frame case was not handled. Added STACK_UNWIND() in place of commented STACK_DESTROY.

    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/server/src/server-protocol.c


2008-02-01 10:28:45 GMT	Amar Tumballi <amar@80x25.org>	patch-646

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-646

    * libglusterfs/src/logging*:
      xlators/debug/trace : 
      - Added another log level 'GF_LOG_NORMAL' which is used by only trace translator right now. So, all DEBUG logs doesn't showup when someone enables trace translator.
    
    * xlators/cluster/afr:
      - One small fix in afr_create_cbk(), setting child_errno to 0, instead of ENOTCONN. 

    modified files:
     libglusterfs/src/logging.c libglusterfs/src/logging.h
     xlators/cluster/afr/src/afr.c xlators/debug/trace/src/trace.c


2008-01-31 18:24:55 GMT	Amar Tumballi <amar@80x25.org>	patch-645

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-645

    * cluster/afr: Made 'fd->ctx' to 'local->fd->ctx' in afr_selfheal_open_cbk().
    
    * cluster/unify: 'Bug #22187'
      Fix: Unify sends 'stat' and 'fstat' instead of truncate and ftruncate to NS brick. This will fix the issue of file sizes more than 0byte in Namespace brick.
    
    
    * cluster/unify-self-heal: Changed the #define'd macro name.

    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2008-01-30 11:14:50 GMT	Amar Tumballi <amar@80x25.org>	patch-644

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-644

    * debug/trace: 
       - implemented readdir ().
    
    * storage/posix:
       - Fixed BugID # 22175 (Savannah)
         Now, posix translator fails to initialize if the specified directory doesn't exists, with an error message in the log file.
    
    

    modified files:
     xlators/debug/trace/src/trace.c
     xlators/storage/posix/src/posix.c


2008-01-26 05:17:18 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-643

    Summary:
      missed commenting out stack destroy of background frames in ns_chmod_cbk, ns_chown_cbk, ns_utimens_cbk (ref: patch-640)
    Revision:
      glusterfs--mainline--2.5--patch-643


    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2008-01-25 22:56:23 GMT	Amar Tumballi <amar@80x25.org>	patch-642

    Summary:
      CRITICAL BUG FIX IN UNIFY_SELF_HEAL
    Revision:
      glusterfs--mainline--2.5--patch-642

    * Bug #21884 : fix typo in log  -- patch applied
    
    * storage/posix:
    
      readdir(): if offset is not zero, do a seekdir() to get the proper offset. Fixes a bug of hanging of 'ls' due to 100% cpu usage in case of NFS re-export.
    
      getdents(): There was a bug in the case when GF_GET_DIR_ONLY flag is set. the condition to check whether the direntry is directory or file was never satisfied, hence even when that flag is set, all the content in the directory used to be returned, causing unify self heal to fail. 
      fix: get the stat of the proper path (absolute path) to decide if its directory or not.
    
    * cluster/unify/src/unify-self-heal.c:
      libglusterfs/src/glusterfs.h:
      -> added another extra flag to setdents fop. GF_SET_DIR_ONLY, if set only mkdir() is done in posix level, even if there are other entries.
    
    ------------
    This patch fixes the critical bug of creating 0 bytes files in the glusterfs backend, which makes glusterfs to fail by returning ESTALE/EIO for further operation on the file.
    
    This behavior is seen only if the NS is built freshly from the patches above 636. 

    modified files:
     libglusterfs/src/glusterfs.h xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/storage/posix/src/posix.c


2008-01-24 08:26:38 GMT	Anand V. Avati <avati@80x25.org>	patch-641

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-641

    * write-behind: disable write-behind for 1st 1MB of file writes (small size perf workaround)
    * transport/tcp: set window size to 640KByte
    * stroage/posix: do not depend on dentry->d_type

    modified files:
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/src/tcp-server.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/storage/posix/src/posix.c


2008-01-24 09:11:42 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-640

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-640

    Bug-2:
    	description: segfault in chmod, chown of unify children.
    	configuration: same as that of Bug-1.
    	cause: Unify used to STACK_UNWIND even before the fop is sent to its children. But, the inode ptr held in loc structers was not inode_refed, causing it to be freed in fuse.
    	fix: Unwind at the end of the call.
    Keywords: 
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify.c


2008-01-21 13:44:00 GMT	Vikas Gorur <vikas@80x25.org>	patch-639

    Summary:
      added some defensive programming for posix locks
    Revision:
      glusterfs--mainline--2.5--patch-639

    There are two versions of constants, F_*LK and F_*LK64. On 32-bit
    systems they are equal, on 64-bit systems they are not. Or something.
    The whole thing is a mess. To deal with it, we have two defensive pieces
    of code:
    
    client-protocol.c:
    server-protocol.c:
    a) Instead of blindly passing the values across the network, we
       convert them to GF_LK_* in client-protocol.c. 
       E.g., F_GETLK/F_GETLK64 --> GF_LK_GETLK
       We convert them back in server-protocol.c
    
    posix-locks.c:
    b) In case a F_GETLK64 sneaks through to posix-locks, we handle it
       there too.
    
    glusterfs.h:
       Added a new enum for GF_LK_*.
    
    This fixes Samba re-export issue.

    modified files:
     doc/user-guide/user-guide.pdf doc/user-guide/user-guide.texi
     libglusterfs/src/glusterfs.h
     xlators/features/posix-locks/src/posix-locks.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2008-01-21 11:19:50 GMT	Vikas Gorur <vikas@80x25.org>	patch-638

    Summary:
      reversed previous fix
    Revision:
      glusterfs--mainline--2.5--patch-638

    
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2008-01-19 12:23:54 GMT	Vikas Gorur <vikas@80x25.org>	patch-637

    Summary:
      handle F_*64 in pl_lk
    Revision:
      glusterfs--mainline--2.5--patch-637

    Samba re-exporting a GlusterFS mount encounters locking problems. They
    seem to be due to it using F_GETLK64, etc. This patch treats F_GETLK64
    as F_GETLK.
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2008-01-14 08:17:33 GMT	Amar Tumballi <amar@80x25.org>	patch-636

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-636

    * Corrected unify's stat return scheme:
      - Reviews from LI Daobing <lidaobing@gmail> is considered. 
        [ From the mail "unify's return 'struct stat' scheme" in Mailing-list]
    

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2008-01-14 07:07:29 GMT	Amar Tumballi <amar@80x25.org>	patch-635

    Summary:
      Bug fix in unify-self-heal
    Revision:
      glusterfs--mainline--2.5--patch-635

    * Bug Description: Segfault in setdents() when used unify/afr combination during self-healing process.
      Cause: The 'entry' variable was NULL, and was de-referenced without check.
      Fix: Not sending setdents call if there is nothing to fix. (ie, if entry is NULL)
    

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c


2008-01-07 20:03:50 GMT	Anand V. Avati <avati@80x25.org>	patch-634

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-634

    stripe: support pattern matched block sizes, but not mixing with non-striped files
    glusterfs.spec.in: fixes for including new path of glusterfs-booster.so

    modified files:
     glusterfs.spec.in xlators/cluster/stripe/src/stripe.c


2008-01-06 02:59:58 GMT	Anand V. Avati <avati@80x25.org>	patch-633

    Summary:
      typo in storage/posix
    Revision:
      glusterfs--mainline--2.5--patch-633


    modified files:
     xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2008-01-05 06:54:37 GMT	Anand V. Avati <avati@80x25.org>	patch-632

    Summary:
      booster ldpreload library directory changed to $(libdir)/glusterfs
    Revision:
      glusterfs--mainline--2.5--patch-632


    modified files:
     xlators/performance/booster/src/Makefile.am


2008-01-05 06:47:26 GMT	Anand V. Avati <avati@80x25.org>	patch-631

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-631

    reset read-ahead aggressiveness on writev()
    
    support page-aligned reads on o_direct files in storage/posix

    modified files:
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/storage/posix/src/posix.c


2008-01-04 04:10:03 GMT	Amar Tumballi <amar@80x25.org>	patch-630

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-630

    
    * Added another argument 'flag' to getdents() fop.
    
    * Unify self-heal updated. 
      - No permission checks between namespace and storage nodes.
      - No sorting/uniq operation @ client. Unification @ namespace node.
      - All entries are written to namespace first, then only directories from NS is read, and written to all the storage nodes.

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/glusterfs.h
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2008-01-02 08:57:04 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-629

    Summary:
      Noted that stat-prefetch is disabled in translator-option.txt
    Revision:
      glusterfs--mainline--2.5--patch-629


    modified files:
     doc/translator-option.txt


2007-12-27 14:20:34 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-628

    Summary:
      undoing patch-623 since it does not fix the issue
    Revision:
      glusterfs--mainline--2.5--patch-628


    modified files:
     glusterfsd/src/glusterfsd.c
     xlators/protocol/client/src/client-protocol.c


2007-12-27 12:23:24 GMT	Amar Tumballi <amar@80x25.org>	patch-627

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-627

    * Now, cluster/stripe xlator doesn't support any pattern matching. It only takes block-size as option. 
      From now on, stripe will stripe all the files which gets created by it. Pattern based striping should be done through 'switch' scheduler.

    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-12-27 11:06:45 GMT	Amar Tumballi <amar@80x25.org>	patch-626

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-626

    * typo fix in log msgs of random and nufa schedulers.
    
    * a fix in unify->init(), where there was a bug in calling the initialization of the namespace translator. Now, a flag (ns_xl->ready) is checked before its initialization.

    modified files:
     scheduler/nufa/src/nufa.c scheduler/random/src/random.c
     xlators/cluster/unify/src/unify.c


2007-12-26 10:32:57 GMT	Amar Tumballi <amar@80x25.org>	patch-625

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-625

    
    * xlators/performance/booster/src/*.c: Updated code to work with ib-verbs transport.

    modified files:
     xlators/performance/booster/src/booster.c
     xlators/performance/booster/src/bridge.c
     xlators/performance/booster/src/entry.c


2007-12-20 19:53:47 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-624

    Summary:
      Summary: migrations, name change from readdir->getdents writedir->setdents getdents->readdir
    Revision:
      glusterfs--mainline--2.5--patch-624


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/glusterfs.h
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-12-20 15:03:00 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-623

    Summary:
      
	bug: glusterfs segfault
	configuration: client->read-ahead->write-behind
		       posix->server
	steps to reproduce: kill glusterfsd when some write requests are still pending
	cause: close call is not sent to server due to client_protocol_cleanup does dict_del (fd->ctx, this->name) before forced unwinding for frames causing close to complete even though write requests are pending
	fix: cleanup saved_fds after forced unwinding of saved_frames
    Revision:
      glusterfs--mainline--2.5--patch-623


    modified files:
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/protocol/client/src/client-protocol.c


2007-12-19 13:51:51 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-622

    Summary:
      Added checks for fuse_loc_fill returning NULL inode instead of a valid inode (eg., in fops like fuse_open, fuse_chown etc.,)
    Revision:
      glusterfs--mainline--2.5--patch-622


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-12-19 02:14:53 GMT	Anand V. Avati <avati@80x25.org>	patch-621

    Summary:
      fix in booster
    Revision:
      glusterfs--mainline--2.5--patch-621


    modified files:
     xlators/performance/booster/src/bridge.c


2007-12-19 02:08:02 GMT	Anand V. Avati <avati@80x25.org>	patch-620

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-620

    * protocol/client: handle cases of not having a parent xlator
    * write-behind: make fops non static to get listed in mini bt in the logs
    * booster: cond waiters after recv/notify for ib-verbs

    modified files:
     xlators/performance/booster/src/booster.h
     xlators/performance/booster/src/bridge.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-12-18 19:13:59 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-619

    Summary:
      glusterfs exits gracefully when 'type' is not specified, instead of segfaulting.
    Revision:
      glusterfs--mainline--2.5--patch-619

    
    
    * section_end() returns -1 on finding that 'type' is not specified for a xlator.
    * grammer definition checks for return value from section_end() and aborts with YYABORT, if return value is -1.
    * YYABORT is a yacc macro to abort parsing with yyparse() return 1.

    modified files:
     libglusterfs/src/spec.y


2007-12-18 12:19:10 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-618

    Summary:
      Fixed a bug in spec file parser
    Revision:
      glusterfs--mainline--2.5--patch-618

    
    * Earlier versions of glusterfs used to segfault if 'type' was not specified for a translator.
    * Now glusterfs exits with error 'translator tree cut' when 'type' is not specified for a translator.
    

    modified files:
     libglusterfs/src/spec.y
     xlators/protocol/client/src/client-protocol.c


2007-12-18 11:42:33 GMT	Amar Tumballi <amar@80x25.org>	patch-617

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-617

    * glusterfsd: break even if one volume initialization fails.
    
    * client-protocol: fixed a issue with client_checksum(), where it used to segfault when inode was NULL
    
    * unify: send close() to NS in the close_cbk() of child node. This fixes the problem of inode getting reused in fuse layer before close.
    
    * stripe: send close() to first node in the call back of close sent to other nodes. Also fixed the issue of returning wrong op_errno in case of ENOTCONN
    

    modified files:
     glusterfsd/src/glusterfsd.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-12-16 21:20:06 GMT	Anand V. Avati <avati@80x25.org>	patch-616

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-616

    handle ESTALE on "/" correctly
    fix segfault in protocol/server

    modified files:
     xlators/performance/read-ahead/src/page.c
     xlators/protocol/server/src/server-protocol.c


2007-12-14 19:09:17 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-615

    Summary:
      Bug fix, when we recompare directory versions after locking we should have initialised local->op_ret = -1 before calling re-lookup.
    Revision:
      glusterfs--mainline--2.5--patch-615


    modified files:
     doc/qa/qa-high-avail-server.spec xlators/cluster/afr/src/afr.c


2007-12-13 14:04:41 GMT	Anand V. Avati <avati@80x25.org>	patch-614

    Summary:
      fix in server_getxattr leak fix
    Revision:
      glusterfs--mainline--2.5--patch-614

    
    

    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-12-13 12:12:01 GMT	Amar Tumballi <amar@80x25.org>	patch-613

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-613

    
    * server_protocol: leak fixes in mknod(), getxattr() and symlink()
    * client_protocol: cleanup in init(). removed code to check inode-lru-limit option.
    
    * scheduler/{rr,nufa}: removed strcmp() as it was redundant. should increase the create() rate.
    
    * storage/posix: added missing NULL in STACK_UNWIND() in case of failure in getdents()

    modified files:
     scheduler/nufa/src/nufa.c scheduler/rr/src/rr.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-12-13 09:04:32 GMT	Anand V. Avati <avati@80x25.org>	patch-612

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-612

     support for accepting -n via fstab (glusterfs client), thanks to Matthias Saou
     support for direct io mode by Michael Finchman
     split readdir call into chunked getdents call
     

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/utils/mount.glusterfs.in
     libglusterfs/src/call-stub.c libglusterfs/src/call-stub.h
     libglusterfs/src/defaults.c libglusterfs/src/defaults.h
     libglusterfs/src/glusterfs.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2007-12-13 08:50:27 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-611

    Summary:
      AFR bug fix : unlock namespace if versions dont actually differ when we check it after locking the namespace.
    Revision:
      glusterfs--mainline--2.5--patch-611


    modified files:
     xlators/cluster/afr/src/afr.c


2007-12-12 13:37:46 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-610

    Summary:
      following operations work serially instead of parallel-calls : mknod, mkdir, create, link, symlink, lk
    Revision:
      glusterfs--mainline--2.5--patch-610


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-12-12 09:23:30 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-609

    Summary:
      Added --disable-epoll option to configure
    Revision:
      glusterfs--mainline--2.5--patch-609


    modified files:
     configure.ac


2007-12-12 08:02:39 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-608

    Summary:
      backporting python bindings
    Revision:
      glusterfs--mainline--2.5--patch-608


    new files:
     xlators/bindings/.arch-ids/=id
     xlators/bindings/.arch-ids/Makefile.am.id
     xlators/bindings/Makefile.am
     xlators/bindings/python/.arch-ids/=id
     xlators/bindings/python/.arch-ids/Makefile.am.id
     xlators/bindings/python/Makefile.am
     xlators/bindings/python/src/.arch-ids/=id
     xlators/bindings/python/src/.arch-ids/Makefile.am.id
     xlators/bindings/python/src/.arch-ids/gluster.py.id
     xlators/bindings/python/src/.arch-ids/glusterstack.py.id
     xlators/bindings/python/src/.arch-ids/glustertypes.py.id
     xlators/bindings/python/src/.arch-ids/python.c.id
     xlators/bindings/python/src/.arch-ids/testxlator.py.id
     xlators/bindings/python/src/Makefile.am
     xlators/bindings/python/src/gluster.py
     xlators/bindings/python/src/glusterstack.py
     xlators/bindings/python/src/glustertypes.py
     xlators/bindings/python/src/python.c
     xlators/bindings/python/src/testxlator.py

    modified files:
     configure.ac xlators/Makefile.am

    new directories:
     xlators/bindings xlators/bindings/.arch-ids
     xlators/bindings/python xlators/bindings/python/.arch-ids
     xlators/bindings/python/src
     xlators/bindings/python/src/.arch-ids


2007-12-11 11:52:08 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-607

    Summary:
      Rename afr_fop_incver to afr_incver; afr_incver to afr_incver_internal. Lock namespace when incrementing directory versions, also lock namespace in lookup when we access version info and compare them.
    Revision:
      glusterfs--mainline--2.5--patch-607


    modified files:
     xlators/cluster/afr/src/afr.c


2007-12-11 08:54:09 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-606

    Summary:
      Fixed segfault in auth, which used to happen when an authentication module (a .so) is not found or dlopen on that module is failed.
    Revision:
      glusterfs--mainline--2.5--patch-606


    modified files:
     libglusterfs/src/authenticate.c
     xlators/protocol/server/src/server-protocol.c


2007-12-10 11:35:05 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-605

    Summary:
      
	* bug: segfault on systems with epoll.h but no sys_epoll_* system calls implemented
	* fix: check for NULL epoll_ctx in sys_epoll_iteration and return ENOSYS accordingly.
    Revision:
      glusterfs--mainline--2.5--patch-605


    modified files:
     libglusterfs/src/epoll.c


2007-12-07 20:02:40 GMT	Anand V. Avati <avati@80x25.org>	patch-604

    Summary:
      fixed typo in protocol/server
    Revision:
      glusterfs--mainline--2.5--patch-604


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-12-07 12:01:08 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-603

    Summary:
      version check between client and server
    Revision:
      glusterfs--mainline--2.5--patch-603


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-12-07 11:49:27 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-602

    Summary:
      logrotate
    Revision:
      glusterfs--mainline--2.5--patch-602


    modified files:
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/logging.c libglusterfs/src/logging.h


2007-12-07 06:48:00 GMT	Anand V. Avati <avati@80x25.org>	patch-601

    Summary:
      removed extra semicolons - reported by LI Daobing <lidaobing@gmail.com>
    Revision:
      glusterfs--mainline--2.5--patch-601


    modified files:
     libglusterfs/src/logging.h


2007-12-06 12:49:24 GMT	Amar Tumballi <amar@80x25.org>	patch-600

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-600

    * fix for the [bug #21736] reported @ BTS, savannah/projects/gluster.

    modified files:
     xlators/cluster/afr/src/afr.c


2007-12-06 06:26:08 GMT	Anand V. Avati <avati@80x25.org>	patch-599

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-599

    Typo reported by LI Daobing <lidaobing@gmail.com> in compatibility
    
    Compatibility for DOS mode for spec files (CR-LF ending)

    modified files:
     libglusterfs/src/epoll.c libglusterfs/src/spec.l


2007-12-05 08:48:55 GMT	Anand V. Avati <avati@80x25.org>	patch-598

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-598


    modified files:
     transport/ib-verbs/ib-verbs.c
     xlators/cluster/unify/src/unify.c


2007-12-05 07:50:57 GMT	Anand V. Avati <avati@80x25.org>	patch-597

    Summary:
      fixes in fuse-bridge and unify to fix the ESTALE error
    Revision:
      glusterfs--mainline--2.5--patch-597


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/cluster/unify/src/unify.c


2007-12-05 03:49:04 GMT	Anand V. Avati <avati@80x25.org>	patch-596

    Summary:
      ib-verbs - propagate notification of socket upto protocol
    Revision:
      glusterfs--mainline--2.5--patch-596


    modified files:
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c


2007-12-05 03:03:50 GMT	Anand V. Avati <avati@80x25.org>	patch-595

    Summary:
      fix for spurious ESTALE errors
    Revision:
      glusterfs--mainline--2.5--patch-595


    modified files:
     xlators/cluster/unify/src/unify.c


2007-12-03 22:29:15 GMT	Anand V. Avati <avati@80x25.org>	patch-594

    Summary:
      locks around dict_get/dict_set
    Revision:
      glusterfs--mainline--2.5--patch-594


    modified files:
     libglusterfs/src/dict.c


2007-12-03 20:59:26 GMT	Anand V. Avati <avati@80x25.org>	patch-593

    Summary:
      mark fd's context dict 'locked'
    Revision:
      glusterfs--mainline--2.5--patch-593


    modified files:
     libglusterfs/src/dict.c libglusterfs/src/xlator.c


2007-12-02 21:07:30 GMT	Anand V. Avati <avati@80x25.org>	patch-592

    Summary:
      fuse_statfs_cbk - set ->f_frsize to ->f_bsize and scale ->f_blocks ->f_bavail and ->f_bfree to provide compatibility for old coreutils agains filesystem which report differing ->f_frsize and ->f_bsize (e.g ZFS on solaris)
    Revision:
      glusterfs--mainline--2.5--patch-592


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-11-30 06:47:55 GMT	Amar Tumballi <amar@80x25.org>	patch-591

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-591

    * solaris warning and build fixes.

    modified files:
     auth/ip/src/Makefile.am auth/login/src/Makefile.am
     configure.ac glusterfsd/src/Makefile.am
     libglusterfs/src/Makefile.am libglusterfs/src/authenticate.h
     xlators/cluster/afr/src/Makefile.am
     xlators/debug/trace/src/Makefile.am
     xlators/debug/trace/src/trace.c
     xlators/performance/booster/src/Makefile.am
     xlators/performance/io-cache/src/Makefile.am
     xlators/protocol/client/src/Makefile.am
     xlators/protocol/server/src/Makefile.am
     xlators/storage/posix/src/posix.c


2007-11-30 00:47:49 GMT	Anand V. Avati <avati@80x25.org>	patch-590

    Summary:
      conditionally define INADDR_NONE
    Revision:
      glusterfs--mainline--2.5--patch-590


    modified files:
     libglusterfs/src/common-utils.c


2007-11-29 23:05:13 GMT	Anand V. Avati <avati@80x25.org>	patch-589

    Summary:
      added log when frame size exceeds transport limit
    Revision:
      glusterfs--mainline--2.5--patch-589


    modified files:
     libglusterfs/src/protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/storage/posix/src/posix.c


2007-11-29 20:48:17 GMT	Anand V. Avati <avati@80x25.org>	patch-588

    Summary:
      added log messages in protocol/server to report fd table misses
    Revision:
      glusterfs--mainline--2.5--patch-588


    modified files:
     libglusterfs/src/protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-11-29 12:43:29 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-587

    Summary:
      Added authentication related and max_block_size options to translator-option.txt
    Revision:
      glusterfs--mainline--2.5--patch-587


    modified files:
     doc/translator-option.txt


2007-11-29 12:22:39 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-586

    Summary:
      removed debug logs
    Revision:
      glusterfs--mainline--2.5--patch-586


    modified files:
     libglusterfs/src/protocol.c


2007-11-29 12:08:39 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-585

    Summary:
      backported protocol changes to add upperlimit to the block size recieved by client/server
    Revision:
      glusterfs--mainline--2.5--patch-585


    modified files:
     libglusterfs/src/protocol.c libglusterfs/src/protocol.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-11-29 06:57:12 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-584

    Summary:
      Fix to group permissions bug. Commented out setfsgid.
    Revision:
      glusterfs--mainline--2.5--patch-584


    modified files:
     xlators/storage/posix/src/posix.c


2007-11-28 21:25:32 GMT	Anand V. Avati <avati@80x25.org>	patch-583

    Summary:
      unify.c - change lookup to check for "/" instead of "" after the inode_path() fix
    Revision:
      glusterfs--mainline--2.5--patch-583


    modified files:
     xlators/cluster/unify/src/unify.c


2007-11-28 19:22:33 GMT	Anand V. Avati <avati@80x25.org>	patch-582

    Summary:
      fuse-bridge - re-use ctime as generation number
    Revision:
      glusterfs--mainline--2.5--patch-582


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-11-28 19:20:04 GMT	Anand V. Avati <avati@80x25.org>	patch-581

    Summary:
      protocol/server cleanup - fd_destroy in nop_cbk
    Revision:
      glusterfs--mainline--2.5--patch-581


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-11-27 22:53:53 GMT	Anand V. Avati <avati@80x25.org>	patch-580

    Summary:
      fix in epoll failover to poll
    Revision:
      glusterfs--mainline--2.5--patch-580


    modified files:
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/epoll.c libglusterfs/src/glusterfs.h
     libglusterfs/src/transport.c
     xlators/performance/booster/src/bridge.c
     xlators/protocol/server/src/server-protocol.c


2007-11-27 14:14:03 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-579

    Summary:
      
	* switching b/w poll and epoll had problems on systems having epoll.h but sys_calls not implemented. As a result glusterfs had unpredictable behaviour due to race conditions. Fixed the same.
	* Added cond_wait to sys_poll_iteration to block till atleast one fd is registered for polling before continuing to poll. 
    Revision:
      glusterfs--mainline--2.5--patch-579


    modified files:
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/epoll.c libglusterfs/src/glusterfs.h
     libglusterfs/src/poll.c libglusterfs/src/transport.c
     libglusterfs/src/transport.h
     xlators/protocol/server/src/server-protocol.c


2007-11-26 19:01:44 GMT	Anand V. Avati <avati@80x25.org>	patch-578

    Summary:
      server_protocol_cleanup()
    Revision:
      glusterfs--mainline--2.5--patch-578

    copy_frame per close/closedir in cleanup and destroy each frame in callback

    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-11-26 11:32:43 GMT	Amar Tumballi <amar@80x25.org>	patch-577

    Summary:
      solaris fixes
    Revision:
      glusterfs--mainline--2.5--patch-577

    * compat.c: made few changes to log msgs.
    * posix.c: fixes to remove 'd_type' variables in posix_checksum(). instead calling stat().
    
    * unify: added 'need_break' in all the loops which was based on 'mapping list' of inode context.
    
    * fixed a bug in server-protocol.c, which used to segfault when a client disconnects while its doing some file IO.
    

    modified files:
     configure.ac libglusterfs/src/compat.c
     libglusterfs/src/compat.h libglusterfs/src/fd.c
     transport/Makefile.am xlators/cluster/unify/src/unify.c
     xlators/performance/booster/src/Makefile.am
     xlators/performance/booster/src/entry.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/Makefile.am
     xlators/storage/posix/src/posix.c


2007-11-22 23:22:13 GMT	Anand V. Avati <avati@80x25.org>	patch-576

    Summary:
      fix to avoid busyloop in fuse-bridge.c:fuse_thread_proc()
    Revision:
      glusterfs--mainline--2.5--patch-576


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-11-22 08:44:21 GMT	Amar Tumballi <amar@80x25.org>	patch-575

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-575

    * a fix in unify_lookup, to break the loop based on list.
    
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-11-22 01:47:17 GMT	Anand V. Avati <avati@80x25.org>	patch-574

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-574

    unify - unwind with ESTALE to force fresh lookup on files with  non-2 count in context

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/cluster/unify/src/unify.c


2007-11-21 00:07:45 GMT	Anand V. Avati <avati@80x25.org>	patch-573

    Summary:
      copy inode pointers across src and dst for linking in fuse
    Revision:
      glusterfs--mainline--2.5--patch-573


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-11-20 23:46:07 GMT	Anand V. Avati <avati@80x25.org>	patch-572

    Summary:
      log message fix
    Revision:
      glusterfs--mainline--2.5--patch-572


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-11-20 23:44:03 GMT	Anand V. Avati <avati@80x25.org>	patch-571

    Summary:
      swap loc and loc2 for dst and src in link()
    Revision:
      glusterfs--mainline--2.5--patch-571


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-11-20 23:24:18 GMT	Anand V. Avati <avati@80x25.org>	patch-570

    Summary:
      re-lookup to happen only for lookup calls in entry_cbk
    Revision:
      glusterfs--mainline--2.5--patch-570


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-11-20 22:21:30 GMT	Anand V. Avati <avati@80x25.org>	patch-569

    Summary:
      fuse_entry_cbk - update mode in cleanup check to avoid infinite loop
    Revision:
      glusterfs--mainline--2.5--patch-569


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-11-20 21:48:27 GMT	Anand V. Avati <avati@80x25.org>	patch-568

    Summary:
      multiple fixes
    Revision:
      glusterfs--mainline--2.5--patch-568

    * glusterfs-fuse more rules flush stale dentries in fuse_entry_cbk
    
    * glusterfs-fuse - run fuse request loop in a seperate thread to improve read performance
    
    * protocol - disable buffer reuse
    
    * transport/epoll - block on cond till first fd is registered instead of breaking out 
    
    * protocol/client - lk_cbk - fix wrongly returned ENOTCONN
    
    * protocol/server - bring back reply thread

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/epoll.c libglusterfs/src/inode.c
     libglusterfs/src/xlator.c
     xlators/performance/booster/src/booster.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-11-20 11:12:32 GMT	Amar Tumballi <amar@80x25.org>	patch-567

    Summary:
      rr scheduler seeding
    Revision:
      glusterfs--mainline--2.5--patch-567

    * Feature: While using 'rr' scheduler in unify, it used to start creating files from the first child only. Now, each client starts creating files from different child nodes.
    
    * Changed AFR_VERSION to GLUSTERFS_VERSION, and similarly AFR_CREATETIME to GLUSTERFS_CREATETIME
    

    modified files:
     libglusterfs/src/glusterfs.h libglusterfs/src/protocol.c
     scheduler/alu/src/alu.c scheduler/random/src/random.c
     scheduler/rr/src/rr.c scheduler/rr/src/rr.h
     scheduler/switch/src/switch.c xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-11-17 04:03:49 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-566

    Summary:
      changing option read-node to option read-subvolume in afr.
    Revision:
      glusterfs--mainline--2.5--patch-566


    modified files:
     doc/translator-option.txt xlators/cluster/afr/src/afr.c


2007-11-17 00:10:49 GMT	Anand V. Avati <avati@80x25.org>	patch-565

    Summary:
      ib-verbs - fetch back post on error
    Revision:
      glusterfs--mainline--2.5--patch-565


    modified files:
     glusterfs-fuse/src/glusterfs.c transport/ib-verbs/ib-verbs.c
     xlators/performance/booster/src/bridge.c


2007-11-17 00:03:51 GMT	Anand V. Avati <avati@80x25.org>	patch-564

    Summary:
      booster/ib-verbs - booster pwritev in single transport->writev()
    Revision:
      glusterfs--mainline--2.5--patch-564


    modified files:
     glusterfs-fuse/src/glusterfs.c transport/ib-verbs/ib-verbs.c
     xlators/performance/booster/src/bridge.c
     xlators/protocol/client/src/client-protocol.c


2007-11-16 11:31:27 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-563

    Summary:
      read-node should be used instead of read-schedule, "option read-node */<subvol>" can be defined. * specifies that all the child nodes should be used for scheduling.
    Revision:
      glusterfs--mainline--2.5--patch-563


    modified files:
     doc/translator-option.txt xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h


2007-11-14 12:43:26 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-562

    Summary:
      "option read-schedule on/off" is supported now. readv() operations are scheduled amongst the children of afr. if a file is re-read, it will be scheduled to the same node from where it was previously read from (to take advantage of the kernel caching on the servers)
    Revision:
      glusterfs--mainline--2.5--patch-562


    modified files:
     doc/translator-option.txt xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h


2007-11-14 11:47:23 GMT	Amar Tumballi <amar@80x25.org>	patch-561

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-561

    * A temporary fix in xlators/protocol/server code to remove reply thread, which was causing memory leak.
    
    

    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-11-14 05:08:33 GMT	Anand V. Avati <avati@80x25.org>	patch-560

    Summary:
      fix in server_create_cbk
    Revision:
      glusterfs--mainline--2.5--patch-560


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-11-13 14:05:00 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-559

    Summary:
      Backported fdtable maintanence from 2.6
    Revision:
      glusterfs--mainline--2.5--patch-559


    new files:
     libglusterfs/src/.arch-ids/fd.c.id
     libglusterfs/src/.arch-ids/fd.h.id libglusterfs/src/fd.c
     libglusterfs/src/fd.h

    modified files:
     libglusterfs/src/Makefile.am libglusterfs/src/xlator.h
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-11-13 11:43:01 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-558

    Summary:
      missed out authenticate.[ch] in previous commmit
    Revision:
      glusterfs--mainline--2.5--patch-558


    new files:
     libglusterfs/src/.arch-ids/authenticate.c.id
     libglusterfs/src/.arch-ids/authenticate.h.id
     libglusterfs/src/authenticate.c
     libglusterfs/src/authenticate.h


2007-11-13 11:33:57 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-557

    Summary:
      Added Authentication module
    Revision:
      glusterfs--mainline--2.5--patch-557


    modified files:
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-11-13 11:11:38 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-556

    Summary:
      Added Authentication module
    Revision:
      glusterfs--mainline--2.5--patch-556


    new files:
     auth/.arch-ids/=id auth/.arch-ids/Makefile.am.id
     auth/Makefile.am auth/ip/.arch-ids/=id
     auth/ip/.arch-ids/Makefile.am.id auth/ip/Makefile.am
     auth/ip/src/.arch-ids/=id auth/ip/src/.arch-ids/Makefile.am.id
     auth/ip/src/.arch-ids/ip.c.id auth/ip/src/Makefile.am
     auth/ip/src/ip.c auth/login/.arch-ids/=id
     auth/login/.arch-ids/Makefile.am.id auth/login/Makefile.am
     auth/login/src/.arch-ids/=id
     auth/login/src/.arch-ids/Makefile.am.id
     auth/login/src/.arch-ids/login.c.id auth/login/src/Makefile.am
     auth/login/src/login.c

    modified files:
     Makefile.am configure.ac libglusterfs/src/Makefile.am
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h

    new directories:
     auth auth/.arch-ids auth/ip auth/ip/.arch-ids auth/ip/src
     auth/ip/src/.arch-ids auth/login auth/login/.arch-ids
     auth/login/src auth/login/src/.arch-ids


2007-11-13 07:14:07 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-555

    Summary:
      modified parser to accept double quotes (") (for eg., option directory "/home/export\"quoted)
    Revision:
      glusterfs--mainline--2.5--patch-555


    modified files:
     libglusterfs/src/spec.l libglusterfs/src/spec.y


2007-11-13 04:56:42 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-554

    Summary:
      create pidfile iff -p option is given
    Revision:
      glusterfs--mainline--2.5--patch-554


    modified files:
     doc/examples/posix-locks.vol glusterfsd/src/glusterfsd.c
     xlators/protocol/client/src/client-protocol.c


2007-11-12 00:57:55 GMT	Anand V. Avati <avati@80x25.org>	patch-553

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-553

    - trace backported from 2.6
    - cond wrappers around recv buffer in ib-verbs
    - glusterfs.spec.in minor changes

    modified files:
     glusterfs.spec.in transport/ib-verbs/ib-verbs.c
     transport/ib-verbs/ib-verbs.h xlators/debug/trace/src/trace.c


2007-11-10 14:57:31 GMT	Amar Tumballi <amar@80x25.org>	patch-552

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-552

    * fixing glusterfs.spec.in to build RPMs. Patch from Harshavardhana R <harsha@zresearch.com>

    modified files:
     glusterfs.spec.in


2007-11-08 15:04:34 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-551

    Summary:
      Need to do null check on entry->next even if op_ret is 0. Which can happen as detailed by bug 21541 http://savannah.nongnu.org/bugs/?21541
    Revision:
      glusterfs--mainline--2.5--patch-551


    modified files:
     xlators/cluster/afr/src/afr.c


2007-11-08 08:04:59 GMT	Vikas Gorur <vikas@80x25.org>	patch-550

    Summary:
      `backported' user guide from 2.6 branch
    Revision:
      glusterfs--mainline--2.5--patch-550

    
    

    new files:
     doc/user-guide/.arch-ids/advanced-stripe.odg.id
     doc/user-guide/.arch-ids/advanced-stripe.pdf.id
     doc/user-guide/.arch-ids/fdl.texi.id
     doc/user-guide/.arch-ids/fuse.odg.id
     doc/user-guide/.arch-ids/fuse.pdf.id
     doc/user-guide/.arch-ids/ha.odg.id
     doc/user-guide/.arch-ids/ha.pdf.id
     doc/user-guide/.arch-ids/stripe.odg.id
     doc/user-guide/.arch-ids/stripe.pdf.id
     doc/user-guide/.arch-ids/unify.odg.id
     doc/user-guide/.arch-ids/unify.pdf.id
     doc/user-guide/.arch-ids/xlator.odg.id
     doc/user-guide/.arch-ids/xlator.pdf.id
     doc/user-guide/advanced-stripe.odg
     doc/user-guide/advanced-stripe.pdf doc/user-guide/fdl.texi
     doc/user-guide/fuse.odg doc/user-guide/fuse.pdf
     doc/user-guide/ha.odg doc/user-guide/ha.pdf
     doc/user-guide/stripe.odg doc/user-guide/stripe.pdf
     doc/user-guide/unify.odg doc/user-guide/unify.pdf
     doc/user-guide/xlator.odg doc/user-guide/xlator.pdf

    modified files:
     doc/user-guide/user-guide.info doc/user-guide/user-guide.pdf
     doc/user-guide/user-guide.texi


2007-11-08 04:56:38 GMT	Anand V. Avati <avati@80x25.org>	patch-549

    Summary:
      booster direct to server - fixes (use data_from_dynstr instead of data_from_ptr)
    Revision:
      glusterfs--mainline--2.5--patch-549


    modified files:
     xlators/performance/booster/src/booster.c


2007-11-08 04:22:50 GMT	Anand V. Avati <avati@80x25.org>	patch-548

    Summary:
      booster support to be loadable on server
    Revision:
      glusterfs--mainline--2.5--patch-548


    modified files:
     xlators/performance/booster/src/booster.c


2007-11-07 15:08:10 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-547

    Summary:
      notify should not propogate notify() from NS to unify's parents. And a NULL check for trav in glusterfsd.
    Revision:
      glusterfs--mainline--2.5--patch-547


    modified files:
     glusterfsd/src/glusterfsd.c xlators/cluster/unify/src/unify.c


2007-11-05 11:57:32 GMT	Amar Tumballi <amar@80x25.org>	patch-546

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-546

    * added 'incver' and 'rmelem' fops to unify.
    
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-11-04 06:29:22 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-545

    Summary:
      in posix_utimens() if lutimes() fails, try utimes()
    Revision:
      glusterfs--mainline--2.5--patch-545


    modified files:
     xlators/storage/posix/src/posix.c


2007-11-03 16:33:25 GMT	Amar Tumballi <amar@80x25.org>	patch-544

    Summary:
      bug fixes
    Revision:
      glusterfs--mainline--2.5--patch-544

    * corrected checksum() to return directory and file checksum seperately. 
    
    * bug fix in gf_unify_self_heal(), where inode was refered after STACK_WIND, which was free'd and wrong values were used instead.
    
    * a fix in libglusterfs/src/inode.c to return "/" if its root inode.
    
    * few fixes in solaris part of code based on reviews from Harshavardhana R <harsha@zresearch.com>
    
    

    modified files:
     doc/qa/qa-client.spec doc/qa/qa-high-avail-server.spec
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/compat.c
     libglusterfs/src/defaults.c libglusterfs/src/glusterfs.h
     libglusterfs/src/inode.c libglusterfs/src/stack.h
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-11-02 13:00:44 GMT	Amar Tumballi <amar@80x25.org>	patch-543

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-543

    * fix in unify_lookup.
      if when a revalidate is sent, generation numbers differ, we mark the inode STALE and send a fresh lookup to get the fresh mapping list. Hence the hack to return -1 if a file is present in only on namespace is gone.
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-11-02 11:29:44 GMT	Amar Tumballi <amar@80x25.org>	patch-542

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-542

    * small fix in unify-self-heal.

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c


2007-11-02 10:33:16 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-541

    Summary:
      implemented afr_fchmod afr_fchown in afr. client protocol used GF_FOP_FCHMOD instead of GF_FOP_FCHOWN for client_fchown(). posix_utimens() used utimes instead of lutimes().
    Revision:
      glusterfs--mainline--2.5--patch-541


    modified files:
     doc/translator-option.txt xlators/cluster/afr/src/afr.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-11-02 06:46:20 GMT	Amar Tumballi <amar@80x25.org>	patch-540

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-540

    * added missing booster.h to the makefile.
    
    * changed log level of bailing out frame info from WARNING to ERROR.

    modified files:
     xlators/performance/booster/src/Makefile.am
     xlators/protocol/client/src/client-protocol.c


2007-11-01 19:12:49 GMT	Anand V. Avati <avati@80x25.org>	patch-539

    Summary:
      compilation fix, transport/unix backport, fix in fuse/unify
    Revision:
      glusterfs--mainline--2.5--patch-539

    fuse/unify - if revalidate fails, send fresh lookup

    new files:
     transport/unix/.arch-ids/=id
     transport/unix/.arch-ids/Makefile.am.id
     transport/unix/.arch-ids/unix.c.id
     transport/unix/.arch-ids/unix.h.id transport/unix/Makefile.am
     transport/unix/client/.arch-ids/=id
     transport/unix/client/.arch-ids/Makefile.am.id
     transport/unix/client/Makefile.am
     transport/unix/client/src/.arch-ids/=id
     transport/unix/client/src/.arch-ids/Makefile.am.id
     transport/unix/client/src/.arch-ids/unix-client.c.id
     transport/unix/client/src/Makefile.am
     transport/unix/client/src/unix-client.c
     transport/unix/server/.arch-ids/=id
     transport/unix/server/.arch-ids/Makefile.am.id
     transport/unix/server/Makefile.am
     transport/unix/server/src/.arch-ids/=id
     transport/unix/server/src/.arch-ids/Makefile.am.id
     transport/unix/server/src/.arch-ids/unix-server.c.id
     transport/unix/server/src/Makefile.am
     transport/unix/server/src/unix-server.c transport/unix/unix.c
     transport/unix/unix.h

    modified files:
     configure.ac glusterfs-fuse/src/fuse-bridge.c
     transport/Makefile.am xlators/cluster/unify/src/unify.c
     xlators/performance/booster/src/entry.c

    new directories:
     transport/unix transport/unix/.arch-ids transport/unix/client
     transport/unix/client/.arch-ids transport/unix/client/src
     transport/unix/client/src/.arch-ids transport/unix/server
     transport/unix/server/.arch-ids transport/unix/server/src
     transport/unix/server/src/.arch-ids


2007-10-31 16:32:21 GMT	Amar Tumballi <amar@80x25.org>	patch-538

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-538

    * had forgot to tla add the switch scheduler
    
    
    
    

    new files:
     scheduler/switch/.arch-ids/=id
     scheduler/switch/.arch-ids/Makefile.am.id
     scheduler/switch/Makefile.am
     scheduler/switch/src/.arch-ids/=id
     scheduler/switch/src/.arch-ids/Makefile.am.id
     scheduler/switch/src/.arch-ids/switch.c.id
     scheduler/switch/src/Makefile.am scheduler/switch/src/switch.c

    modified files:
     doc/translator-option.txt xlators/cluster/unify/src/unify.c

    new directories:
     scheduler/switch scheduler/switch/.arch-ids
     scheduler/switch/src scheduler/switch/src/.arch-ids


2007-10-31 16:20:25 GMT	Amar Tumballi <amar@80x25.org>	patch-537

    Summary:
      
	switch scheduler 
    Revision:
      glusterfs--mainline--2.5--patch-537

     * back ported switch scheduler from 2.6 branch.
    
    
    
    

    modified files:
     configure.ac doc/translator-option.txt
     libglusterfs/src/scheduler.h scheduler/Makefile.am
     scheduler/alu/src/alu.c scheduler/nufa/src/nufa.c
     scheduler/random/src/random.c scheduler/rr/src/rr.c


2007-10-31 15:54:20 GMT	Amar Tumballi <amar@80x25.org>	patch-536

    Summary:
      
 booster
    Revision:
      glusterfs--mainline--2.5--patch-536

    * booster backported from 2.6 branch to 2.5 branch.

    new files:
     xlators/performance/booster/.arch-ids/=id
     xlators/performance/booster/.arch-ids/Makefile.am.id
     xlators/performance/booster/Makefile.am
     xlators/performance/booster/src/.arch-ids/=id
     xlators/performance/booster/src/.arch-ids/Makefile.am.id
     xlators/performance/booster/src/.arch-ids/booster.c.id
     xlators/performance/booster/src/.arch-ids/booster.h.id
     xlators/performance/booster/src/.arch-ids/bridge.c.id
     xlators/performance/booster/src/.arch-ids/entry.c.id
     xlators/performance/booster/src/Makefile.am
     xlators/performance/booster/src/booster.c
     xlators/performance/booster/src/booster.h
     xlators/performance/booster/src/bridge.c
     xlators/performance/booster/src/entry.c

    modified files:
     configure.ac xlators/performance/Makefile.am

    new directories:
     xlators/performance/booster
     xlators/performance/booster/.arch-ids
     xlators/performance/booster/src
     xlators/performance/booster/src/.arch-ids


2007-10-31 15:42:35 GMT	Amar Tumballi <amar@80x25.org>	patch-535

    Summary:
      
	checksum FOP
    Revision:
      glusterfs--mainline--2.5--patch-535

    * added checksum() call for MOPS. This is added with regard to enhance the self-heal speed of unify.

    modified files:
     libglusterfs/src/defaults.c libglusterfs/src/defaults.h
     libglusterfs/src/glusterfs.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-10-30 14:19:35 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-534

    Summary:
      Changes not to allow "option replicate" in AFR. http://www.mail-archive.com/gluster-devel@nongnu.org/msg02201.html for more details. changes to xlator.c - top->notify() is not called if xlator init fails.
    Revision:
      glusterfs--mainline--2.5--patch-534


    modified files:
     libglusterfs/src/xlator.c xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h


2007-10-29 11:28:33 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-533

    Summary:
      Cosmetic changes to the afr code by bulde. Basic tests passed.
    Revision:
      glusterfs--mainline--2.5--patch-533


    modified files:
     xlators/cluster/afr/src/afr.c


2007-10-29 10:04:27 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-532

    Summary:
      Added signal handler for SIGFPE
    Revision:
      glusterfs--mainline--2.5--patch-532

    * Added gf_print_trace as signal handler for SIGFPE
    

    modified files:
     glusterfsd/src/glusterfsd.c


2007-10-26 08:46:31 GMT	Amar Tumballi <amar@80x25.org>	patch-531

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-531

    * small fix in fuse_create_cbk:
      - reverted back if (!fuse_inode->ctx) to 
        if (fuse_inode->ctx != inode->ctx)
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-10-25 20:57:24 GMT	Anand V. Avati <avati@80x25.org>	patch-530

    Summary:
      fuse-bridge logging enhancements, unify_create send close to NS when fail to create on DS
    Revision:
      glusterfs--mainline--2.5--patch-530


    modified files:
     configure.ac glusterfs-fuse/src/fuse-bridge.c
     libglusterfs/src/logging.h xlators/cluster/unify/src/unify.c


2007-10-25 09:40:59 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-529

    Summary:
      fuse-bridge bug fix
    Revision:
      glusterfs--mainline--2.5--patch-529

    * adding fd to inode->fd list was happening even if op_ret from open/create was -1. Now fd is added to inode->fd list only if op_ret >=0.
    
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-10-24 08:21:21 GMT	Amar Tumballi <amar@80x25.org>	patch-528

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-528

    * typo fixes in unify.
    
      - changed local->entry_count to local->index in unify_create_lookup_cbk()
      - changed list[index] == 1 to list[index+1] == 1 in unify_closedir ()
      - moved fd_destroy from sh_readdir_cbk () to sh_closedir_cbk() in unify_self_heal.c

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2007-10-23 07:48:36 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-527

    Summary:
      Bug fixes to client protocol and dictionary.
    Revision:
      glusterfs--mainline--2.5--patch-527

    * dict_set () used a static variable static_hashval, which caused dict_set() to insert dictionary members to wrong indexes in members array. Now the static variable is removed.
    
    * client_lookup_cbk() does dict_set() on inode->ctx for a lookup only if,
      - lookup is fresh.
              or
      - inode number (ino) of the entry has changed.
    
    * client_link_cbk() used to do dict_set() on inode->ctx. It was not necessary as the inode number (ino) is not changed in link() call.
    
    
    

    modified files:
     libglusterfs/src/dict.c
     xlators/protocol/client/src/client-protocol.c


2007-10-22 13:15:51 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-526

    Summary:
      Fix for a bug where a memory is referenced after it has been freed.
    Revision:
      glusterfs--mainline--2.5--patch-526

    Reference: mail from "Kamil Srot" Subj "Self Heal/Recovery Problem"

    modified files:
     xlators/cluster/afr/src/afr.c


2007-10-19 09:44:26 GMT	Amar Tumballi <amar@80x25.org>	patch-525

    Summary:
      
 GlusterFS server Solaris porting - _almost_ complete
    Revision:
      glusterfs--mainline--2.5--patch-525

    * removed extattr.h and moved its content to compat.h
    * added solaris_*xattr() functions in compat.c
    * added check in configure.ac to get AC_CONONICAL_HOST flag.
    
    * removed warning related to mtrace in glusterfs.c and glusterfsd.c

    removed files:
     libglusterfs/src/.arch-ids/extattr.h.id
     libglusterfs/src/extattr.h

    modified files:
     configure.ac glusterfs-fuse/src/glusterfs.c
     glusterfsd/src/Makefile.am glusterfsd/src/glusterfsd.c
     libglusterfs/src/Makefile.am libglusterfs/src/common-utils.h
     libglusterfs/src/compat.c libglusterfs/src/compat.h
     libglusterfs/src/logging.h xlators/storage/posix/src/posix.h


2007-10-18 11:21:14 GMT	Anand V. Avati <avati@80x25.org>	patch-524

    Summary:
      swap inode context only for fresh lookup in fuse_entry_cbk
    Revision:
      glusterfs--mainline--2.5--patch-524


    modified files:
     configure.ac glusterfs-fuse/src/fuse-bridge.c


2007-10-17 13:54:51 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-523

    Summary:
      making a check in afr_open if child_errno[] array has atleast one element which is 0.
    Revision:
      glusterfs--mainline--2.5--patch-523


    modified files:
     xlators/cluster/afr/src/afr.c


2007-10-16 16:43:38 GMT	Amar Tumballi <amar@80x25.org>	patch-522

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-522

    * unify:
      - enhanced notify() to behave as desired (ie, send CHILD_DOWN when all the child is down, and send CHILD_UP, when one of the child is up).
      - fixes in unify self heal, which caused corruption when used over posix, or with ib-verbs.

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2007-10-16 07:43:06 GMT	Amar Tumballi <amar@80x25.org>	patch-521

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-521

    * protocol/server: changed the log level of error msg in getspec().
    
    * cluster/unify: a fix in unify_lookup_cbk().
       	- bug: when any of the node goes down (storage node), 'ls' on top directory was giving ENOENT error.
    	- fix: check for ENOTCONN in cbk.

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/protocol/server/src/server-protocol.c


2007-10-16 07:15:34 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-520

    Summary:
      initialising ts[].tv_nsec to 0 before calling utimens() in afr selfheal code.
    Revision:
      glusterfs--mainline--2.5--patch-520


    modified files:
     xlators/cluster/afr/src/afr.c


2007-10-15 21:32:16 GMT	Anand V. Avati <avati@80x25.org>	patch-519

    Summary:
      afr - unwind when inode state is down for all subvolumes
    Revision:
      glusterfs--mainline--2.5--patch-519


    modified files:
     glusterfs-fuse/src/fuse-bridge.c xlators/cluster/afr/src/afr.c


2007-10-12 12:33:58 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-518

    Summary:
      removing "static" for functions so that the name appears in the backtrace log.
    Revision:
      glusterfs--mainline--2.5--patch-518


    modified files:
     xlators/cluster/afr/src/afr.c


2007-10-12 12:18:38 GMT	Anand V. Avati <avati@80x25.org>	patch-517

    Summary:
      frame pool from main() instead of global variable
    Revision:
      glusterfs--mainline--2.5--patch-517


    modified files:
     configure.ac glusterfs-fuse/src/fuse-bridge.c


2007-10-10 15:40:43 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-516

    Summary:
      
	bug description: file creation was failing with striping enabled.
	xlators configuration: stripe over unify
	cause: unify was propagating CHILD_UP event to stripe for _each_ of its _own children_ causing stripe recieving more CHILD_UP events than it should've recieved.
	Fix: make unify to propagate only one CHILD_UP event to its parent.
    Revision:
      glusterfs--mainline--2.5--patch-516


    modified files:
     libglusterfs/src/spec.y xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2007-10-05 15:13:36 GMT	Anand V. Avati <avati@80x25.org>	patch-515

    Summary:
      propagate CHILD_UP notification upwards in unify
    Revision:
      glusterfs--mainline--2.5--patch-515


    modified files:
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     xlators/cluster/unify/src/unify.c


2007-10-05 11:35:43 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-514

    Summary:
      Making the default version to start off with a file to be "2" instead of 1. This will fix a rare bug - when creating & writing to a file for the first time and killing the 1st child of afr. When the child is brought back the contents of the first child are taken to be the latest.
    Revision:
      glusterfs--mainline--2.5--patch-514


    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/storage/posix/src/posix.c


2007-10-05 07:05:02 GMT	Anand V. Avati <avati@80x25.org>	patch-513

    Summary:
      glusterfs-server init.d script update from Matthias Albert
    Revision:
      glusterfs--mainline--2.5--patch-513


    modified files:
     extras/init.d/glusterfs-server


2007-10-05 05:32:19 GMT	Amar Tumballi <amar@80x25.org>	patch-512

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-512

    * BugFix: Bug-ID #21256 - Schedulers segfault, if scheduler config is wrong. Fixed.
    
    * BugFix: Bug-ID #21259 - Applied the patch to show the correct value when block sizes of the subvolumes are different in unify. (statfs())
    
    * Corrected 'min-free-disk 5GB' to 'min-free-disk 5%' in user-guide.*

    modified files:
     doc/user-guide/user-guide.info doc/user-guide/user-guide.texi
     scheduler/alu/src/alu.c scheduler/nufa/src/nufa.c
     scheduler/random/src/random.c scheduler/rr/src/rr.c
     xlators/cluster/unify/src/unify.c


2007-10-04 21:35:05 GMT	Anand V. Avati <avati@80x25.org>	patch-511

    Summary:
      check for self-looping subvolumes
    Revision:
      glusterfs--mainline--2.5--patch-511


    modified files:
     libglusterfs/src/spec.y


2007-10-04 09:25:34 GMT	Anand V. Avati <avati@80x25.org>	patch-510

    Summary:
      mark data_t holding reference with locked attribute in posix_readv
    Revision:
      glusterfs--mainline--2.5--patch-510


    modified files:
     xlators/storage/posix/src/posix.c


2007-10-03 18:50:53 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-509

    Summary:
      to make sure that we handle the case when "for (i = 0; i < child_count; i++)" loop fails, we STACK_UNWIND with error instead of segfaulting.
    Revision:
      glusterfs--mainline--2.5--patch-509


    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/storage/posix/src/posix.c


2007-10-03 17:19:10 GMT	Anand V. Avati <avati@80x25.org>	patch-508

    Summary:
      reply references dictionary marked 'locked' in posix_readv - caused unpredictable double free's and heap corruption
    Revision:
      glusterfs--mainline--2.5--patch-508


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-10-03 06:52:25 GMT	Anand V. Avati <avati@80x25.org>	patch-507

    Summary:
      fix in storage/posix to calculate to usec from nsec
    Revision:
      glusterfs--mainline--2.5--patch-507


    modified files:
     xlators/storage/posix/src/posix.c


2007-10-02 17:54:02 GMT	Anand V. Avati <avati@80x25.org>	patch-506

    Summary:
      accept special characters in parser
    Revision:
      glusterfs--mainline--2.5--patch-506


    modified files:
     libglusterfs/src/spec.l


2007-10-02 09:33:47 GMT	Amar Tumballi <amar@80x25.org>	patch-505

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-505

    
    * xlatotrs/cluster/unify: fix for dict_ref (dict) bug, there is a possibility that, dict may be NULL.
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-09-30 19:19:39 GMT	Amar Tumballi <amar@80x25.org>	patch-504

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-504

    * fixed an issue unify rename, where there was a chance for creating duplicate entries, when re-mounted.
    
    * added SIGUSR1 to print malloc_stats, in glusterfsd.

    modified files:
     glusterfsd/src/glusterfsd.c xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c


2007-09-29 06:39:56 GMT	Anand V. Avati <avati@80x25.org>	patch-503

    Summary:
      handle case in afr_getxattr when nodes go down after lookup before getxattr from another client having a succeeded lookup
    Revision:
      glusterfs--mainline--2.5--patch-503


    modified files:
     xlators/cluster/afr/src/afr.c


2007-09-28 13:05:27 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-502

    Summary:
      AFR readdir will give precedence for contents of the first child.
    Revision:
      glusterfs--mainline--2.5--patch-502


    modified files:
     xlators/cluster/afr/src/afr.c


2007-09-27 17:56:17 GMT	Amar Tumballi <amar@80x25.org>	patch-501

    Summary:
      1.3.3
    Revision:
      glusterfs--mainline--2.5--patch-501

    * candidate for 1.3.3 release
    
    * fixed an issue with afr_writev_cbk. store the stat of successful write.
    
    * fixed an warning in trash.

    modified files:
     configure.ac xlators/cluster/afr/src/afr.c
     xlators/features/trash/src/trash.c


2007-09-27 10:31:29 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-500

    Summary:
      call_count was not being initialsed to 0. Bug fix.
    Revision:
      glusterfs--mainline--2.5--patch-500


    modified files:
     xlators/cluster/afr/src/afr.c


2007-09-27 09:38:10 GMT	Anand V. Avati <avati@80x25.org>	patch-499

    Summary:
      handle case when rename happens on a path, which has got a new inode number by an unlink/create by another client.
    Revision:
      glusterfs--mainline--2.5--patch-499


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-09-26 18:45:31 GMT	Amar Tumballi <amar@80x25.org>	patch-498

    Summary:
      striping support in stripe_mknod()
    Revision:
      glusterfs--mainline--2.5--patch-498

    * Added support of striping in stripe_mknod() fop, as in older FUSE, creat() fop is split as mknod() + open().

    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-09-26 18:14:26 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-497

    Summary:
      posix_rmelem was doing system("rm -rf <path>") which is bad! now using nftw() call to do the same.
    Revision:
      glusterfs--mainline--2.5--patch-497


    modified files:
     xlators/storage/posix/src/posix.c


2007-09-26 13:17:35 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-496

    Summary:
      if write fails on a child, no further operations shall be done on it (also version should not be incremented on it)
    Revision:
      glusterfs--mainline--2.5--patch-496


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-09-26 08:27:16 GMT	Amar Tumballi <amar@80x25.org>	patch-495

    Summary:
      commit for glusterfs-1.3.2 release
    Revision:
      glusterfs--mainline--2.5--patch-495

    * removed one unneccessary log in stripe.c

    modified files:
     configure.ac xlators/cluster/stripe/src/stripe.c


2007-09-25 20:49:30 GMT	Amar Tumballi <amar@80x25.org>	patch-494

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-494

    * fixed a typo in stripe.c

    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-09-25 12:24:21 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-493

    Summary:
      overflow of wind_count in stripe_local was causing the stripe_writev to STACK_WIND even before the whole buffer is written. Changed it from int8_t to int32_t - Amar
    Revision:
      glusterfs--mainline--2.5--patch-493


    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-09-25 05:42:02 GMT	Anand V. Avati <avati@80x25.org>	patch-492

    Summary:
      replace inode ctx in server_lookup_cbk only if not already existing
    Revision:
      glusterfs--mainline--2.5--patch-492


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-09-24 10:29:47 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-491

    Summary:
      inode number is preserved even when one of the children go down (we remember it before calling and restore before returning.
    Revision:
      glusterfs--mainline--2.5--patch-491


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-09-22 20:24:07 GMT	Amar Tumballi <amar@80x25.org>	patch-490

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-490

    * change in xlators/features/Makefile.am:
      - '#trash' changed to 'trash'

    modified files:
     xlators/features/Makefile.am


2007-09-21 13:46:39 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-489

    Summary:
      patch-488 was causing build_fail. fixed it.
    Revision:
      glusterfs--mainline--2.5--patch-489


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-09-21 13:36:40 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-488

    Summary:
      
	bug description: 
        * client configuration: afr mirroring two bricks over client protocol
        * server configuration: posix over server protocol
        * bug: run two clients and 
                1. client1: lockfile file
                2. client2: rm -rf file
                3. client1: lockfile file (hangs)
    Revision:
      glusterfs--mainline--2.5--patch-488

    Keywords: 
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     libglusterfs/src/inode.h


2007-09-20 08:47:46 GMT	Anand V. Avati <avati@80x25.org>	patch-487

    Summary:
      graceful cleanup of protocol private on unestablished connection
    Revision:
      glusterfs--mainline--2.5--patch-487


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-09-17 11:39:54 GMT	Anand V. Avati <avati@80x25.org>	patch-486

    Summary:
      invalidate dentry when lookup fails with ENOENT
    Revision:
      glusterfs--mainline--2.5--patch-486


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-09-14 09:56:08 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-485

    Summary:
      lookup now carries extra argument need_xattr which tells posix if xattr dictionary needs to be returned back in the cbk.
    Revision:
      glusterfs--mainline--2.5--patch-485


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/xlator.h
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/trash/src/trash.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-09-13 08:47:42 GMT	Amar Tumballi <amar@80x25.org>	patch-484

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-484

    * bug fix in 'xlators/features/filter' (removed flush() fop from filter).
    
    * backported trash translator from 2.6 branch. Working. few more updates pending.

    modified files:
     configure.ac xlators/features/filter/src/filter.c
     xlators/features/trash/src/trash.c


2007-09-13 07:56:58 GMT	Anand V. Avati <avati@80x25.org>	patch-483

    Summary:
      glusterfs-server init.d script for Debian
    Revision:
      glusterfs--mainline--2.5--patch-483


    new files:
     extras/init.d/.arch-ids/glusterfs-server.id
     extras/init.d/glusterfs-server

    modified files:
     THANKS extras/init.d/Makefile.am


2007-09-13 05:42:28 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-482

    Summary:
      there was a small bug in afr_readv_cbk due to which read failover was not happening.
    Revision:
      glusterfs--mainline--2.5--patch-482


    modified files:
     xlators/cluster/afr/src/afr.c


2007-09-12 21:22:41 GMT	Anand V. Avati <avati@80x25.org>	patch-481

    Summary:
      fix in parser - #define yylval's type to char * in spec.l - fixes parsiing problem in 64bit systems
    Revision:
      glusterfs--mainline--2.5--patch-481


    modified files:
     THANKS libglusterfs/src/spec.l


2007-09-12 20:41:25 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-480

    Summary:
      there was algo error in afr_lookup_readdir_cbk in the way entries for rmelem were decided.
    Revision:
      glusterfs--mainline--2.5--patch-480


    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/protocol/client/src/client-protocol.c


2007-09-12 09:18:28 GMT	Amar Tumballi <amar@80x25.org>	patch-479

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-479

    * fixes in client protocol to return correct number of argument in STACK_UNWIND, during ENOTCONN error. (back ported from 2.6 branch)

    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-09-12 08:11:02 GMT	Amar Tumballi <amar@80x25.org>	patch-478

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-478

    * unify's 'struct stat' return storage nodes' mtime.
    
    * correction in unify for lookup_cbk(). (Now returns dict in lookup_cbk)
    * correction in stripe for lookup_cbk().
    
    * changed xlators/protocol/client's "transport-timeout" to 13 from 120.

    modified files:
     doc/translator-option.txt xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/protocol/client/src/client-protocol.c


2007-09-12 07:12:19 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-477

    Summary:
      STACK_UNWIND of lookup_cbk should pass xattr dict also. Similar fix needs to be done in unify, stripe.
    Revision:
      glusterfs--mainline--2.5--patch-477


    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/features/trash/src/trash.c
     xlators/performance/io-cache/src/io-cache.c


2007-09-11 19:54:45 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-476

    Summary:
      Changes for directory versioning.
    Revision:
      glusterfs--mainline--2.5--patch-476

    * new fops incver, rmelem
    * lookup_cbk gets dict having version info of file/dir
    * changes to all xlators considering lookup_cbk change
    * rmelem is doing rm -rf, needs a better way of handling this (move?)
    * incver is just incrementing AFR_VERSION, shouldnt be hardcoded.
    * lookup should be configurable regarding if the cbk should give the dict.
    * lookup selfheal should touch nonexisting files and give ino num from first child
    * readdir should give contents from first child (no merge needed)
    * Needs lot of code cleanup, mem leak check.

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/dict.c
     libglusterfs/src/glusterfs.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-09-11 15:37:24 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-475

    Summary:
      Fix for read failover, there was a bug in previous fix.
    Revision:
      glusterfs--mainline--2.5--patch-475


    modified files:
     xlators/cluster/afr/src/afr.c


2007-09-11 13:34:15 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-474

    Summary:
      afr_readv now implements failover if read on currently active child node fails
    Revision:
      glusterfs--mainline--2.5--patch-474


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-09-06 18:12:28 GMT	Amar Tumballi <amar@80x25.org>	patch-473

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-473

    * fix for 'divide by 0' error in ALU. 
      - if total_disk_size is 0, neglect the call and return 0.
    

    modified files:
     scheduler/alu/src/alu.c


2007-08-31 12:24:13 GMT	Anand V. Avati <avati@80x25.org>	patch-472

    Summary:
      ib-verbs/client - make default blocking connect
    Revision:
      glusterfs--mainline--2.5--patch-472


    modified files:
     transport/ib-verbs/client/src/ib-verbs-client.c


2007-08-30 13:34:20 GMT	Amar Tumballi <amar@80x25.org>	patch-471

    Summary:
      Release 1.3.1
    Revision:
      glusterfs--mainline--2.5--patch-471

    * a fix in io-cache:
      - by gowda, committed to 2.6 branch by him.
    
    * a fix in io-threads:
      - now can get the values in MB, KB, GB.

    modified files:
     configure.ac xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/io-threads/src/io-threads.c


2007-08-30 12:40:54 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-470

    Summary:
      update trans->buf->len after malloc ing trans->buf. Due to the length not being updated, write-behind on io-threads used to give I/O error when large files are copied b/w two different machines.
    Revision:
      glusterfs--mainline--2.5--patch-470


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-08-29 12:27:26 GMT	Amar Tumballi <amar@80x25.org>	patch-469

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-469

    * typo bug :O (classic example of how easy it to put a bug is glusterfs)
      ----
      callcnt = local->call_count--; should have been
      callcnt = --local->call_count;
    
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-08-29 12:13:49 GMT	Anand V. Avati <avati@80x25.org>	patch-468

    Summary:
      tune read-ahead page-count with page_count rather tha page_size
    Revision:
      glusterfs--mainline--2.5--patch-468


    modified files:
     xlators/performance/read-ahead/src/read-ahead.c


2007-08-29 10:46:47 GMT	Amar Tumballi <amar@80x25.org>	patch-467

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-467

    * minor fixes in unify_rename_unlink_cbk().

    modified files:
     xlators/cluster/unify/src/unify.c


2007-08-29 09:33:12 GMT	Amar Tumballi <amar@80x25.org>	patch-466

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-466

    * order mistake in unify_ns_rename_cbk().
      - callcount was calculated wrongly. 
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-08-29 08:54:29 GMT	Amar Tumballi <amar@80x25.org>	patch-465

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-465

    * fixes in unify. Now, no unlink happens in background (copy_frame). hence unify_bg_cbk() is removed.
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-08-29 06:22:33 GMT	Anand V. Avati <avati@80x25.org>	patch-464

    Summary:
      fix in inode replacement logic
    Revision:
      glusterfs--mainline--2.5--patch-464

    
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-08-28 20:46:08 GMT	Amar Tumballi <amar@80x25.org>	patch-463

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-463

    * a fix in unify, which caused problems when afr is used below unify. (mostly segfaults in afr_close_cbk()). 
      - Unify was doing the close() in background if open fails in one of the nodes. This caused fd_destroy to happen before the close in below layer is completed. Fixed the issue now.

    modified files:
     xlators/cluster/unify/src/unify.c


2007-08-27 11:29:20 GMT	Anand V. Avati <avati@80x25.org>	patch-462

    Summary:
      handle clashing inodes gracefully in fuse-bridge
    Revision:
      glusterfs--mainline--2.5--patch-462


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     libglusterfs/src/common-utils.c


2007-08-27 11:31:34 GMT	Amar Tumballi <amar@80x25.org>	patch-461

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-461

    * fixed a bug in ib-verbs:init(), which caused segfaults when 'ib_uverbs' module was not insterted.

    modified files:
     transport/ib-verbs/ib-verbs.c


2007-08-20 08:50:53 GMT	Amar Tumballi <amar@80x25.org>	patch-460

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-460

    * changes in libglusterfs/src/extattr.h:
      - changes done for freeBSD compilation showed up errors, when compiled on Linux machines with old glibc (without 'llistxattr()'). Correction to make it work smoothly.
    
    * transport/ib-verbs/server:
      - .bail is set to ib_verbs_bail(), which was causing segfaults. 

    modified files:
     libglusterfs/src/extattr.h
     transport/ib-verbs/server/src/ib-verbs-server.c


2007-08-16 12:02:57 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-459

    Summary:
      bug fix in io-cache
    Revision:
      glusterfs--mainline--2.5--patch-459

    * op_ret = -1 case was not handled properly in cache revalidate path, in ioc_cache_revalidate_cbk().
      - when op_ret = -1, ioc_cache_revalidate_cbk() used to set struct stat *stbuf = NULL and pass it on to
        ioc_inode_wakeup().
      - ioc_inode_wakeup() was not verifying the case of op_ret = -1.
      - now ioc_inode_wakeup() considers op_ret = -1 as revalidate failed and flushed the cache.
    

    modified files:
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/protocol/client/src/client-protocol.c


2007-08-16 08:19:17 GMT	Amar Tumballi <amar@80x25.org>	patch-458

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-458

    * updated 'doc/examples/' directory with spec files containing details of each translators.
      - more explaination need to be added by maintainers of each translator.

    new files:
     doc/examples/.arch-ids/README.id
     doc/examples/.arch-ids/afr.vol.id
     doc/examples/.arch-ids/filter.vol.id
     doc/examples/.arch-ids/io-cache.vol.id
     doc/examples/.arch-ids/io-threads.vol.id
     doc/examples/.arch-ids/posix-locks.vol.id
     doc/examples/.arch-ids/read-ahead.vol.id
     doc/examples/.arch-ids/stripe.vol.id
     doc/examples/.arch-ids/trace.vol.id
     doc/examples/.arch-ids/trash.vol.id
     doc/examples/.arch-ids/unify.vol.id
     doc/examples/.arch-ids/write-behind.vol.id doc/examples/README
     doc/examples/afr.vol doc/examples/filter.vol
     doc/examples/io-cache.vol doc/examples/io-threads.vol
     doc/examples/posix-locks.vol doc/examples/read-ahead.vol
     doc/examples/stripe.vol doc/examples/trace.vol
     doc/examples/trash.vol doc/examples/unify.vol
     doc/examples/write-behind.vol

    removed files:
     doc/examples/.arch-ids/cluster-client.vol.id
     doc/examples/.arch-ids/cluster-server-ns.vol.id
     doc/examples/.arch-ids/cluster-server1.vol.id
     doc/examples/.arch-ids/cluster-server2.vol.id
     doc/examples/.arch-ids/cluster-server3.vol.id
     doc/examples/cluster-client.vol
     doc/examples/cluster-server-ns.vol
     doc/examples/cluster-server1.vol
     doc/examples/cluster-server2.vol
     doc/examples/cluster-server3.vol

    modified files:
     doc/examples/Makefile.am doc/examples/protocol-client.vol
     doc/examples/protocol-server.vol
     doc/glusterfs-client.vol.sample

    renamed files:
     doc/examples/.arch-ids/standalone-client.vol.id
       ==> doc/examples/.arch-ids/protocol-client.vol.id
     doc/examples/.arch-ids/standalone-server.vol.id
       ==> doc/examples/.arch-ids/protocol-server.vol.id
     doc/examples/standalone-client.vol
       ==> doc/examples/protocol-client.vol
     doc/examples/standalone-server.vol
       ==> doc/examples/protocol-server.vol


2007-08-13 20:10:14 GMT	Vikas Gorur <vikas@80x25.org>	patch-457

    Summary:
      set this->private in rot-13/init() (it had mysteriously disappeared :O)
    Revision:
      glusterfs--mainline--2.5--patch-457

    
    

    modified files:
     doc/user-guide/user-guide.info doc/user-guide/user-guide.pdf
     doc/user-guide/user-guide.texi
     xlators/encryption/rot-13/src/rot-13.c


2007-08-13 15:20:54 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-456

    Summary:
      break statement missing for direct-io DISABLE option.
    Revision:
      glusterfs--mainline--2.5--patch-456


    modified files:
     glusterfs-fuse/src/glusterfs.c


2007-08-13 12:12:48 GMT	Anand V. Avati <avati@80x25.org>	patch-455

    Summary:
      altered configure.ac to pick glusterfs.spec.in from topdir
    Revision:
      glusterfs--mainline--2.5--patch-455


    modified files:
     configure.ac


2007-08-12 20:29:54 GMT	Anand Babu <ab@zresearch.com>	patch-454

    Summary:
      glusterfs.spec.in moved to topdir
    Revision:
      glusterfs--mainline--2.5--patch-454

    
    

    new files:
     .arch-ids/glusterfs.spec.in.id glusterfs.spec.in


2007-08-12 20:26:46 GMT	Anand Babu <ab@zresearch.com>	patch-453

    Summary:
      moved glusterfs.spec.in to top level. its the right place
    Revision:
      glusterfs--mainline--2.5--patch-453


    removed files:
     extras/glusterfs.spec.in

    modified files:
     Makefile.am extras/Makefile.am

    renamed files:
     extras/.arch-ids/glusterfs.spec.in.id
       ==> .arch-ids/=id


2007-08-11 17:47:28 GMT	Amar Tumballi <amar@80x25.org>	patch-452

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-452

    * correction in configure.ac file.
      - patch sent by Harshavardana Ranganath <harsha@zresearch.com>

    modified files:
     configure.ac


2007-08-09 19:30:54 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-451

    Summary:
      fixing a compile warning.
    Revision:
      glusterfs--mainline--2.5--patch-451


    modified files:
     xlators/cluster/afr/src/afr.c


2007-08-09 17:35:57 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-450

    Summary:
      fixing a bug in afr_readdir()
    Revision:
      glusterfs--mainline--2.5--patch-450


    modified files:
     xlators/cluster/afr/src/afr.c


2007-08-09 12:34:58 GMT	Anand V. Avati <avati@80x25.org>	patch-449

    Summary:
      do not decrement frame's refcount in stack destroy
    Revision:
      glusterfs--mainline--2.5--patch-449


    modified files:
     configure.ac libglusterfs/src/stack.h


2007-08-09 12:09:06 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-448

    Summary:
      fixing a memleak in afr_readdir_cbk
    Revision:
      glusterfs--mainline--2.5--patch-448


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-08-09 11:46:23 GMT	Vikas Gorur <vikas@80x25.org>	patch-447

    Summary:
      converted user guide from LyX to Texinfo format (work in progress)
    Revision:
      glusterfs--mainline--2.5--patch-447

    
    

    new files:
     doc/user-guide/.arch-ids/user-guide.info.id
     doc/user-guide/.arch-ids/user-guide.pdf.id
     doc/user-guide/.arch-ids/user-guide.texi.id
     doc/user-guide/user-guide.info doc/user-guide/user-guide.pdf
     doc/user-guide/user-guide.texi

    removed files:
     doc/user-guide/.arch-ids/user-guide.lyx.id
     doc/user-guide/.arch-ids/user-guide.tex.id
     doc/user-guide/user-guide.lyx doc/user-guide/user-guide.tex

    modified files:
     doc/user-guide/Makefile.am


2007-08-09 11:35:54 GMT	Amar Tumballi <amar@80x25.org>	patch-446

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-446

    * a bug fix (which was introduced in patch-444), in unify-self-heal.

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c


2007-08-09 09:37:41 GMT	Anand V. Avati <avati@80x25.org>	patch-445

    Summary:
      avoid swapping contexts in revalidate mismatch of server_lookup_cbk
    Revision:
      glusterfs--mainline--2.5--patch-445


    modified files:
     configure.ac xlators/protocol/server/src/server-protocol.c


2007-08-08 18:45:03 GMT	Amar Tumballi <amar@80x25.org>	patch-444

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-444

    * fixed warnings in glusterfs.c
    * some more data consistency checks in unify's self-heal code.

    modified files:
     glusterfs-fuse/src/glusterfs.c
     xlators/cluster/unify/src/unify-self-heal.c


2007-08-08 16:17:59 GMT	Amar Tumballi <amar@80x25.org>	patch-443

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-443

    * Added Christopher's name in THANKS file for giving 'init.d' script for glusterfsd.

    modified files:
     THANKS


2007-08-08 14:00:16 GMT	Amar Tumballi <amar@80x25.org>	patch-442

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-442

    * minor changes in stripe (changed variable name from 'hint' to 'striped')

    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-08-08 11:52:54 GMT	Anand V. Avati <avati@80x25.org>	patch-441

    Summary:
      added --entry-timeout and --attr-timeout command line options for fuse binding
    Revision:
      glusterfs--mainline--2.5--patch-441


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c


2007-08-07 21:24:50 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-440

    Summary:
      mkdir was not beeing done as root/root in lookup selfheal. correcting it. doing mkdir as root and then doing chown.
    Revision:
      glusterfs--mainline--2.5--patch-440


    modified files:
     xlators/cluster/afr/src/afr.c


2007-08-07 09:52:54 GMT	Anand V. Avati <avati@80x25.org>	patch-439

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-439

    reorganization of files between doc/ and extras/
    
    added init.d script, thanks to Christopher Hawkins <chawkins@veracitynetworks.com>

    new files:
     extras/.arch-ids/=id extras/.arch-ids/Makefile.am.id
     extras/Makefile.am extras/init.d/.arch-ids/=id
     extras/init.d/.arch-ids/Makefile.am.id
     extras/init.d/.arch-ids/glusterfsd.id
     extras/init.d/Makefile.am extras/init.d/glusterfsd

    modified files:
     Makefile.am configure.ac doc/Makefile.am

    renamed files:
     .arch-ids/glusterfs.spec.in.id
       ==> extras/.arch-ids/glusterfs.spec.in.id
     doc/.arch-ids/glusterfs-mode.el.id
       ==> extras/.arch-ids/glusterfs-mode.el.id
     doc/.arch-ids/glusterfs.vim.id
       ==> extras/.arch-ids/glusterfs.vim.id
     doc/.arch-ids/specgen.scm.id
       ==> extras/.arch-ids/specgen.scm.id
     doc/glusterfs-mode.el
       ==> extras/glusterfs-mode.el
     doc/glusterfs.vim
       ==> extras/glusterfs.vim
     doc/specgen.scm
       ==> extras/specgen.scm
     glusterfs.spec.in
       ==> extras/glusterfs.spec.in

    new directories:
     extras extras/.arch-ids extras/init.d extras/init.d/.arch-ids


2007-08-07 09:13:27 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-438

    Summary:
      was doing data_to_ptr(dict_get()) which was printing error msg when dict_get was NULL. changing this behavior, i.e data_to_ptr is called only if dict_get is not NULL. also not printing error msg in afr_selfheal_getxattr_cbk in case the errno is ENODATA.
    Revision:
      glusterfs--mainline--2.5--patch-438


    modified files:
     xlators/cluster/afr/src/afr.c


2007-08-07 07:21:45 GMT	Anand V. Avati <avati@80x25.org>	patch-437

    Summary:
      preserve refs across server reply thread only for readv
    Revision:
      glusterfs--mainline--2.5--patch-437


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-08-06 18:57:57 GMT	Anand V. Avati <avati@80x25.org>	patch-436

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-436

    protocol/client - fixed leaking reference dictionary in cleanup

    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-08-06 18:33:03 GMT	Anand V. Avati <avati@80x25.org>	patch-435

    Summary:
      multiple corruption fixes
    Revision:
      glusterfs--mainline--2.5--patch-435

    protocol/client:
     * client_protocol_cleanup () - unwind frames in the order in which they were saved (reverse order of saved_frames->members_list) - caused undefined behaviour when server connection died
     * client_protocol_cleanup () - fixed typo of setting refs to req_refs instead of rsp_refs - caused corruption when server connection died

    modified files:
     libglusterfs/src/dict.c
     xlators/protocol/client/src/client-protocol.c


2007-08-06 15:36:21 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-434

    Summary:
      protocol/client changes
    Revision:
      glusterfs--mainline--2.5--patch-434

    * changed reply dict as locked.
    * fixed leak in client_protocol_xfer(), by doing dict_unref in all cases.

    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-08-06 15:21:16 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-433

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-433

    in lookup/selfheal, using array of stat and removing use of "gic" completely. This should speeden up lookups.
    
    in close, incrementing the version count using array of ashptr instead of linked list. again this should avoid malloc/frees.
    
    not putting createtime/version info during create, but during close. optimization.
    
    removing gic structure from afr.h (not used anymore)
    
    introducing afrfd->write which will be used at close to see if createtime has setxattr'ed.

    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-08-06 13:02:00 GMT	Anand V. Avati <avati@80x25.org>	patch-432

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-432

    glusterfs-fuse: two direct-io-modes 'enable' and 'disable' - default to 'enable'.
    protocol/client: changed few logs to 'DEBUG' level from 'WARNING'

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c
     xlators/protocol/client/src/client-protocol.c


2007-08-06 13:49:08 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-431

    Summary:
      
	Bug: Kernel build fail stating invalid file-format of a .o file with read-ahead on io-cache. 
	Fix: flush the read-ahead data in the ra_writev_cbk. A part of the fix i.e., flush the cached data in ioc_writev_cbk has been committed in a previous commit.
    Revision:
      glusterfs--mainline--2.5--patch-431


    modified files:
     xlators/performance/read-ahead/src/read-ahead.c


2007-08-05 09:15:57 GMT	Anand V. Avati <avati@80x25.org>	patch-430

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-430

    dict - fixed validation from data_from_*() functions. 
    inode - maintain references to parent inode via dentry and unref when unsetting
    protocol/client - fix number of arguments for stack_unwind in case of EBADFD

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/dict.c
     libglusterfs/src/inode.c xlators/debug/trace/src/trace.c
     xlators/performance/write-behind/src/write-behind.c


2007-08-04 19:42:41 GMT	Anand Babu <ab@zresearch.com>	patch-429

    Summary:
      Matt's ib-verbs disable patch to rpm spec file
    Revision:
      glusterfs--mainline--2.5--patch-429


    modified files:
     glusterfs.spec.in


2007-08-04 07:43:54 GMT	Anand V. Avati <avati@80x25.org>	patch-428

    Summary:
      fixed typo in input validation
    Revision:
      glusterfs--mainline--2.5--patch-428


    modified files:
     libglusterfs/src/dict.c


2007-08-04 07:32:35 GMT	Anand V. Avati <avati@80x25.org>	patch-427

    Summary:
      input validation in dict
    Revision:
      glusterfs--mainline--2.5--patch-427


    modified files:
     libglusterfs/src/dict.c libglusterfs/src/stack.h


2007-08-04 05:54:12 GMT	Anand Babu <ab@zresearch.com>	patch-426

    Summary:
      added copyright line to configure.ac
    Revision:
      glusterfs--mainline--2.5--patch-426


    modified files:
     configure.ac


2007-08-03 11:22:09 GMT	Vikas Gorur <vikas@80x25.org>	patch-425

    Summary:
      return lock; in insert_lock in posix-locks
    Revision:
      glusterfs--mainline--2.5--patch-425

    
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2007-08-03 11:10:27 GMT	Vikas Gorur <vikas@80x25.org>	patch-424

    Summary:
      changed posix-locks to use frame->root->trans instead of frame->root->state
    Revision:
      glusterfs--mainline--2.5--patch-424

    
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2007-08-03 10:01:24 GMT	Amar Tumballi <amar@80x25.org>	patch-423

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-423

    * more fixes in stripe:
       - now if create fails in one node, close and unlink is sent to all the child nodes.
    

    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-08-03 09:49:44 GMT	Anand V. Avati <avati@80x25.org>	patch-422

    Summary:
      make refs dictionary 'is_locked' 
    Revision:
      glusterfs--mainline--2.5--patch-422


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-08-03 08:41:44 GMT	Anand V. Avati <avati@80x25.org>	patch-421

    Summary:
      dict_ref in call stub checking for refs, and not for count
    Revision:
      glusterfs--mainline--2.5--patch-421


    modified files:
     libglusterfs/src/call-stub.c


2007-08-03 08:27:21 GMT	Anand V. Avati <avati@80x25.org>	patch-420

    Summary:
      iot_writev - failover to  iov_length() when req_refs is NULL
    Revision:
      glusterfs--mainline--2.5--patch-420


    modified files:
     xlators/performance/io-threads/src/io-threads.c


2007-08-03 07:39:05 GMT	Anand V. Avati <avati@80x25.org>	patch-419

    Summary:
      protocol - keep only the buffer data_t in the refs dictionary and not the unserialized parameter dictionary.
    Revision:
      glusterfs--mainline--2.5--patch-419


    modified files:
     libglusterfs/src/dict.c libglusterfs/src/protocol.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-08-03 05:55:00 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-418

    Summary:
      io-cache bug fix
    Revision:
      glusterfs--mainline--2.5--patch-418

    * io-cache used to flush cache pages for an inode during ioc_writev(). But that led to a race condition when
      read-ahead xlator resides on top of io-cache.
    * io-cache now flushes cache pages for an inode during ioc_writev_cbk() also.

    modified files:
     xlators/performance/io-cache/src/io-cache.c


2007-08-02 20:59:58 GMT	Anand V. Avati <avati@80x25.org>	patch-417

    Summary:
      fix logging in protocol.c to display the translator name as domain
    Revision:
      glusterfs--mainline--2.5--patch-417


    modified files:
     libglusterfs/src/protocol.c


2007-08-02 20:36:12 GMT	Anand V. Avati <avati@80x25.org>	patch-416

    Summary:
      fixed missing stat buf to STACK_UNWIND in protocol/client when server is disconnected
    Revision:
      glusterfs--mainline--2.5--patch-416


    modified files:
     libglusterfs/src/common-utils.h libglusterfs/src/dict.c
     libglusterfs/src/hashfn.c
     xlators/protocol/client/src/client-protocol.c


2007-08-02 19:58:14 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-415

    Summary:
      doint dict_set of afrfdp to fd->ctx as a static ptr and not as dynptr data. This avoids a race condition memory corruption bug.
    Revision:
      glusterfs--mainline--2.5--patch-415


    modified files:
     xlators/cluster/afr/src/afr.c


2007-08-02 19:27:26 GMT	Anand V. Avati <avati@80x25.org>	patch-414

    Summary:
      reset rsp_refs when synchronously unwinding from protocol/client
    Revision:
      glusterfs--mainline--2.5--patch-414


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-08-02 18:56:34 GMT	Anand V. Avati <avati@80x25.org>	patch-413

    Summary:
      unmount mountpoint before exiting in case of initialization failure
    Revision:
      glusterfs--mainline--2.5--patch-413


    modified files:
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/dict.c


2007-08-02 18:30:10 GMT	Amar Tumballi <amar@80x25.org>	patch-412

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-412

    * correction in mount.glusterfs: if port is not given, it didn't use to take default port. Fixed.
    
    * bug fix in stripe. If open fails, send close to nodes, and return.

    modified files:
     doc/glusterfs-mode.el glusterfs-fuse/utils/mount.glusterfs.in
     xlators/cluster/stripe/src/stripe.c


2007-08-02 18:10:04 GMT	Anand V. Avati <avati@80x25.org>	patch-411

    Summary:
      reset rsp_refs pointer in posix to NULL
    Revision:
      glusterfs--mainline--2.5--patch-411


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/storage/posix/src/posix.c


2007-08-02 15:22:46 GMT	Amar Tumballi <amar@80x25.org>	patch-410

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-410

    * doc/*: minor updates
    
    * stripe.c: bug fixes. Send closedir after sending opendir.
    

    modified files:
     doc/qa/qa-high-avail-server.spec doc/translator-option.txt
     xlators/cluster/stripe/src/stripe.c


2007-08-02 14:12:11 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-409

    Summary:
      not using afrctx anymore, instead using afrfd_t. this should improve performance.
    Revision:
      glusterfs--mainline--2.5--patch-409


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-08-02 11:20:05 GMT	Anand V. Avati <avati@80x25.org>	patch-408

    Summary:
      use ->trans pointer from call root in namespace lock instead of ->state
    Revision:
      glusterfs--mainline--2.5--patch-408


    modified files:
     libglusterfs/src/lock.c


2007-08-02 11:15:11 GMT	Anand V. Avati <avati@80x25.org>	patch-407

    Summary:
      add new field in call context for transport pointer
    Revision:
      glusterfs--mainline--2.5--patch-407


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/stack.h
     xlators/protocol/server/src/server-protocol.c


2007-08-02 11:10:37 GMT	Vikas Gorur <vikas@80x25.org>	patch-406

    Summary:
      fixes in posix-locks
    Revision:
      glusterfs--mainline--2.5--patch-406

    posix-locks.c:
    	- changed delete_locks_of_pid to delete_locks_of_owner
              (check for both client_pid and transport)
            - added debugging statements (controlled via _POSIX_LOCKS_DEBUG)
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2007-08-02 10:33:09 GMT	Anand V. Avati <avati@80x25.org>	patch-405

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-405

    glusterfs-fuse - use fd passed to call in the callback and not the fd passed back in the callback

    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-08-02 10:03:05 GMT	Anand V. Avati <avati@80x25.org>	patch-404

    Summary:
      typo fixes in doc/ and cleanup in read-ahead
    Revision:
      glusterfs--mainline--2.5--patch-404


    modified files:
     doc/glusterfs-client.vol.sample
     doc/glusterfs-server.vol.sample doc/hacker-guide/Makefile.am
     doc/qa/qa-client.spec doc/translator-option.txt
     doc/user-guide/Makefile.am transport/ib-verbs/ib-verbs.c
     xlators/performance/read-ahead/src/read-ahead.c


2007-08-01 20:13:39 GMT	Anand V. Avati <avati@80x25.org>	patch-403

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-403

    transport/*/server - do not use transport_ops directly
    doc/Makefile.am - define docdir relative to $(datadir) instead of $(prefix)/share

    modified files:
     doc/Makefile.am doc/examples/Makefile.am
     glusterfs-fuse/src/fuse-bridge.c
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/ib-verbs/ib-verbs.c
     transport/ib-verbs/server/src/ib-verbs-server.c
     transport/tcp/server/src/tcp-server.c


2007-08-01 16:43:59 GMT	Anand V. Avati <avati@80x25.org>	patch-402

    Summary:
      dict + related
    Revision:
      glusterfs--mainline--2.5--patch-402

    mark dictionaries/data elements which need to be accessed with lock explicitly instead of locking for every get/set

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     libglusterfs/src/common-utils.h libglusterfs/src/dict.c
     libglusterfs/src/dict.h libglusterfs/src/protocol.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/write-behind/src/write-behind.c


2007-08-01 15:57:06 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-401

    Summary:
      stripe, trace & io-cache changes
    Revision:
      glusterfs--mainline--2.5--patch-401

    * io-cache: 
        - removed unwanted debug messages from io-cache.
    
    * stripe:
        - stripe_open() and stripe_create() filter out the O_APPEND option from flag given to open() system call.
        - stripe_lookup() stores hint in a local variable on stack instead of frame->local.
    
    * trace:
        - trace_write_cbk() now also logs 'struct stat'.
    
    
    

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/debug/trace/src/trace.c
     xlators/performance/io-cache/src/io-cache.c


2007-08-01 14:55:33 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-400

    Summary:
      made changes in selfheal code, stat call is made after getxattr only on the selfheal source file. This is an optimization.
    Revision:
      glusterfs--mainline--2.5--patch-400


    modified files:
     xlators/cluster/afr/src/afr.c


2007-08-01 11:25:58 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-399

    Summary:
      in afr_mknod_cbk, need to return success even if one of the mknods were successful. Also fixing minor debug messages.
    Revision:
      glusterfs--mainline--2.5--patch-399


    modified files:
     xlators/cluster/afr/src/afr.c


2007-08-01 10:48:12 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-398

    Summary:
      in afr_mknod_cbk, need to return success even if one of the mknods were successful.
    Revision:
      glusterfs--mainline--2.5--patch-398


    modified files:
     xlators/cluster/afr/src/afr.c


2007-08-01 09:57:36 GMT	Amar Tumballi <amar@80x25.org>	patch-397

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-397

    * doc/qa/qa-high-avail-server/client.spec:
      - updated with io-threads.
    
    * unify.c:
      fixed a bug (in case of opendir failure, it sends closedir, but callcount was not resetted).
    

    modified files:
     doc/qa/qa-high-avail-client.spec
     doc/qa/qa-high-avail-server.spec
     xlators/cluster/unify/src/unify.c


2007-08-01 00:11:36 GMT	Anand Babu <ab@zresearch.com>	patch-396

    Summary:
      guru's glusterfs.vim added
    Revision:
      glusterfs--mainline--2.5--patch-396

    * glusterfs.vim: Guru's glusterfs.vim mode file for glusterfs vol spec file
    * configure.ac: Changed version to 1.3.0 and addeded license preamble

    new files:
     doc/.arch-ids/glusterfs.vim.id doc/glusterfs.vim

    modified files:
     configure.ac xlators/protocol/client/src/client-protocol.c


2007-07-31 22:09:27 GMT	Anand V. Avati <avati@80x25.org>	patch-395

    Summary:
      license upgrade
    Revision:
      glusterfs--mainline--2.5--patch-395

    upgraded all source code license headers to use GPLv3 notice
    
    COPYING - text from http://www.gnu.org/licenses/gpl-3.0.txt

    modified files:
     COPYING glusterfs-fuse/src/fetch-spec.c
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/fuse-extra.c
     glusterfs-fuse/src/fuse-extra.h
     glusterfs-fuse/src/glusterfs-fuse.h
     glusterfs-fuse/src/glusterfs.c
     glusterfs-shell/src/extensions.c
     glusterfs-shell/src/extensions.h glusterfs-shell/src/fops.c
     glusterfs-shell/src/fops.h glusterfs-shell/src/init.c
     glusterfs-shell/src/interpreter.c
     glusterfs-shell/src/interpreter.h
     glusterfs-shell/src/primitives.c
     glusterfs-shell/src/primitives.h glusterfs-shell/src/shell.c
     glusterfs-shell/src/shell.h glusterfsd/src/glusterfsd.c
     libglusterfs/src/call-stub.c libglusterfs/src/call-stub.h
     libglusterfs/src/common-utils.c
     libglusterfs/src/common-utils.h libglusterfs/src/compat.c
     libglusterfs/src/compat.h libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/dict.c
     libglusterfs/src/dict.h libglusterfs/src/epoll.c
     libglusterfs/src/extattr.h libglusterfs/src/glusterfs.h
     libglusterfs/src/hashfn.c libglusterfs/src/hashfn.h
     libglusterfs/src/inode.c libglusterfs/src/inode.h
     libglusterfs/src/lock.c libglusterfs/src/lock.h
     libglusterfs/src/logging.c libglusterfs/src/logging.h
     libglusterfs/src/poll.c libglusterfs/src/protocol.c
     libglusterfs/src/protocol.h libglusterfs/src/scheduler.c
     libglusterfs/src/scheduler.h libglusterfs/src/stack.h
     libglusterfs/src/timer.c libglusterfs/src/timer.h
     libglusterfs/src/transport.c libglusterfs/src/transport.h
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h
     scheduler/alu/src/alu.c scheduler/alu/src/alu.h
     scheduler/nufa/src/nufa.c scheduler/nufa/src/nufa.h
     scheduler/random/src/random.c scheduler/random/src/random.h
     scheduler/rr/src/rr.c scheduler/rr/src/rr.h
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-sdp/ib-sdp.c transport/ib-sdp/ib-sdp.h
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c transport/ib-verbs/ib-verbs.h
     transport/ib-verbs/server/src/ib-verbs-server.c
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/src/tcp-server.c transport/tcp/tcp.c
     transport/tcp/tcp.h xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c
     xlators/encryption/rot-13/src/rot-13.c
     xlators/encryption/rot-13/src/rot-13.h
     xlators/features/filter/src/filter.c
     xlators/features/filter/src/filter.h
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/posix-locks/src/posix-locks.h
     xlators/features/trash/src/trash.c xlators/meta/src/meta.c
     xlators/meta/src/meta.h xlators/meta/src/misc.c
     xlators/meta/src/misc.h xlators/meta/src/tree.c
     xlators/meta/src/tree.h xlators/meta/src/view.c
     xlators/meta/src/view.h
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/read-ahead/src/read-ahead.h
     xlators/performance/stat-prefetch/src/stat-prefetch.c
     xlators/performance/stat-prefetch/src/stat-prefetch.h
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h
     xlators/storage/posix/src/posix.c


2007-07-31 21:31:20 GMT	Anand V. Avati <avati@80x25.org>	patch-394

    Summary:
      mop_stats 
    Revision:
      glusterfs--mainline--2.5--patch-394

    
    mop_stats - check for bound_xl and unwind with EINVAL if not bound
    doc/specgen.scm - cosmetic changes

    modified files:
     doc/specgen.scm xlators/protocol/server/src/server-protocol.c


2007-07-31 19:49:05 GMT	Anand V. Avati <avati@80x25.org>	patch-393

    Summary:
      newer specgen.scm :p
    Revision:
      glusterfs--mainline--2.5--patch-393


    modified files:
     doc/specgen.scm


2007-07-31 16:34:01 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-392

    Summary:
      io-cache
    Revision:
      glusterfs--mainline--2.5--patch-392

    * ioc_need_prune(), gives a margin of 20% before triggering a ioc_prune().

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/page.c


2007-07-31 16:19:32 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-391

    Summary:
      checking for afrctx=NULL and STACK_UNWIND'ing. locking/unlocking on first alive child. Fix getxattr_cbk which was printing ERROR even when there was success.
    Revision:
      glusterfs--mainline--2.5--patch-391


    modified files:
     xlators/cluster/afr/src/afr.c


2007-07-31 15:58:40 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-390

    Summary:
      io-cache changes
    Revision:
      glusterfs--mainline--2.5--patch-390

    * io-cache now provides an interface for all the fops to get ioc_inode from inode->ctx dictionary.
       - ioc_get_inode(dict_t *dict, char *name_of_xlator)
           + checks if the ioc_inode is present in the table->inodes list.
              > reupdates the ioc_inode by adding to table->inodes & table->inode_lru[weight] list.
           + simply returns ioc_inode, if ioc_inode is already present in table->inodes list.
    
    * ioc_prune now deletes all relationships of a ioc_inode from the table, if ioc_inode has no pages in cache.

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/page.c


2007-07-31 15:06:23 GMT	Anand V. Avati <avati@80x25.org>	patch-389

    Summary:
      fix for spec fetch segfault
    Revision:
      glusterfs--mainline--2.5--patch-389


    modified files:
     glusterfs-fuse/src/fetch-spec.c


2007-07-31 14:54:23 GMT	Vikas Gorur <vikas@80x25.org>	patch-388

    Summary:
      store locks in the order they were created, not reverse.
    Revision:
      glusterfs--mainline--2.5--patch-388

    
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2007-07-31 12:12:40 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-387

    Summary:
      a NULL check in dict_get. afr_statfs will send statfs on all children. It cant rely on inode->ctx data as lookup might not have happned.
    Revision:
      glusterfs--mainline--2.5--patch-387


    modified files:
     libglusterfs/src/dict.c xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h


2007-07-31 10:42:54 GMT	Anand V. Avati <avati@80x25.org>	patch-386

    Summary:
      make lock an embedded member of dict instead of malloc/free'ing it
    Revision:
      glusterfs--mainline--2.5--patch-386


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/dict.c
     libglusterfs/src/dict.h libglusterfs/src/protocol.c
     xlators/cluster/afr/src/afr.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/storage/posix/src/posix.c


2007-07-31 11:40:44 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-385

    Summary:
      added check for (op_ret == 0) in read-ahead before checking whether the file has been modified on disk in fchown_cbk and fstat_cbk
    Revision:
      glusterfs--mainline--2.5--patch-385


    modified files:
     xlators/performance/read-ahead/src/read-ahead.c


2007-07-31 08:54:27 GMT	Anand V. Avati <avati@80x25.org>	patch-384

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-384

    fix inode_parent () to neglect unlinked primary dentry

    modified files:
     libglusterfs/src/inode.c


2007-07-31 08:30:51 GMT	Anand V. Avati <avati@80x25.org>	patch-383

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-383

    
    libglusterfs/inode - disassociate inode during __passive_inode (with lock) and not in __destroy_inode()
    
    libglusterfs/common-utils: use a dns cache to use round-robin multiple A replies

    modified files:
     doc/specgen.scm libglusterfs/src/common-utils.c
     libglusterfs/src/common-utils.h libglusterfs/src/inode.c
     libglusterfs/src/transport.h
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/tcp/client/src/tcp-client.c


2007-07-30 19:49:10 GMT	Amar Tumballi <amar@80x25.org>	patch-382

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-382

    * commented out .statfs in afr's struct fops
    * added a server and client spec file to test cluster translators on server side. (Same setup as http://gluster.org/docs/index.php/GlusterFS_High_Availability_Storage_with_GlusterFS)

    new files:
     doc/qa/.arch-ids/qa-high-avail-client.spec.id
     doc/qa/.arch-ids/qa-high-avail-server.spec.id
     doc/qa/qa-high-avail-client.spec
     doc/qa/qa-high-avail-server.spec

    modified files:
     xlators/cluster/afr/src/afr.c


2007-07-30 18:30:44 GMT	Vikas Gorur <vikas@80x25.org>	patch-381

    Summary:
      bugfix in genspec.scm :P
    Revision:
      glusterfs--mainline--2.5--patch-381

    
    

    modified files:
     doc/specgen.scm


2007-07-30 18:15:33 GMT	Vikas Gorur <vikas@80x25.org>	patch-380

    Summary:
      added genspec.scm, a simple script to convert a spec tree in scheme to spec file.
    Revision:
      glusterfs--mainline--2.5--patch-380

    
    

    new files:
     doc/.arch-ids/specgen.scm.id doc/specgen.scm

    modified files:
     doc/user-guide/user-guide.lyx
     xlators/features/posix-locks/src/posix-locks.c


2007-07-30 18:20:19 GMT	Amar Tumballi <amar@80x25.org>	patch-379

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-379

    * stripe: removed .readdir from struct fops. (as its enough to read entries from first dir).
    * unify: small bug fix in unify. (unify_lookup_cbk was refering to 'inode' instead of 'local->inode')
    
    *unify-self-heal: now sends closedir to all childs if the opendir fails.

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2007-07-30 15:57:57 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-378

    Summary:
      during selfheal, missing files are created as root and later chmod() to the user. This is to take care of the case where the user has lost permission to create files in that directory.
    Revision:
      glusterfs--mainline--2.5--patch-378


    modified files:
     xlators/cluster/afr/src/afr.c


2007-07-30 13:47:27 GMT	Anand V. Avati <avati@80x25.org>	patch-377

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-377

    libglusterfs/inode - fix inode_parent() function
    afr - set local->op_ret = 0 when success

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     libglusterfs/src/common-utils.h libglusterfs/src/inode.c
     libglusterfs/src/inode.h xlators/cluster/afr/src/afr.c


2007-07-30 12:35:55 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-376

    Summary:
      poll_iteration doesnot complain about invalid poll_type when glusterfsd is run with server protocol removed
    Revision:
      glusterfs--mainline--2.5--patch-376


    modified files:
     libglusterfs/src/epoll.c libglusterfs/src/transport.c


2007-07-30 09:59:57 GMT	Anand V. Avati <avati@80x25.org>	patch-375

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-375

    
    io-cache - fix in io-cache's _lk to do extra str_to_ptr ()
    protocol/client - log cases when inode's ctx is null
    storage/posix - initialize glusterfsd_stats_nr_client

    modified files:
     libglusterfs/src/common-utils.h scheduler/rr/src/rr.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/read-ahead/src/page.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-07-30 07:42:48 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-374

    Summary:
      changes to afr to use a simple array storing errnos instead of linkedlist of gic. changes to data_to_[int|uint] functions to take into account the data whose strings are not NULL terminated. change to posix to use calloc instead of alloca in getxattr (as it should be preserved when it is dict_ref'ed.
    Revision:
      glusterfs--mainline--2.5--patch-374


    modified files:
     libglusterfs/src/dict.c xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h
     xlators/storage/posix/src/posix.c


2007-07-30 07:33:33 GMT	Amar Tumballi <amar@80x25.org>	patch-373

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-373

    * removed warnings in transport.c
    
    * check for dict_get == NULL, in case of write-behind, io-cache, io-threads.
    

    modified files:
     libglusterfs/src/transport.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/write-behind/src/write-behind.c


2007-07-27 16:21:32 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-372

    Summary:
      Use poll in case epoll system call is not implemented but library wrapper is present(HAVE_SYS_EPOLL_H will defined since wrapper is present)
    Revision:
      glusterfs--mainline--2.5--patch-372


    modified files:
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/epoll.c libglusterfs/src/glusterfs.h
     libglusterfs/src/transport.c


2007-07-26 19:32:21 GMT	Anand V. Avati <avati@80x25.org>	patch-371

    Summary:
      fixes in fuse-bridge related to hardlink handling
    Revision:
      glusterfs--mainline--2.5--patch-371

    
    fuse-bridge - update dcache with new parent/name instead of letting next lookup update it
    inode - do not list_del_init on embedded dentry member of inode in dentry_unset ()

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2007-07-26 19:26:46 GMT	Amar Tumballi <amar@80x25.org>	patch-370

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-370

    * minor bug fix in unify (refering inode in case of op_ret == -1, used to work earlier.. changed now)
    
    * stripe translator migration to 'no lists'. Now saw the improved performance in case of dbench. but still has some bugs, as glusterfs compilation over glusterfs has some errors. 
      doubt read/write order etc. need some more testing.
    

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c


2007-07-26 16:43:55 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-369

    Summary:
      io-cache minor change
    Revision:
      glusterfs--mainline--2.5--patch-369

    * changed ioc_prune() prototype to accept only ioc_table.

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/page.c


2007-07-26 15:02:23 GMT	Amar Tumballi <amar@80x25.org>	patch-368

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-368

    * added data_from_int8, data_to_int8 in dict.c/h
    
    * removed openfd list in unify.
    * some minor bug fixes.
    

    modified files:
     libglusterfs/src/dict.c libglusterfs/src/dict.h
     xlators/cluster/unify/src/unify.c


2007-07-26 05:43:11 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-367

    Summary:
      io-cache pruning changes
    Revision:
      glusterfs--mainline--2.5--patch-367

    * cache pruning changed.
       - suppose N bytes is the excess usage in cache above table->cache_size.
       - ioc_prune() traverses the ioc_inode lru list, starting from the lowest priority ioc_inodes.
       - pruned_size is considered to be the size of all the pages traversed.
       - pruning breaks when pruned_size >= N.
    * this way we make sure that a lower priority ioc_inode does not prune out pages from ioc_inode of higher priority.

    modified files:
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-07-25 21:07:08 GMT	Amar Tumballi <amar@80x25.org>	patch-366

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-366

    * changes in client-protocol.c to send inode/fd instead of NULL in case of failure. (in _cbk().)
    
    * now unify has checks for all the arguments it gets. Most of the variables are validated, before using them.
    

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c


2007-07-25 19:27:02 GMT	Anand V. Avati <avati@80x25.org>	patch-365

    Summary:
      minor fixes in io-cache
    Revision:
      glusterfs--mainline--2.5--patch-365

    io-cache - hold table lock before moving ioc-inode up the lru list in 
    io-cache - re-use calculated weight in open_cbk

    modified files:
     libglusterfs/src/common-utils.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/protocol/client/src/client-protocol.c


2007-07-25 18:27:18 GMT	Anand V. Avati <avati@80x25.org>	patch-364

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-364

    libglusterfs - print backtrace to log fd directly without going via f*/gf* functions
    
    io-cache - fix segfault when no priorities are listed
             - make number of lru lists dynamic (from static 5)

    modified files:
     glusterfs-fuse/src/Makefile.am glusterfsd/src/Makefile.am
     libglusterfs/src/common-utils.c libglusterfs/src/logging.c
     xlators/cluster/afr/src/afr.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/page.c
     xlators/protocol/client/src/client-protocol.c


2007-07-25 17:03:14 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-363

    Summary:
      io-cache offers user configurable priority based pruning
    Revision:
      glusterfs--mainline--2.5--patch-363

    * user can now provide priority for certain files to be cached. 
       - spec file option will be "option priority <pattern-1>:<priority-1>,<pattern-2>:<priority-2>,..."
    * io-cache maintains different lru lists of ioc_inode for different priority levels.
    * ioc_prune() prunes the pages of lower or same priority inode's pages to accomodate for a inode's cache space.

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-07-25 13:52:26 GMT	Amar Tumballi <amar@80x25.org>	patch-362

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-362

    * bug fix in unify_lookup_cbk (local->list was getting double free'd)

    modified files:
     xlators/cluster/unify/src/unify.c


2007-07-25 11:36:23 GMT	Anand V. Avati <avati@80x25.org>	patch-361

    Summary:
      unify and fixes
    Revision:
      glusterfs--mainline--2.5--patch-361

    unify_lookup_cbk - off by one allocation error caused heap corruption
                     - free local->list when op_ret = -1
    
    afr_close_cbk - destroy afrctx dictionary
    
    fuse_loc_fill - get parent inode directly from inode instead of second search

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     libglusterfs/src/inode.h xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify.c


2007-07-25 10:09:56 GMT	Vikas Gorur <vikas@80x25.org>	patch-360

    Summary:
      removed superfluous fuse-internals.c; added user-guide.lyx
    Revision:
      glusterfs--mainline--2.5--patch-360

    
    

    new files:
     doc/user-guide/.arch-ids/user-guide.lyx.id
     doc/user-guide/user-guide.lyx

    removed files:
     glusterfs-fuse/src/.arch-ids/fuse-internals.c.id
     glusterfs-fuse/src/.arch-ids/fuse-internals.h.id
     glusterfs-fuse/src/fuse-internals.c
     glusterfs-fuse/src/fuse-internals.h


2007-07-25 10:51:36 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-359

    Summary:
      deadlocks are fixed now (And I've tested it this time :)).
    Revision:
      glusterfs--mainline--2.5--patch-359


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-07-25 10:29:36 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-358

    Summary:
      Previous commit was causing deadlocks. Hence undoing it
    Revision:
      glusterfs--mainline--2.5--patch-358


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-07-25 08:05:54 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-357

    Summary:
      fixing a compile error in client-protocol.c
    Revision:
      glusterfs--mainline--2.5--patch-357


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-07-25 08:03:34 GMT	Amar Tumballi <amar@80x25.org>	patch-356

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-356

    * changes in unify's rename (completed a left out todo, which was causing segv)
    
    * changed unify's notify. Sends notify to schedulers instead of calling update.
    
    * added notify feature to schedulers.
    

    modified files:
     libglusterfs/src/scheduler.h scheduler/alu/src/alu.c
     scheduler/nufa/src/nufa.c scheduler/random/src/random.c
     scheduler/rr/src/rr.c xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c


2007-07-25 08:00:14 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-355

    Summary:
      addition of bailout timer and related initializations in client_protocol_handshake are done holding locks.
    Revision:
      glusterfs--mainline--2.5--patch-355


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-07-24 18:39:39 GMT	Amar Tumballi <amar@80x25.org>	patch-354

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-354

    * xlators/storage/posix:
      - posix_writedir(): added support for char/block devices and also to fifo files.
    
    * xlator/cluster/unify:
      - changed list head to int array. 
      - added checks for failure in every possible place.
    

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/storage/posix/src/posix.c


2007-07-24 09:17:24 GMT	Anand V. Avati <avati@80x25.org>	patch-353

    Summary:
      changed mutexes to spinlocks in inode and call frame
    Revision:
      glusterfs--mainline--2.5--patch-353


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c glusterfsd/src/glusterfsd.c
     libglusterfs/src/common-utils.h libglusterfs/src/inode.c
     libglusterfs/src/inode.h libglusterfs/src/stack.h
     libglusterfs/src/xlator.c scheduler/nufa/src/nufa.c
     scheduler/nufa/src/nufa.h xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-07-24 04:46:42 GMT	Anand V. Avati <avati@80x25.org>	patch-352

    Summary:
      unify_open_cbk - use local->fd to preserve fd pointer to be used in open_cbk when op_ret = -1
    Revision:
      glusterfs--mainline--2.5--patch-352


    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify.c


2007-07-23 20:03:32 GMT	Anand V. Avati <avati@80x25.org>	patch-351

    Summary:
      ra_truncate - convert value to string before converting to pointer
    Revision:
      glusterfs--mainline--2.5--patch-351

    
    

    modified files:
     xlators/performance/read-ahead/src/read-ahead.c


2007-07-23 19:49:46 GMT	Anand V. Avati <avati@80x25.org>	patch-350

    Summary:
      unify_open_cbk close 'tmpfd' from local->openfd instead of 'fd' when op_ret = -1
    Revision:
      glusterfs--mainline--2.5--patch-350


    modified files:
     doc/examples/cluster-client.vol
     doc/examples/standalone-client.vol
     xlators/cluster/unify/src/unify.c


2007-07-23 19:08:48 GMT	Anand V. Avati <avati@80x25.org>	patch-349

    Summary:
      ra_truncate - fixed sprintf'd string used as direct address
    Revision:
      glusterfs--mainline--2.5--patch-349


    modified files:
     doc/glusterfs-client.vol.sample libglusterfs/src/inode.c
     libglusterfs/src/inode.h
     xlators/performance/read-ahead/src/read-ahead.c


2007-07-23 15:19:32 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-348

    Summary:
      bug fixes in AFR, inode.c changes (by avati) to build path from latest dentry that was updated.
    Revision:
      glusterfs--mainline--2.5--patch-348


    modified files:
     libglusterfs/src/inode.c xlators/cluster/afr/src/afr.c


2007-07-23 11:57:30 GMT	Anand V. Avati <avati@80x25.org>	patch-347

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-347

    stripe_lookup - first lookup used to stack_wind only to first_child, hence reporting wrong file size (cuased md5sum mismatch)

    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-07-23 07:44:07 GMT	Anand V. Avati <avati@80x25.org>	patch-346

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-346

    protocol/server: server_reply_proc(): get bound_xl before replying to client since transport could be destroyed by then
    
    performanc/read-ahead: for truncate flush within locks

    modified files:
     libglusterfs/src/protocol.c
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/src/tcp-server.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/read-ahead/src/read-ahead.h
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-07-22 09:55:08 GMT	Anand V. Avati <avati@80x25.org>	patch-345

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-345

    glusterfs-fuse: add fd->inode_list to fd->inode->fds in fuse_fd_cbk

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/performance/io-cache/src/page.c


2007-07-21 21:04:32 GMT	Anand V. Avati <avati@80x25.org>	patch-344

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-344

    io-cache: force cache revalidation on lk() calls
              make forced revalidation timeout configurable in spec file

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/page.c


2007-07-21 20:18:44 GMT	Anand V. Avati <avati@80x25.org>	patch-343

    Summary:
      logging enhancement
    Revision:
      glusterfs--mainline--2.5--patch-343

    logging - make gf_log extremely cheap for cases where loglevel is > than set value (excessive usage of GF_LOG_DEBUG messages in code will be cheap when loglevel is set higher)

    modified files:
     libglusterfs/src/logging.c libglusterfs/src/logging.h


2007-07-21 20:10:12 GMT	Anand V. Avati <avati@80x25.org>	patch-342

    Summary:
      io-cache fixes
    Revision:
      glusterfs--mainline--2.5--patch-342

    * ioc_frame_fill - wrong calculation of 'count' used to cause heap corruption
    * fixed locking in multiple places
    * changed lock static inlines to macros for easier logging output

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-07-21 00:56:34 GMT	Anand V. Avati <avati@80x25.org>	patch-341

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-341

    force flush-behind off in write-behind

    modified files:
     xlators/performance/write-behind/src/write-behind.c


2007-07-21 00:21:07 GMT	Anand V. Avati <avati@80x25.org>	patch-340

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-340

    write-behind: delete context from fd before wb_sync

    modified files:
     configure.ac glusterfs-fuse/src/fuse-bridge.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/storage/posix/src/posix.c


2007-07-21 00:07:11 GMT	Anand Babu <ab@zresearch.com>	patch-339

    Summary:
      removed unsed variable warnings
    Revision:
      glusterfs--mainline--2.5--patch-339


    modified files:
     xlators/storage/posix/src/posix.c


2007-07-20 23:56:52 GMT	Anand V. Avati <avati@80x25.org>	patch-338

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-338

    handle GF_EVENT_CHILD_UP event correctly in transport

    modified files:
     glusterfsd/src/glusterfsd.c libglusterfs/src/xlator.c
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/tcp/server/src/tcp-server.c


2007-07-20 22:39:44 GMT	Anand V. Avati <avati@80x25.org>	patch-337

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-337

    fuse_xattr_cbk -use fuse_reply_err instead of fuse_reply_xattr to return ENODATA

    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-07-20 22:11:19 GMT	Anand V. Avati <avati@80x25.org>	patch-336

    Summary:
      removed the -1 in fuse_xattr_cbk as well
    Revision:
      glusterfs--mainline--2.5--patch-336


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-07-20 21:39:19 GMT	Anand V. Avati <avati@80x25.org>	patch-335

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-335

    fix in getxattr to treat binary data correctly

    modified files:
     xlators/storage/posix/src/posix.c


2007-07-20 20:45:40 GMT	Anand V. Avati <avati@80x25.org>	patch-334

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-334

    unify - fixed bug in setting st_size and st_blocks in unify_buf_cbk when namespace stat returns the last
    
    fuse - getattr: if inode has open file and is not directory, prefer an fstat

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-07-20 18:14:05 GMT	Anand V. Avati <avati@80x25.org>	patch-333

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-333

    read-ahead: added new 'option force-atime-update on' which defaults to off
    
    posix: removed 'len - 1' during lsetxattr (complementary fix went into fuse_setxattr by changing data_from_dynstr to bin_to_data)
    
    dict: removed couple of warnings

    modified files:
     libglusterfs/src/dict.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/read-ahead/src/read-ahead.h
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-07-20 13:12:58 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-332

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-332

    
    * is_cache_still_valid() now handles the case of empty 'struct stat'
    * dispatch_request() differentiates between in-transit and cache-hit while doing ioc_page_wakeup() for case
      when revalidation is not required. 

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-07-20 11:24:00 GMT	Amar Tumballi <amar@80x25.org>	patch-331

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-331

    * fix for statfs failing case when 'df' is the first call after mount:
      - now no one should use inode reference in statfs call.
    

    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-07-20 11:14:40 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-330

    Summary:
      disable read-ahead on random reads
    Revision:
      glusterfs--mainline--2.5--patch-330


    modified files:
     xlators/performance/read-ahead/src/read-ahead.c


2007-07-20 08:38:43 GMT	Vikas Gorur <vikas@80x25.org>	patch-329

    Summary:
      handle SIGTERM in glusterfsd
    Revision:
      glusterfs--mainline--2.5--patch-329

    glustefsd.c: handle SIGTERM. Delete PID file and exit(0) in the handler.
    

    modified files:
     glusterfsd/src/glusterfsd.c


2007-07-20 07:25:00 GMT	Vikas Gorur <vikas@80x25.org>	patch-328

    Summary:
      Ported GlusterFS server to FreeBSD
    Revision:
      glusterfs--mainline--2.5--patch-328

    configure.ac: Check for dlopen first in libc, and then check for libdl
    	      FreeBSD provides dlopen in libc itself.
    
    configure.ac: Don't abort if libexecinfo is not found.
    
    libglusterfs/src/common-utils.c: check for HAVE_BACKTRACE before including
    				 execinfo.h
    
    xlators/.../afr.c: don't include malloc.h. It is nonstandard.
    
    xlators/.../posix.c: Fix no. of args in SET_FS_UID_GID macro.
    
    libglusterfs/src/glusterfs.h: provide definition for O_DIRECTORY.
    
    configure.ac: Check if struct stat has atim, mtim, and ctim
    	      (HAVE_TV_NSEC).
    xlators/.../server-protocol.c:
    xlators/.../client-protocol.c: 
    xlators/.../io-cache.c:        use *tim.tv_nsec only if HAVE_TV_NSEC is defined.
    
    xlators/.../posix-locks.h: Removed unwanted include of asm/types.h
    
    [ADD] libglusterfs/.../compat.[ch]: Files to provide argp related functions. 
          				    --help does not work, however.
    
    [ADD] libglusterfs/.../extattr.h: Alias {llist,set,get}xattr to their FreeBSD
                                      equivalents.
    
    configure.ac: check for fdatasync()
    xlators/.../posix.c: Do fdatasync() only if it is available. 
    
    

    new files:
     libglusterfs/src/.arch-ids/compat.c.id
     libglusterfs/src/.arch-ids/compat.h.id
     libglusterfs/src/.arch-ids/extattr.h.id
     libglusterfs/src/compat.c libglusterfs/src/compat.h
     libglusterfs/src/extattr.h

    modified files:
     configure.ac glusterfsd/src/glusterfsd.c
     libglusterfs/src/Makefile.am libglusterfs/src/common-utils.c
     libglusterfs/src/glusterfs.h libglusterfs/src/transport.c
     xlators/cluster/afr/src/afr.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/performance/io-cache/src/page.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2007-07-19 20:48:40 GMT	Anand V. Avati <avati@80x25.org>	patch-327

    Summary:
      warning fixes
    Revision:
      glusterfs--mainline--2.5--patch-327

    use format string macros from stdint/inttype for cross platform compatiblity in dict

    modified files:
     libglusterfs/src/dict.c


2007-07-19 20:25:24 GMT	Amar Tumballi <amar@80x25.org>	patch-326

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-326

    * added server-ns.vol and glusterfs-mode.el in Makefile.am

    new files:
     doc/examples/.arch-ids/cluster-server-ns.vol.id
     doc/examples/cluster-server-ns.vol

    modified files:
     doc/Makefile.am doc/examples/Makefile.am


2007-07-19 20:03:53 GMT	Anand V. Avati <avati@80x25.org>	patch-325

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-325

    fuse_setxattr - use bin_to_data instead of data_from_dynstr for value

    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-07-19 19:27:35 GMT	Anand V. Avati <avati@80x25.org>	patch-324

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-324

    io-cache: lookup_cbk - fix to check for failure before doing dict_get on inode
    
    protocol/client: send inode in callback even for op_ret = -1

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/protocol/client/src/client-protocol.c


2007-07-19 19:13:36 GMT	Anand V. Avati <avati@80x25.org>	patch-323

    Summary:
      multiple bug fixes
    Revision:
      glusterfs--mainline--2.5--patch-323

    afr: use 'afrctx' instead of fd->ctx in closedir
    
    stripe_readv_cbk: update from *stbuf only if op_ret >= 0
    
    stripe notify: propagate notification messages up
    
    read-ahead fault_cbk: remove loop when op_ret = -1
    
    read-ahead create_cbk: do not attempt read-ahead
    
    io-cache fault_cbk: remove loop when op_ret = -1
                        check for op_ret -1 around ioc_inode__still_valid
                        check for page == NULL before increasing cache_used
    
    protocol-client: return FD even when op_ret = -1
    

    modified files:
     configure.ac doc/qa/qa-client.spec
     glusterfs-fuse/src/fuse-bridge.c xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/protocol/client/src/client-protocol.c


2007-07-19 16:43:54 GMT	Anand V. Avati <avati@80x25.org>	patch-322

    Summary:
      op_ret -1 check before updating ioc_inode->buf
    Revision:
      glusterfs--mainline--2.5--patch-322



2007-07-19 16:36:14 GMT	Anand V. Avati <avati@80x25.org>	patch-321

    Summary:
      merged from glusterfs--tmp--2.5
    Revision:
      glusterfs--mainline--2.5--patch-321


    new files:
     doc/.arch-ids/glusterfs-mode.el.id doc/glusterfs-mode.el

    modified files:
     configure.ac doc/Makefile.am glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/common-utils.h
     libglusterfs/src/defaults.c libglusterfs/src/defaults.h
     libglusterfs/src/dict.c libglusterfs/src/hashfn.c
     libglusterfs/src/inode.c libglusterfs/src/inode.h
     libglusterfs/src/xlator.h
     transport/ib-sdp/client/src/ib-sdp-client.c
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c
     xlators/features/filter/src/filter.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/posix-locks/src/posix-locks.h
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-07-18 07:26:11 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-320

    Summary:
      
	* Added checks in posix.c for successful return of stat/lstat/fstat calls before updating the inode->buf
	* Return from the init (with return value of -1) of protocol/server if transport_load fails
    Revision:
      glusterfs--mainline--2.5--patch-320


    modified files:
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-07-17 09:40:36 GMT	Anand Babu <ab@zresearch.com>	patch-319

    Summary:
      fixed ib-sdp connection refused bug
    Revision:
      glusterfs--mainline--2.5--patch-319

    * Packet family should be AF_INET_SDP
    * Propagated connection retry mechanism from tcp-client transport driver.
    

    modified files:
     transport/ib-sdp/client/src/ib-sdp-client.c


2007-07-17 04:06:37 GMT	Anand Babu <ab@zresearch.com>	patch-318

    Summary:
      added THANKS file to Makefile.am and glusterfs.spec extra dist
    Revision:
      glusterfs--mainline--2.5--patch-318


    modified files:
     Makefile.am glusterfs.spec.in


2007-07-16 13:17:20 GMT	Anand Babu <ab@zresearch.com>	patch-317

    Summary:
      added glusterfs.spec.in RPM spec and THANKS file.
    Revision:
      glusterfs--mainline--2.5--patch-317

    Thanks to Matt Paine <matt@mattsoftware.com>

    new files:
     .arch-ids/THANKS.id .arch-ids/glusterfs.spec.in.id THANKS
     glusterfs.spec.in

    modified files:
     AUTHORS Makefile.am configure.ac


2007-07-16 12:04:52 GMT	Anand Babu <ab@zresearch.com>	patch-316

    Summary:
      version number to 1.3.pre6
    Revision:
      glusterfs--mainline--2.5--patch-316


    modified files:
     configure.ac


2007-07-16 09:09:32 GMT	Anand Babu <ab@zresearch.com>	patch-315

    Summary:
      lex and fuse build fixes
    Revision:
      glusterfs--mainline--2.5--patch-315

    * AC_PROG_LEX sets LEXLIB and it should be explicitly referenced in Makefile.am
    * FUSE_CLIENT_LIB should only be used by LDADD and not CFLAGS

    modified files:
     configure.ac glusterfs-fuse/src/Makefile.am
     libglusterfs/src/Makefile.am


2007-07-14 21:12:56 GMT	Anand Babu <ab@zresearch.com>	patch-314

    Summary:
      remove glusterfsd fuse dependency
    Revision:
      glusterfs--mainline--2.5--patch-314


    modified files:
     Makefile.am configure.ac glusterfs-fuse/src/Makefile.am


2007-07-13 10:12:35 GMT	Amar Tumballi <amar@80x25.org>	patch-313

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-313

    * fix in client_protocol_handshake_reply() (if parent is null, don't call notify)
    
    * fix in unify_buf_cbk(), for the case of -1.
    
    * minor fixes in unify and unify-self-heal for return value.
    
    * cleanup in write-behind.
    
    * changed configure.ac's version to 5.4 from 5.2

    modified files:
     configure.ac xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c


2007-07-13 09:05:29 GMT	Anand V. Avati <avati@80x25.org>	patch-312

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-312

    fix in posix-locks - pl_create_cbk used to dict_set inode_t to inode_t->ctx
    which caused random memory corruption
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c
     xlators/storage/posix/src/posix.c


2007-07-13 10:36:03 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-311

    Summary:
      call wb_sync before STACK_WINDING in fops like stat.
    Revision:
      glusterfs--mainline--2.5--patch-311


    modified files:
     xlators/performance/write-behind/src/write-behind.c


2007-07-13 05:37:34 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-310

    Summary:
      fixed a typo in macro definition of freee. Was assert (free != EEEEKS) instead of assert (ptr != EEEEKS).
    Revision:
      glusterfs--mainline--2.5--patch-310


    modified files:
     libglusterfs/src/common-utils.h


2007-07-12 21:11:56 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-309

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-309

    
    
    * pages_used bug removed from ioc_need_prune()

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-07-12 15:24:02 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-308

    Summary:
      fixing a bug in fuse_xattr_cbk, getfattr command used to print junk when we tried to get value for an invalid key because op_ret was 43 though value is nt valid. But still there is a problem, op_errno by posix is being returned as "4" which is "Sys call interrupted". Needs investigation.
    Revision:
      glusterfs--mainline--2.5--patch-308


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-07-12 14:35:19 GMT	Anand V. Avati <avati@80x25.org>	patch-307

    Summary:
      added freee() macro to catch possible double free
    Revision:
      glusterfs--mainline--2.5--patch-307


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/fuse-extra.c
     glusterfs-fuse/src/fuse-extra.h libglusterfs/src/call-stub.c
     libglusterfs/src/common-utils.h libglusterfs/src/dict.c
     libglusterfs/src/inode.c libglusterfs/src/lock.c
     libglusterfs/src/protocol.c libglusterfs/src/spec.y
     libglusterfs/src/stack.h libglusterfs/src/timer.c
     libglusterfs/src/transport.c libglusterfs/src/xlator.c
     xlators/cluster/afr/src/afr.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h
     xlators/storage/posix/src/posix.c


2007-07-12 13:02:07 GMT	Anand V. Avati <avati@80x25.org>	patch-306

    Summary:
      handled pruning for MOP returning proc when bound_xl is not set
    Revision:
      glusterfs--mainline--2.5--patch-306


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-07-12 12:57:56 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-305

    Summary:
      fixed a lot of FIXMEs. Also handling case gracefully when the child nodes die when self heal is happening.
    Revision:
      glusterfs--mainline--2.5--patch-305


    modified files:
     libglusterfs/src/logging.h xlators/cluster/afr/src/afr.c


2007-07-12 10:44:42 GMT	Anand V. Avati <avati@80x25.org>	patch-304

    Summary:
      setxattr/getxattr dictionaries are now unserialized from a memdup()'ed buffer
    Revision:
      glusterfs--mainline--2.5--patch-304


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-07-12 10:17:47 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-303

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-303

    
    
    * fixed io-cache to decrement pages_used during ioc_prune()

    modified files:
     libglusterfs/src/list.h
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/write-behind/src/write-behind.c


2007-07-12 08:18:18 GMT	Anand V. Avati <avati@80x25.org>	patch-302

    Summary:
      keep inode refs until _cbk in protocol/server
    Revision:
      glusterfs--mainline--2.5--patch-302

    
    

    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-07-12 09:30:57 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-301

    Summary:
      update inode->buf in client-protocol only if call is suceeded 
    Revision:
      glusterfs--mainline--2.5--patch-301


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-07-12 03:33:53 GMT	Amar Tumballi <amar@80x25.org>	patch-300

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-300

    * bug fixes in stripe. (handling op_ret == -1)
    
    * added inode's stat buf update in both unify and stripe xlators.
    

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c


2007-07-11 17:31:28 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-299

    Summary:
      tail -f now works properly. added mtime awareness to read-ahead.c. Also modified posix and client xlators to update inode->buf whenever its possible in _cbks
    Revision:
      glusterfs--mainline--2.5--patch-299


    modified files:
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-07-11 12:47:01 GMT	Amar Tumballi <amar@80x25.org>	patch-298

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-298

    * warning fix in fuse-bridge.c
    
    * fix in unify_mkdir_cbk for setting the inode's generation number.
    
    * fix in 'transports/ib-verbs/*'.
      After the recent notify() changes and moving handshake to protocol translator, it never worked. It works from this patch.

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c
     transport/ib-verbs/server/src/ib-verbs-server.c
     xlators/cluster/unify/src/unify.c


2007-07-11 12:54:39 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-297

    Summary:
      fixed a type in io-threads
    Revision:
      glusterfs--mainline--2.5--patch-297


    modified files:
     xlators/performance/io-threads/src/io-threads.c


2007-07-11 10:22:48 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-296

    Summary:
      acquire locks before doing list_empty on loc->inode->fd list
    Revision:
      glusterfs--mainline--2.5--patch-296


    modified files:
     xlators/performance/io-threads/src/io-threads.c


2007-07-11 06:49:16 GMT	Anand V. Avati <avati@80x25.org>	patch-295

    Summary:
      fixed afr_forget bug introduced due to new forget semantics
    Revision:
      glusterfs--mainline--2.5--patch-295


    modified files:
     xlators/cluster/afr/src/afr.c


2007-07-11 07:17:22 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-294

    Summary:
      removed reply, meta threads from io-threads. Also retained only those fops that are needed by io-threads.
    Revision:
      glusterfs--mainline--2.5--patch-294


    modified files:
     libglusterfs/src/call-stub.c
     transport/tcp/client/src/tcp-client.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h
     xlators/protocol/client/src/client-protocol.c


2007-07-10 15:56:50 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-293

    Summary:
      minor fix in posix-lock (STACK_UNWIND should happen when open fails) and added GF_BUG_ON code to afr.
    Revision:
      glusterfs--mainline--2.5--patch-293


    modified files:
     libglusterfs/src/logging.h xlators/cluster/afr/src/afr.c
     xlators/features/posix-locks/src/posix-locks.c


2007-07-10 15:04:55 GMT	Amar Tumballi <amar@80x25.org>	patch-292

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-292

    * df -h output fix
    
    * unify_lookup_cbk now doesn't return -1 if it sees file inconsistency, so rm -rf never fails. But while opening in a file it return's error.
    
    * posix_lk returns ENOSYS instead of -ENOSYS.

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-07-10 14:03:09 GMT	Amar Tumballi <amar@80x25.org>	patch-291

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-291

    * some minor fixes in unify_mkdir_cbk()
    
    * changed readdir code to return just the entries from namespace.
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-07-10 12:25:35 GMT	Anand V. Avati <avati@80x25.org>	patch-290

    Summary:
      inode forget is put as a callback to avoid race conditions
    Revision:
      glusterfs--mainline--2.5--patch-290


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/inode.c libglusterfs/src/inode.h
     libglusterfs/src/stack.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/page.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-07-10 09:20:21 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-289

    Summary:
      fixed a bug in trace
    Revision:
      glusterfs--mainline--2.5--patch-289


    modified files:
     xlators/debug/trace/src/trace.c


2007-07-10 07:35:18 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-288

    Summary:
      
	* initialized the .mknod member of fops in stripe
	* fixed segfault in unify_rmdir and unify_ns_rmdir_cbk with the xlator configuration of unify, stripe and posix.
    Revision:
      glusterfs--mainline--2.5--patch-288


    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/performance/read-ahead/src/read-ahead.c


2007-07-09 15:56:16 GMT	Anand V. Avati <avati@80x25.org>	patch-287

    Summary:
      create call pool during glusterfsd initiaization and not on-demand
    Revision:
      glusterfs--mainline--2.5--patch-287


    modified files:
     glusterfsd/src/glusterfsd.c


2007-07-09 06:57:53 GMT	Anand V. Avati <avati@80x25.org>	patch-286

    Summary:
      fixed issue when first client to server is not a valid client (e.g telnet)
    Revision:
      glusterfs--mainline--2.5--patch-286


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-07-08 11:27:22 GMT	Anand V. Avati <avati@80x25.org>	patch-285

    Summary:
      avoid duplicate reconnection threads in protocol/client
    Revision:
      glusterfs--mainline--2.5--patch-285


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-07-07 01:23:07 GMT	Amar Tumballi <amar@80x25.org>	patch-284

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-284

    * corrected some typos in doc/example/cluster-client.vol
    
    * changed unify_unlink to send request to unlink to both namespace and storage node in one function rather than waiting to get return value of namespace.
    
    * changed unify_rmdir to handle forgets, to avoid race condition arises due to using io-theads with unify.
    

    modified files:
     doc/examples/cluster-client.vol
     xlators/cluster/unify/src/unify.c


2007-07-06 15:28:31 GMT	Anand V. Avati <avati@80x25.org>	patch-283

    Summary:
      fixes
    Revision:
      glusterfs--mainline--2.5--patch-283

    * fuse_lookup - fixed per-lookup to happen on fuse_inode instead of child
    * unify_ns_{rmdir,unlink}_cbk - break based on break count insted of list  

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/cluster/unify/src/unify.c


2007-07-06 12:59:24 GMT	Amar Tumballi <amar@80x25.org>	patch-282

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-282

    * added writedir() in stripe translator. Without this, stripe couldn't be used under unify. Now, works fine.
    
    * small correction in unify and posix translators.
    
    * changed doc/qa/qa*spec files to work with the latest release.
    
    

    modified files:
     doc/qa/qa-client.spec doc/qa/qa-server.spec
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-07-06 12:28:31 GMT	Anand V. Avati <avati@80x25.org>	patch-281

    Summary:
      client_writedir - check for NULL fd_data and return EBADFD
    Revision:
      glusterfs--mainline--2.5--patch-281


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-07-06 13:48:02 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-280

    Summary:
      * Added SETFSID related macros to posix.c
	 * Added check for setfsuid/setfsgid in configure.ac
	 * Fixed some mem leaks in unify.c
    Revision:
      glusterfs--mainline--2.5--patch-280


    modified files:
     configure.ac xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-07-06 09:00:18 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-279

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-279

    
    
    * io-cache deadlock issue solved

    modified files:
     libglusterfs/src/call-stub.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/protocol/server/src/server-protocol.c


2007-07-06 07:50:58 GMT	Anand V. Avati <avati@80x25.org>	patch-278

    Summary:
      added extra logs to report frame type and op during unwinding from cleanup
    Revision:
      glusterfs--mainline--2.5--patch-278


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-07-06 03:30:43 GMT	Amar Tumballi <amar@80x25.org>	patch-277

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-277

    * leak fixes in unify. (LOCK_DESTROY() was not done in some places)
    
    * inode_unref(local->inode) in unify_ns_create() moved to unify_create_cbk()
    
    * in unify_rmdir(), rmdir was sent twice to namespace, which was leading to fd leak.
    
    * leak fix in posix_writedir().
    

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-07-06 11:18:09 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-276

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-276


    modified files:
     AUTHORS


2007-07-06 04:50:55 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-275

    Summary:
      Propogating PARENT_UP event to the children of AFR. type/posix will send me back CHILD_UP event. So this fixes the problem where type/posix is used as child for afr and create fails.
    Revision:
      glusterfs--mainline--2.5--patch-275


    modified files:
     xlators/cluster/afr/src/afr.c


2007-07-05 11:49:38 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-274

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-274

    
    
    * ioc_frame_fill() SIGSEGV bug fixed. ioc_page_get() used to return offsetted address off ioc_inode_t to which the page belongs.

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-07-06 02:41:18 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-273

    Summary:
      local->op_ret was initialized to ENOENT instead of local->op_errno :-(
    Revision:
      glusterfs--mainline--2.5--patch-273


    modified files:
     xlators/cluster/afr/src/afr.c


2007-07-05 06:55:15 GMT	Anand V. Avati <avati@80x25.org>	patch-272

    Summary:
      never turn on direct_io in fuse bridge
    Revision:
      glusterfs--mainline--2.5--patch-272


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/storage/posix/src/posix.c


2007-07-05 03:30:52 GMT	Amar Tumballi <amar@80x25.org>	patch-271

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-271

    * bug fixes related to '-s' option of glusterfs.
    
    * updated client spec file in doc/glusterfs-client.vol.example

    modified files:
     doc/glusterfs-client.vol.sample
     glusterfs-fuse/src/fetch-spec.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-07-05 01:25:43 GMT	Amar Tumballi <amar@80x25.org>	patch-270

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-270

    * xlators/performance/io-threads:
      - removed iot_writedir(). This fop is not required to be queued, and this solves the problem of using io-threads below unify.
    
    * xlators/cluster/unify:
      - fixed bugs with unify_opendir_cbk() segfault in case of local->fd being null and local->failed is true.
      - fixed a memory leak in unify_lookup_cbk. (This used to happen only in case of inconsistancy in file count is seen).

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/performance/io-threads/src/io-threads.c


2007-07-04 15:50:37 GMT	Anand V. Avati <avati@80x25.org>	patch-269

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-269

    fixed f_blocks/f_bfree/f_bavail calculation based on f_bsize scaled to BIG_FUSE_CHAN_SIZE

    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-07-04 11:15:10 GMT	Anand V. Avati <avati@80x25.org>	patch-268

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-268

    
    fix for rogue 'valid' flag sent from NFS re-export
    
    fixed TRAP_ON warnings in dict.c
    
    added frame->root->callid to be equal to fuse's callid, eases debugging
    
    change 'int32_t op' to 'glusterfs_fop_t op' in parameters of client_protocol_xfer to display name of fop from the enum instead of number

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/fuse-extra.c
     glusterfs-fuse/src/fuse-extra.h libglusterfs/src/dict.c
     xlators/debug/trace/src/trace.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-07-03 15:31:38 GMT	Vikas Gorur <vikas@80x25.org>	patch-267

    Summary:
      check for op_ret value in truncate_stat_cbk in posix-locks
    Revision:
      glusterfs--mainline--2.5--patch-267

    
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2007-07-03 15:14:33 GMT	Amar Tumballi <amar@80x25.org>	patch-266

    Summary:
      added code in schedulers/* to update the framelist when new frames are created.
    Revision:
      glusterfs--mainline--2.5--patch-266


    modified files:
     scheduler/alu/src/alu.c scheduler/nufa/src/nufa.c
     scheduler/random/src/random.c scheduler/rr/src/rr.c


2007-07-03 14:56:28 GMT	Anand V. Avati <avati@80x25.org>	patch-265

    Summary:
      list of all created frames in a pool for tracking lost frames
    Revision:
      glusterfs--mainline--2.5--patch-265


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/glusterfs.h
     libglusterfs/src/stack.h
     xlators/protocol/server/src/server-protocol.c


2007-07-04 06:56:14 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-264

    Summary:
      While selfhealing the permission/ownership, do it as root and later restore the permission of the frame. So that we dont get any EPERM error. Also check for (op_ret = 0) :O
    Revision:
      glusterfs--mainline--2.5--patch-264


    modified files:
     xlators/cluster/afr/src/afr.c


2007-07-03 14:18:20 GMT	Amar Tumballi <amar@80x25.org>	patch-263

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-263

    * a bug fix in unify_lookup_cbk(), during revalidate, when namespace lookup fails, inode_unref used to fail in assert().
    

    modified files:
     xlators/cluster/unify/src/unify.c


2007-07-03 10:25:04 GMT	Amar Tumballi <amar@80x25.org>	patch-262

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-262

    * fix for reported bug in unify_sh_readdir_cbk, when op_ret is = -1,
    
    * fixes in xlators/performance/* translators to take arguments as 1MB, 128kB etc.
    

    modified files:
     configure.ac libglusterfs/src/common-utils.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c


2007-07-03 12:30:54 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-261

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-261

    Fix to sync permissions and ownership (is done during lookup)

    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-07-02 18:21:12 GMT	Amar Tumballi <amar@80x25.org>	patch-260

    Summary:
      proper fixes in server_inode_pruning (by Avati)
    Revision:
      glusterfs--mainline--2.5--patch-260


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-07-02 17:26:01 GMT	Vikas Gorur <vikas@80x25.org>	patch-259

    Summary:
      fixed a bug in io-threads
    Revision:
      glusterfs--mainline--2.5--patch-259

    io-threads.c: iot_ftruncate: allocate frame->local before calling stub

    modified files:
     xlators/performance/io-threads/src/io-threads.c


2007-07-02 15:01:34 GMT	Anand V. Avati <avati@80x25.org>	patch-258

    Summary:
      fixed typo in fuse_readdir :(
    Revision:
      glusterfs--mainline--2.5--patch-258


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-07-02 13:16:43 GMT	Amar Tumballi <amar@80x25.org>	patch-257

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-257

    * removed 'inode_unref' in server_protocol_inode_prune().
    
    * added check for op_ret != -1 in case of lookup_cbk of call_stub.
    
    * changed EINVAL to ENOTCONN in unify for identifying child down status.
    
    

    modified files:
     libglusterfs/src/call-stub.c xlators/cluster/unify/src/unify.c
     xlators/protocol/server/src/server-protocol.c


2007-07-02 13:00:36 GMT	Anand V. Avati <avati@80x25.org>	patch-256

    Summary:
      flush dentry data on rewinddir in fuse
    Revision:
      glusterfs--mainline--2.5--patch-256


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-07-02 12:22:12 GMT	Anand V. Avati <avati@80x25.org>	patch-255

    Summary:
      pre-lookup fix++, fixed $(docdir) in examples/Makefile.am
    Revision:
      glusterfs--mainline--2.5--patch-255


    modified files:
     doc/examples/Makefile.am glusterfs-fuse/src/fuse-bridge.c


2007-07-02 12:03:11 GMT	Anand V. Avati <avati@80x25.org>	patch-254

    Summary:
      pre-lookup fix
    Revision:
      glusterfs--mainline--2.5--patch-254


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/protocol/server/src/server-protocol.c


2007-07-02 11:38:32 GMT	Anand V. Avati <avati@80x25.org>	patch-253

    Summary:
      pre-lookup for revalidate to avoid forget+revalidate bugs
    Revision:
      glusterfs--mainline--2.5--patch-253


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-07-02 09:51:22 GMT	Anand V. Avati <avati@80x25.org>	patch-252

    Summary:
      fixed dict_destroy in setxattr's stub resume
    Revision:
      glusterfs--mainline--2.5--patch-252


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-07-02 07:24:06 GMT	Anand V. Avati <avati@80x25.org>	patch-251

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-251

    protocol/server - add locks around open_files, open_dirs
    
    protocol/client - handle proper unref of inodes in case of server discon

    modified files:
     libglusterfs/src/common-utils.h libglusterfs/src/dict.c
     libglusterfs/src/stack.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-07-02 00:00:33 GMT	Amar Tumballi <amar@80x25.org>	patch-250

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-250

    * fixed a bug related to local becoming NULL in unify_bg_cbk(). Wrong frame was sent to unlink in case of lookup finds inconsistencies.
    
    * storage nodes' rmdir/unlink is moved to foreground. Earlier after the rmdir/unlink of namespace, it was returning and continuing the call in background. This caused bugs.

    modified files:
     xlators/cluster/unify/src/unify.c


2007-07-01 09:24:36 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-249

    Summary:
      setfsuid/setfsgid works per thread context. Hence removed locks which were used while performing setfsuid/setfsgid operations. Also added #ifdef linux macros. 
    Revision:
      glusterfs--mainline--2.5--patch-249


    modified files:
     libglusterfs/src/glusterfs.h
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2007-07-01 23:01:26 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-248

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-248

    * Bugfix for the case when create fails during selfheal.
    * Selfhealing of symlinks.
    * Bugfix for creating of replicas with proper mode during selfheal.
    * Bugfix in posix-locks in pl_create_cbk (NULL pointer check)

    modified files:
     xlators/cluster/afr/src/afr.c
     xlators/features/posix-locks/src/posix-locks.c


2007-06-30 11:10:25 GMT	Anand V. Avati <avati@80x25.org>	patch-247

    Summary:
      fixed server pruning not to screw lru_size
    Revision:
      glusterfs--mainline--2.5--patch-247


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-30 02:01:44 GMT	Amar Tumballi <amar@80x25.org>	patch-246

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-246

    * committing fixes for reported bugs in savannah.
       bug id #20049, #20050, #20052, #20053.

    modified files:
     libglusterfs/src/glusterfs.h


2007-06-30 12:53:53 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-245

    Summary:
      When mknod gets called to create a file, during close it will now increment version to 1, previously it was getting set to 0 because of which it was not getting replicated when the other server was brought up and the file was opened. Also fixed a bug in fuse-bridge.c related to setxattr. setxattr logic is not correct (related to the way "len" of the dictionary is interpreted) in posix's setxattr it assumes that value is a null terminated string.
    Revision:
      glusterfs--mainline--2.5--patch-245


    modified files:
     glusterfs-fuse/src/fuse-bridge.c xlators/cluster/afr/src/afr.c
     xlators/storage/posix/src/posix.c


2007-06-29 17:40:18 GMT	Amar Tumballi <amar@80x25.org>	patch-244

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-244

    * libglusterfs/src/call_stub:
      - removed comments of inode_unref in lookup_cbk.
    
    * few small bug fixes in server inode pruning to run smoothly with io-threads.
    
    * bug fix in unify's self heal [fd_destroy (fd) -> fd_destroy (local->fd)]
    
    * more enhancement in unify's self-heal, now it removes stale namespace entries.
    
    * small fixes in nufa scheduler, and changes in unify's init to look for 
      the return value of scheduler's init.
    
    * correction in unify's statfs. (used to send *loc directly to child nodes, 
      now sends proper loc_t value to client nodes.)
    

    modified files:
     doc/translator-option.txt libglusterfs/src/call-stub.c
     scheduler/nufa/src/nufa.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/server/src/server-protocol.c


2007-06-29 13:31:23 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-243

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-243

    
    
    * added dict_ref() and dict_unref() in posix_getxattr() for case having no xattr

    modified files:
     libglusterfs/src/call-stub.c xlators/storage/posix/src/posix.c


2007-06-29 09:21:57 GMT	Anand V. Avati <avati@80x25.org>	patch-242

    Summary:
      dict_destroy - leave it for call_resume's dict_unref in protocol/server
    Revision:
      glusterfs--mainline--2.5--patch-242


    modified files:
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-29 08:17:46 GMT	Anand V. Avati <avati@80x25.org>	patch-241

    Summary:
      makefile fixes
    Revision:
      glusterfs--mainline--2.5--patch-241


    modified files:
     Makefile.am configure.ac glusterfs-fuse/src/fuse-bridge.c
     libglusterfs/src/Makefile.am
     xlators/protocol/server/src/server-protocol.c


2007-06-27 10:59:02 GMT	Anand V. Avati <avati@80x25.org>	patch-240

    Summary:
      fixed open-fail-cleanup code to handle 0-success case
    Revision:
      glusterfs--mainline--2.5--patch-240


    modified files:
     xlators/cluster/unify/src/unify.c


2007-06-27 00:56:05 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-239

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-239

    
    
    * fixed ioc_table_lock() issue in page destroy in io-cache

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/page.c


2007-06-27 15:35:00 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-238

    Summary:
      One minor fix.
    Revision:
      glusterfs--mainline--2.5--patch-238

    
    

    modified files:
     xlators/cluster/afr/src/afr.c


2007-06-26 22:57:45 GMT	Anand V. Avati <avati@80x25.org>	patch-237

    Summary:
      dict ref/unref fixes for setxattr
    Revision:
      glusterfs--mainline--2.5--patch-237

    
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     xlators/protocol/server/src/server-protocol.c


2007-06-26 23:01:56 GMT	Amar Tumballi <amar@80x25.org>	patch-236

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-236

    * fixes in writedir()
      - in unify-self-heal.c,
           client-protocol.c,
           server-protocol.c,
           posix.c,
           call-stub.c,
        
    * fix in unify's lookup_cbk ().. :( 
      - a silly comment put in my earlier patch removed.

    modified files:
     libglusterfs/src/call-stub.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-27 15:09:07 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-235

    Summary:
      Another bug fix :D
    Revision:
      glusterfs--mainline--2.5--patch-235


    modified files:
     xlators/cluster/afr/src/afr.c


2007-06-26 22:30:42 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-234

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-234

    
    
    * added ioc_inode_lock/unlock() during pruning of pages in io-cache

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/page.c


2007-06-26 22:08:05 GMT	Anand V. Avati <avati@80x25.org>	patch-233

    Summary:
      fixed NULL check of dict
    Revision:
      glusterfs--mainline--2.5--patch-233


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-06-26 21:49:46 GMT	Anand V. Avati <avati@80x25.org>	patch-232

    Summary:
      getxattr_cbk - correctly ref and unref dictionaries
    Revision:
      glusterfs--mainline--2.5--patch-232


    modified files:
     glusterfsd/src/glusterfsd.c libglusterfs/src/call-stub.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-27 13:38:17 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-231

    Summary:
      Removed a few debugs. last change for pre 1.3 release
    Revision:
      glusterfs--mainline--2.5--patch-231


    modified files:
     doc/examples/cluster-client.vol xlators/cluster/afr/src/afr.c


2007-06-26 20:49:17 GMT	Amar Tumballi <amar@80x25.org>	patch-230

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-230

    * call_stub: in stub_writedir(), call_stub_new () was called with argument
      	used for lk()( GF_FOP_LK should be GF_FOP_WRITEDIR)
    
    * in unify_lookup_cbk () check for inode change if its revalidate.
    
    * fixed a bug in posix create(). inode_unref was called even if inode is 0.
    

    modified files:
     libglusterfs/src/call-stub.c xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-06-26 18:38:16 GMT	Amar Tumballi <amar@80x25.org>	patch-229

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-229

    * mkdir() in unify is not done in background now, to work with io-threads
    * enhancements for readdir_cbk. (if namespace entry is not there, it should return error)
    
    * fix in server-protocol, in case bound_xl is NULL

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/server/src/server-protocol.c


2007-06-27 10:47:17 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-228

    Summary:
      bug fixes.
    Revision:
      glusterfs--mainline--2.5--patch-228


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-06-26 16:45:28 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-227

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-227

    
    
    * fixed all build warnings
    * fixed a minor string leak in io-cache

    modified files:
     libglusterfs/src/xlator.c xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/protocol/client/src/client-protocol.c


2007-06-26 18:10:32 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-226

    Summary:
      fixed memory leak in call-stub. thread scheduling added to lookup in io-threads
    Revision:
      glusterfs--mainline--2.5--patch-226


    modified files:
     libglusterfs/src/call-stub.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h


2007-06-26 15:36:26 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-225

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-225

    
    
    * removed all refereces to ioc_inode_ref() in io-cache

    modified files:
     xlators/performance/io-cache/src/io-cache.c


2007-06-26 16:19:25 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-224

    Summary:
      uncommenting inode_unref in call_resume of forget
    Revision:
      glusterfs--mainline--2.5--patch-224


    modified files:
     libglusterfs/src/call-stub.c
     xlators/performance/io-threads/src/io-threads.c


2007-06-26 11:30:40 GMT	Amar Tumballi <amar@80x25.org>	patch-223

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-223

    * added inode_unref () in create(), which was causing memory leaks.

    modified files:
     xlators/storage/posix/src/posix.c


2007-06-26 12:40:42 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-222

    Summary:
      added the transport name to gf_log in bail_transport
    Revision:
      glusterfs--mainline--2.5--patch-222


    modified files:
     libglusterfs/src/call-stub.c
     xlators/protocol/client/src/client-protocol.c


2007-06-26 10:56:05 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-221

    Summary:
      any fop with a valid inode passed to it as argument gets scheduled to an I/O thread. Also fixed some tabbing issues in list.h
    Revision:
      glusterfs--mainline--2.5--patch-221


    modified files:
     libglusterfs/src/call-stub.c libglusterfs/src/list.h
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c


2007-06-26 06:35:19 GMT	Amar Tumballi <amar@80x25.org>	patch-220

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-220

    * leak fixes in client-protocol.
    
    * sending stat only in case of op_ret >= 0 in server, and checking for stat only in op_ret >=0 in client.
    
    * removed trash from build, as its not yet ready.

    modified files:
     xlators/cluster/unify/src/unify.c xlators/features/Makefile.am
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-26 04:57:16 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-219

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-219

    
    
    * fd_destroy() changed to lock and unlock properly for deleting from list.
    * read-ahead changed to handle the case of dict_get () returning NULL.

    modified files:
     libglusterfs/src/xlator.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/protocol/client/src/client-protocol.c


2007-06-26 03:35:35 GMT	Amar Tumballi <amar@80x25.org>	patch-218

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-218

    * unify_stat_cbk (): fixed a bug with entry_count
    
    * stripe's fd list updates.

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c


2007-06-26 00:54:47 GMT	Amar Tumballi <amar@80x25.org>	patch-217

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-217

    * moved unify's self-heal to foreground, which fixes the bugs related to partial namespace creation. 

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2007-06-25 23:43:41 GMT	Amar Tumballi <amar@80x25.org>	patch-216

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-216

    * schedulers/alu:
      - a fix for the case of alu.limits.min-free-disk, which used to cause divide
        by 0 error.
    
    * xlators/cluster/unify:
      - fixed issues with lookup(), in case of inconsistency in case of files. 
        Even open in case of create works fine. (this happens when EEXIST is 
        returned from create over namespace).

    modified files:
     scheduler/alu/src/alu.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2007-06-25 21:40:18 GMT	Anand V. Avati <avati@80x25.org>	patch-215

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-215

    check in posix_forget for (inode->private != NULL)

    modified files:
     xlators/storage/posix/src/posix.c


2007-06-25 21:35:53 GMT	Anand V. Avati <avati@80x25.org>	patch-214

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-214

    * removed fd looping in read-ahead truncate
    * trick to ensure inode number not recycled by keeping fd open on unlinked file between unlink/rmdir and forget

    modified files:
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/storage/posix/src/posix.c


2007-06-25 17:32:17 GMT	Anand V. Avati <avati@80x25.org>	patch-213

    Summary:
      fixes in call-stub
    Revision:
      glusterfs--mainline--2.5--patch-213


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c


2007-06-25 17:29:01 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-212

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-212

    * missing frame found

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/protocol/client/src/client-protocol.c


2007-06-25 17:30:44 GMT	Amar Tumballi <amar@80x25.org>	patch-211

    Summary:
      correction/bug fixes
    Revision:
      glusterfs--mainline--2.5--patch-211

    * added 'doc/translator-option.txt' file, which lists all the options given in glusterfs.
    
    * changed 'xl' to 'this' in afr's init() and fini().
    
    * added 'option inode-lru-limit' to posix, unify, stripe, afr.
    
    * correcting of indexes in write-behind & io-threads.
    
    * added cleanup code in fini() of client-protocol, posix-locks.
    

    new files:
     doc/.arch-ids/translator-option.txt.id
     doc/translator-option.txt

    modified files:
     scheduler/alu/src/alu.c xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/features/posix-locks/src/posix-locks.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-25 14:50:06 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-210

    Summary:
      io-threads and call-stub now implements all the fops. Currently works with posix. bugs are surfaced when loaded on the server side along with posix
    Revision:
      glusterfs--mainline--2.5--patch-210

    
    

    modified files:
     libglusterfs/src/call-stub.c libglusterfs/src/call-stub.h
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h


2007-06-25 13:10:39 GMT	Amar Tumballi <amar@80x25.org>	patch-209

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-209

    * enhanced unify's self-heal. Now its done only if inconsistancy is seen.
    
    * corrected op_errno==EEXIST in case of create. Need to send open, but now
      corrected it to do a lookup before sending open.
    

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2007-06-25 12:33:57 GMT	Anand V. Avati <avati@80x25.org>	patch-208

    Summary:
      fd_create/fd_destroy wrapper functions
    Revision:
      glusterfs--mainline--2.5--patch-208

    modified posix, client-protocol, unify to use them, afr and stripe pending

    modified files:
     libglusterfs/src/call-stub.c libglusterfs/src/inode.c
     libglusterfs/src/inode.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-26 04:34:53 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-207

    Summary:
      changing user.trusted.afr.* to trusted.afr.* "attr" command misguided me :-(
    Revision:
      glusterfs--mainline--2.5--patch-207


    modified files:
     xlators/cluster/afr/src/afr.c


2007-06-26 04:04:18 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-206

    Summary:
      making inode->private 0xffffffff in afr_forget. also we should not delete inode->private in case lookup_cbk fails in case of relookup.
    Revision:
      glusterfs--mainline--2.5--patch-206


    modified files:
     xlators/cluster/afr/src/afr.c


2007-06-24 21:57:55 GMT	Amar Tumballi <amar@80x25.org>	patch-205

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-205

    * xlators/cluster/unify:
      - enhanced self-heal code. 
      - fixed a segfault bug caused due to fd->inode_list list.

    modified files:
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2007-06-24 21:16:11 GMT	Anand V. Avati <avati@80x25.org>	patch-204

    Summary:
      fixed typo in fuse-bridge.c
    Revision:
      glusterfs--mainline--2.5--patch-204


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-06-24 19:54:52 GMT	Anand V. Avati <avati@80x25.org>	patch-203

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-203

    
    * disable flush-behind in write-behind by default
    * send 1MB as blksize in stat replies to fuse kernel module

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/performance/write-behind/src/write-behind.c


2007-06-24 13:03:14 GMT	Amar Tumballi <amar@80x25.org>	patch-202

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-202

    * xlators/storage/posix:
      - writedir () : removed setfsuid code. It needs to be done as only 'root', and need to do chmod and chown according to each entry.
    
    * xlators/cluster/unify:
      - enhanced opendir_cbk ().
    
    * xlators/debug/trace:
      - printing loc->path where ever there is 'loc'

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/storage/posix/src/posix.c


2007-06-24 02:12:10 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-201

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-201

    
    
    * added ioc_cache_still_valid() to compare ioc_inode->stbuf against stbuf given.
       - used by ioc_fault_cbk() and ioc_validate_cbk()

    modified files:
     xlators/debug/trace/src/trace.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-06-24 01:12:00 GMT	Anand V. Avati <avati@80x25.org>	patch-200

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-200

    protocol/client: look for 'marked' dir fd in case of server disconnection

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/protocol/client/src/client-protocol.c


2007-06-23 14:02:49 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-199

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-199

    
    
    * page wakeup was being done outside inode lock in validate_cbk()
    	- caused call frame leak on the page queue

    modified files:
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-06-23 10:26:21 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-198

    Summary:
      buffer ovverrun fixes in posix.c, poll.c and some cleanup in write-behind.c
    Revision:
      glusterfs--mainline--2.5--patch-198


    modified files:
     libglusterfs/src/poll.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/storage/posix/src/posix.c


2007-06-23 00:35:05 GMT	Anand V. Avati <avati@80x25.org>	patch-197

    Summary:
      fixed local allocation in truncate() in io-trheads
    Revision:
      glusterfs--mainline--2.5--patch-197


    modified files:
     libglusterfs/src/call-stub.c
     xlators/performance/io-threads/src/io-threads.c


2007-06-23 00:29:45 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-196

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-196

    
    
    * removed readv_continue in io-cache.
    * cache validation is done per page now, earlier done per frame.

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c


2007-06-22 20:17:00 GMT	Anand V. Avati <avati@80x25.org>	patch-195

    Summary:
      locking fixes in io-cache, delayed marking of waitq to avoid pruning races
    Revision:
      glusterfs--mainline--2.5--patch-195

    
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/cluster/unify/src/unify.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/io-threads/src/io-threads.c


2007-06-22 06:39:19 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-194

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-194

    
    
    * locking bugs fixed in io-cache

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-06-22 03:32:08 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-193

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-193

    
    
    * fixing mistake number n, where n is huge.

    modified files:
     xlators/performance/io-cache/src/io-cache.c


2007-06-22 03:08:54 GMT	Anand V. Avati <avati@80x25.org>	patch-192

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-192

    fixed minor memory leaks in
    - io-cache
    - read-ahead
    
    fixed log messages formatting in transport/tcp

    modified files:
     transport/tcp/server/src/tcp-server.c transport/tcp/tcp.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/read-ahead/src/read-ahead.c


2007-06-22 02:48:26 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-191

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-191

    
    
    * removed the debug log file creation in io-cache

    modified files:
     xlators/performance/io-cache/src/io-cache.c


2007-06-22 02:29:21 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-190

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-190

    
    
    * removed refcount for ioc_inode_t

    modified files:
     xlators/performance/io-cache/src/ioc-inode.c


2007-06-22 01:03:11 GMT	Anand V. Avati <avati@80x25.org>	patch-189

    Summary:
      fix in fuse_fd_cbk 
    Revision:
      glusterfs--mainline--2.5--patch-189

    correctly sends close() and closedir() according to st_mode in stbuf when EINTR is received to application
    
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-06-22 01:00:11 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-188

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-188

    
    
    * waitq frame cleanup in validate_cbk() of io-cache

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c


2007-06-21 23:00:20 GMT	Anand V. Avati <avati@80x25.org>	patch-187

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-187

    * fix in fuse-bridge to handle xattr_cbk correctly
    * temporarily disassociated inode->fd relations
    * removed unnecessary error message about notify() missing (changed to warning)

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/xlator.c
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c


2007-06-21 21:30:17 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-186

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-186

    * read-ahead over io-cache works now

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c


2007-06-21 17:39:34 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-185

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-185

    
    
    * correcting the tla commit problem 

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/page.c


2007-06-21 17:10:01 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-184

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-184

    * changed io-cache internals
    

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/page.c


2007-06-21 17:00:41 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-183

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-183

    * changed io-cache internals
    

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-06-21 17:00:50 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-182

    Summary:
      added cleanup of open directories in server_protocol_cleanup
    Revision:
      glusterfs--mainline--2.5--patch-182


    modified files:
     xlators/performance/io-cache/src/page.c
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-06-22 07:46:31 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-181

    Summary:
      Fixed inode mem leaks
    Revision:
      glusterfs--mainline--2.5--patch-181


    modified files:
     xlators/cluster/afr/src/afr.c


2007-06-21 16:08:43 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-180

    Summary:
      buffer is unrefed in call_resume_unwind of writev only if count > 0
    Revision:
      glusterfs--mainline--2.5--patch-180


    modified files:
     libglusterfs/src/call-stub.c


2007-06-21 10:43:31 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-179

    Summary:
      readv_cbk in call_frame_unwind is made to dict_unref the response only if read is succeeded
    Revision:
      glusterfs--mainline--2.5--patch-179


    modified files:
     libglusterfs/src/call-stub.c


2007-06-21 08:55:01 GMT	Anand V. Avati <avati@80x25.org>	patch-178

    Summary:
      fix inode_unlink call to be called only if op_ret == 0 in fuse-bridge
    Revision:
      glusterfs--mainline--2.5--patch-178


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/performance/write-behind/src/write-behind.c


2007-06-21 07:12:08 GMT	Amar Tumballi <amar@80x25.org>	patch-177

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-177

    * xlators/protocol/client-protocol: 
      - a leak fix in open/close (made remote_fd str to dynstr)
    
    * xlators/cluster/unify:
      - enhancement to correction in open and close.
    

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c


2007-06-21 05:10:46 GMT	Amar Tumballi <amar@80x25.org>	patch-176

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-176

    * leak fix in writedir () of server protocol.
    
    * updated doc/examples/* with the information about changes in unify translator.
    

    modified files:
     doc/examples/cluster-client.vol
     xlators/cluster/unify/src/unify.c
     xlators/protocol/server/src/server-protocol.c


2007-06-21 18:10:34 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-175

    Summary:
      bugfixes for setup where we use posix directly under afr.
    Revision:
      glusterfs--mainline--2.5--patch-175


    modified files:
     xlators/cluster/afr/src/afr.c


2007-06-21 01:23:08 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-174

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-174

    * io-cache now validates only if cache hit happens.
    

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/src/server-protocol.c


2007-06-20 21:04:47 GMT	Anand V. Avati <avati@80x25.org>	patch-173

    Summary:
      memory leak fixes in protocol/server
    Revision:
      glusterfs--mainline--2.5--patch-173


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-20 14:44:02 GMT	Anand V. Avati <avati@80x25.org>	patch-172

    Summary:
      fixed mem leak in call-stub for writev and readv_cbk
    Revision:
      glusterfs--mainline--2.5--patch-172


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     xlators/protocol/client/src/client-protocol.c


2007-06-20 11:16:54 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-171

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-171

    * scattered inode pruning into callbacks which get inode_t as one of the argument in protocol/server
    

    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-20 10:38:51 GMT	Amar Tumballi <amar@80x25.org>	patch-170

    Summary:
      bug fixes.
    Revision:
      glusterfs--mainline--2.5--patch-170

    * many small bug fixes related to handling op_errno in case of op_ret == -1

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-06-20 23:49:02 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-169

    Summary:
      afr changes (bug fixes, clean up). call-stub call_resume() implemantation for readlink
    Revision:
      glusterfs--mainline--2.5--patch-169

    
    

    modified files:
     xlators/cluster/afr/src/afr.c


2007-06-20 01:44:52 GMT	Anand V. Avati <avati@80x25.org>	patch-168

    Summary:
      fixed frame->local = NULL for server_rename when both inodes are found
    Revision:
      glusterfs--mainline--2.5--patch-168


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-19 22:18:58 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-167

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-167

    * fixed ghostly disappearance bug in protocol/server (return 0)
    
    

    modified files:
     libglusterfs/src/call-stub.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-19 21:40:10 GMT	Anand V. Avati <avati@80x25.org>	patch-166

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-166

    io-threads - fixed missing stub creation in flush
               - fixed logging format

    modified files:
     transport/ib-verbs/client/src/ib-verbs-client.c
     xlators/performance/io-threads/src/io-threads.c


2007-06-20 12:52:48 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-165

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-165

    
    

    modified files:
     libglusterfs/src/stack.h xlators/cluster/afr/src/afr.c
     xlators/cluster/afr/src/afr.h


2007-06-19 21:14:42 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-164

    Summary:
      bug-fixes in io-threads/call-stub
    Revision:
      glusterfs--mainline--2.5--patch-164


    modified files:
     libglusterfs/src/call-stub.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h


2007-06-19 19:31:54 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-163

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-163

    * used call_resume in place of STACK_WIND, whenever calll_stub is created in 
    protocol/server
    
    
    

    modified files:
     libglusterfs/src/call-stub.c
     xlators/protocol/server/src/server-protocol.c


2007-06-19 18:45:50 GMT	Anand V. Avati <avati@80x25.org>	patch-162

    Summary:
      fixed lru_size getting -ve in protocol-server
    Revision:
      glusterfs--mainline--2.5--patch-162


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-19 19:59:25 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-161

    Summary:
      added lock_wipe, inode_unref
    Revision:
      glusterfs--mainline--2.5--patch-161

    
    

    modified files:
     libglusterfs/src/call-stub.c


2007-06-19 18:39:51 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-160

    Summary:
      call-stub
    Revision:
      glusterfs--mainline--2.5--patch-160

    
    

    modified files:
     libglusterfs/src/call-stub.c


2007-06-19 16:23:22 GMT	Anand V. Avati <avati@80x25.org>	patch-159

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-159

    protocol/client: avoid creating two reconnect threads in race condittion when handshake fails

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     xlators/protocol/client/src/client-protocol.c


2007-06-19 15:14:25 GMT	Anand V. Avati <avati@80x25.org>	patch-158

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-158

    fix in client_close and client_closedir on 'stale' fds
    fix in client_protocol_xfer to call the callback instead of STACK_UNWIND in case of transfer failure

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     libglusterfs/src/stack.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-19 12:36:32 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-157

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-157

    * lot of inode_ref() & inode_unref () balancing
    * memory leak fixes
    

    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-19 06:43:20 GMT	Anand V. Avati <avati@80x25.org>	patch-156

    Summary:
      fixed notification event type (from 'default' to GF_EVENT_CHILD_UP)
    Revision:
      glusterfs--mainline--2.5--patch-156


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-19 04:10:11 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-155

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-155

    * procotol/client
      - fixed issue of missing inode_ref() for inode kept in frame->local

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-19 00:01:35 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-154

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-154

    * protocol/server
      - fixed leaks due to control flow path change at call_stub.
      - fixed rename bug
    

    modified files:
     libglusterfs/src/call-stub.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-18 22:38:43 GMT	Amar Tumballi <amar@80x25.org>	patch-153

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-153

    * fixed a leak in client_protocol_writedir ()
    
    * moved LOCK(), UNLOCK(), LOCK_INIT(), LOCK_DESTROY() macros to common-utils.h
    
    * fixed memory leak bugs in unify and stripe xlators. Works without memory leak now.
    
    * fixed 'trace' xlator to handle the case of 'op_ret == -1' when de-referencing struct stat *stbuf.
    

    modified files:
     libglusterfs/src/common-utils.h
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c
     xlators/protocol/client/src/client-protocol.c


2007-06-18 21:25:40 GMT	Anand V. Avati <avati@80x25.org>	patch-152

    Summary:
      fix in inode pruning
    Revision:
      glusterfs--mainline--2.5--patch-152


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-18 20:32:46 GMT	Anand V. Avati <avati@80x25.org>	patch-151

    Summary:
      fix in posix for setfsuid in readdir
    Revision:
      glusterfs--mainline--2.5--patch-151


    modified files:
     xlators/storage/posix/src/posix.c


2007-06-18 20:23:41 GMT	Anand V. Avati <avati@80x25.org>	patch-150

    Summary:
      fix in default_link
    Revision:
      glusterfs--mainline--2.5--patch-150

    
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/defaults.c


2007-06-18 20:11:10 GMT	Anand V. Avati <avati@80x25.org>	patch-149

    Summary:
      typo fix :(
    Revision:
      glusterfs--mainline--2.5--patch-149


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-18 20:03:50 GMT	Anand V. Avati <avati@80x25.org>	patch-148

    Summary:
      minor fixes in protocol/server
    Revision:
      glusterfs--mainline--2.5--patch-148


    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-18 19:32:08 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-147

    Summary:
      * server protocol call_resume restructured
    Revision:
      glusterfs--mainline--2.5--patch-147


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     xlators/protocol/server/src/server-protocol.c


2007-06-18 17:18:49 GMT	Anand V. Avati <avati@80x25.org>	patch-146

    Summary:
      fix in posix to create lock in global context
    Revision:
      glusterfs--mainline--2.5--patch-146


    modified files:
     xlators/storage/posix/src/posix.c


2007-06-18 16:53:00 GMT	Anand V. Avati <avati@80x25.org>	patch-145

    Summary:
      typo in glusterfs-fuse fixed
    Revision:
      glusterfs--mainline--2.5--patch-145


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-06-18 18:23:47 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-144

    Summary:
      fsuid/fsgid related chages
    Revision:
      glusterfs--mainline--2.5--patch-144


    modified files:
     xlators/storage/posix/src/posix.c


2007-06-18 16:39:59 GMT	Anand V. Avati <avati@80x25.org>	patch-143

    Summary:
      call inode_unlink for unlnk and rmdir cases in fuse
    Revision:
      glusterfs--mainline--2.5--patch-143


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-06-18 17:41:48 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-142

    Summary:
      posix uses locks while performing setfsuid/setfsgid
    Revision:
      glusterfs--mainline--2.5--patch-142


    modified files:
     libglusterfs/src/glusterfs.h xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2007-06-18 15:41:12 GMT	Anand V. Avati <avati@80x25.org>	patch-141

    Summary:
      fix in rename in inode.c and fuse-bridge.c
    Revision:
      glusterfs--mainline--2.5--patch-141


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c


2007-06-18 16:56:58 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-140

    Summary:
      undoing patch-138 and 139 which were causing build breaks
    Revision:
      glusterfs--mainline--2.5--patch-140

    Keywords: 
    

    modified files:
     libglusterfs/src/glusterfs.h xlators/storage/posix/src/posix.c


2007-06-18 13:56:02 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-139

    Summary:
      moved mutex initializations to posix
    Revision:
      glusterfs--mainline--2.5--patch-139


    modified files:
     glusterfsd/src/glusterfsd.c xlators/storage/posix/src/posix.c


2007-06-18 13:20:46 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-138

    Summary:
      perform fssetuid/fssetgid operations while holding locks. fssetuid/fssetgid are not needed while performing fops on fds
    Revision:
      glusterfs--mainline--2.5--patch-138

    
    

    modified files:
     glusterfsd/src/glusterfsd.c libglusterfs/src/glusterfs.h
     xlators/storage/posix/src/posix.c


2007-06-18 10:45:18 GMT	Anand V. Avati <avati@80x25.org>	patch-137

    Summary:
      inode.c fixes in forget
    Revision:
      glusterfs--mainline--2.5--patch-137


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/inode.c
     xlators/performance/write-behind/src/write-behind.c


2007-06-18 09:35:16 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-136

    Summary:
      setfsuid/setfsgid related changes to posix
    Revision:
      glusterfs--mainline--2.5--patch-136


    modified files:
     xlators/storage/posix/src/posix.c


2007-06-18 01:06:47 GMT	Anand V. Avati <avati@80x25.org>	patch-135

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-135

    write-behind: fixed data_from_ptr to data_from_static_ptr

    modified files:
     xlators/performance/write-behind/src/write-behind.c


2007-06-17 23:49:19 GMT	Anand V. Avati <avati@80x25.org>	patch-134

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-134

    fixes in write-behind about looping on inode's fds

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     xlators/performance/write-behind/src/write-behind.c


2007-06-17 21:04:10 GMT	Anand V. Avati <avati@80x25.org>	patch-133

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-133

    mem leak fixes in protocol/server - opendir_cbk, open_cbk, create_cbk

    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-17 20:46:58 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-132

    Summary:
      * saakashTu bEdi nittide
    Revision:
      glusterfs--mainline--2.5--patch-132

    
    

    modified files:
     xlators/protocol/server/src/server-protocol.c


2007-06-17 20:40:17 GMT	Anand V. Avati <avati@80x25.org>	patch-131

    Summary:
      mem leak fixes
    Revision:
      glusterfs--mainline--2.5--patch-131


    modified files:
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-17 20:02:08 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-130

    Summary:
      * client mattu server eraDu sikkapaTTe hEltive.
    Revision:
      glusterfs--mainline--2.5--patch-130


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     xlators/performance/io-cache/src/page.c


2007-06-17 17:45:35 GMT	Anand V. Avati <avati@80x25.org>	patch-129

    Summary:
      removed queue limit for reply queue in io-threads
    Revision:
      glusterfs--mainline--2.5--patch-129


    modified files:
     xlators/performance/io-threads/src/io-threads.c


2007-06-17 17:34:18 GMT	Vikas Gorur <vikas@80x25.org>	patch-128

    Summary:
      disabled building of user-guide and hacker-guide
    Revision:
      glusterfs--mainline--2.5--patch-128

    
    

    modified files:
     configure.ac doc/Makefile.am


2007-06-17 16:58:31 GMT	Amar Tumballi <amar@80x25.org>	patch-127

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-127

    * stripe_create() and stripe_open() uses 'xattr' feature for maintaining 
         information about stripe-size, stripe-count, stripe-index.
    
    * uncommented 'afr' from xlators/cluster/Makefile.am
    
    * little more enhancement in getxattr() of client/server protocol.
    
    * minor bug fixes.

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/defaults.c
     xlators/cluster/Makefile.am
     xlators/cluster/stripe/src/stripe.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-17 15:21:54 GMT	Anand V. Avati <avati@80x25.org>	patch-126

    Summary:
      proactive reconnection 
    Revision:
      glusterfs--mainline--2.5--patch-126

    attempts reconnect after every time T where Ti = Fib(i), i is the reconnection attempt since latest disconnection.

    modified files:
     libglusterfs/src/transport.c libglusterfs/src/xlator.c
     transport/tcp/client/src/tcp-client.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h


2007-06-17 13:53:44 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-125

    Summary:
      Fine tuning of client Bailing out logic
    Revision:
      glusterfs--mainline--2.5--patch-125


    modified files:
     libglusterfs/src/timer.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h


2007-06-17 16:08:23 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-124

    Summary:
      afr self-heal works somewhat. But still needs loads of testing. I see few segfaults here and there. 
    Revision:
      glusterfs--mainline--2.5--patch-124


    modified files:
     doc/examples/cluster-client.vol xlators/cluster/afr/src/afr.c


2007-06-17 14:32:27 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-123

    Summary:
      fuse-bridge.c - release() should do FUSE_FOP, not FUSE_FOP_NOREPLY | afr.c - chages for selfheal | client-protocol.c - bug fix in client_create_cbk | posix.c - bug fix in posix_getxattr() it had a race condition problem
    Revision:
      glusterfs--mainline--2.5--patch-123


    modified files:
     glusterfs-fuse/src/fuse-bridge.c xlators/cluster/afr/src/afr.c
     xlators/protocol/client/src/client-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-16 18:05:05 GMT	Vikas Gorur <vikas@80x25.org>	patch-122

    Summary:
      fixed doc/user-guide/Makefile.am
    Revision:
      glusterfs--mainline--2.5--patch-122

    
    

    modified files:
     doc/user-guide/Makefile.am


2007-06-16 17:19:39 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-121

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-121


    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-06-16 14:17:02 GMT	Anand V. Avati <avati@80x25.org>	patch-120

    Summary:
      reconnection logic fixes
    Revision:
      glusterfs--mainline--2.5--patch-120


    modified files:
     Makefile.am configure.ac
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/tcp/client/src/tcp-client.c
     xlators/protocol/client/src/client-protocol.c


2007-06-16 13:40:19 GMT	Amar Tumballi <amar@80x25.org>	patch-119

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-119

    * libglusterfs/src/dict:
      - added free(*fill) in dict_unserialize.
    
    * xlators/storage/posix:
      - fixed getxattr in case of return -1, 0.
    
    * xlators/cluster/stripe:
      - fixed a bug in write.
      - small fixes
    
    * xlators/cluster/unify:
      - changed return value to 0 from -1, in case of EBADFD.

    modified files:
     libglusterfs/src/dict.c xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-06-17 05:38:27 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-118

    Summary:
      Intermediate checkin. also a small fix in client_getxattr_cbk
    Revision:
      glusterfs--mainline--2.5--patch-118


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h
     xlators/protocol/client/src/client-protocol.c


2007-06-16 04:20:04 GMT	Vikas Gorur <vikas@80x25.org>	patch-117

    Summary:
      added user-guide/ and hacker-guide/ to doc/
    Revision:
      glusterfs--mainline--2.5--patch-117

    
    

    new files:
     doc/hacker-guide/.arch-ids/=id
     doc/hacker-guide/.arch-ids/Makefile.am.id
     doc/hacker-guide/.arch-ids/hacker-guide.tex.id
     doc/hacker-guide/Makefile.am doc/hacker-guide/hacker-guide.tex
     doc/user-guide/.arch-ids/=id
     doc/user-guide/.arch-ids/Makefile.am.id
     doc/user-guide/.arch-ids/colonO-icon.jpg.id
     doc/user-guide/.arch-ids/user-guide.tex.id
     doc/user-guide/Makefile.am doc/user-guide/colonO-icon.jpg
     doc/user-guide/user-guide.tex

    modified files:
     doc/Makefile.am

    new directories:
     doc/hacker-guide doc/hacker-guide/.arch-ids doc/user-guide
     doc/user-guide/.arch-ids


2007-06-16 00:56:05 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-116

    Summary:
      * cache_validate quequeing implemented
    Revision:
      glusterfs--mainline--2.5--patch-116


    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c


2007-06-15 23:00:59 GMT	Anand V. Avati <avati@80x25.org>	patch-115

    Summary:
      reconnection logic fixes in progress, handshake moved to transport
    Revision:
      glusterfs--mainline--2.5--patch-115


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/epoll.c
     libglusterfs/src/poll.c libglusterfs/src/transport.c
     libglusterfs/src/transport.h
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-sdp/ib-sdp.c transport/ib-sdp/ib-sdp.h
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c
     transport/ib-verbs/server/src/ib-verbs-server.c
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/src/tcp-server.c transport/tcp/tcp.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/src/server-protocol.c


2007-06-15 22:31:44 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-114

    Summary:
      * fixed memory leak in io-cache
         * fixed memory leak in protocol/server
    Revision:
      glusterfs--mainline--2.5--patch-114


    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c


2007-06-15 22:13:45 GMT	Amar Tumballi <amar@80x25.org>	patch-113

    Summary:
      notify ()
    Revision:
      glusterfs--mainline--2.5--patch-113

    * xlators/cluster/unify:
    * xlators/cluster/stripe:
    * xlators/storage/posix:
      - added 'notify()'
    
    
    * ----
      - some changes in inode structuring
         > removed 's_h_required' flag from inode_t, added 'generation'.
         > using 'generation' flag in unify for self-heal instead of s_h_required.
    
    * xlators/cluster/stripe:
      - added code to return 'UNWIND(-1, EIO)' if first child is down in many cases.
    
    
    

    modified files:
     libglusterfs/src/inode.h xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/storage/posix/src/posix.c


2007-06-15 19:04:48 GMT	Amar Tumballi <amar@80x25.org>	patch-112

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-112

    * fixed bug in xlators/protocol/*, setxattr() and getxattr (). Works smoothly.

    modified files:
     configure.ac xlators/features/filter/src/filter.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-15 17:34:09 GMT	Vikas Gorur <vikas@80x25.org>	patch-111

    Summary:
      fixed a couple of bugs in posix-locks
    Revision:
      glusterfs--mainline--2.5--patch-111

    
    

    modified files:
     configure.ac doc/Makefile.am
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/posix-locks/src/posix-locks.h


2007-06-15 17:16:20 GMT	Amar Tumballi <amar@80x25.org>	patch-110

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-110

    * libglusterfs/src/*:
    * xlators/cluster/stripe:
    * xlators/cluster/unify:
    * xlators/protocol:
    * xlators/storage/posix:
    * xlators/debug/trace:
      - changes related to xattr.
          > Removed fops->listxattr(). 
          > Changed argument to 'dict_t' for key:value.
    
    * xlators/cluster/unify:
      - Enhanced self_heal.
      - Bug fixes in readdir_cbk(). Added code to get inode number from namespace.
      - corrected lookup() for revalidate.
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/glusterfs.h
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c xlators/features/Makefile.am
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-15 03:23:40 GMT	Anand V. Avati <avati@80x25.org>	patch-109

    Summary:
      inode_update api update
    Revision:
      glusterfs--mainline--2.5--patch-109


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     libglusterfs/src/inode.h xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-15 02:48:39 GMT	Anand V. Avati <avati@80x25.org>	patch-108

    Summary:
      writev/readv changes
    Revision:
      glusterfs--mainline--2.5--patch-108

    
    

    modified files:
     libglusterfs/src/xlator.c xlators/cluster/unify/src/unify.c
     xlators/encryption/rot-13/src/rot-13.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/write-behind/src/write-behind.c


2007-06-15 01:55:19 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-107

    Summary:
      * added struct stat * as last argument of writev_cbk
    Revision:
      glusterfs--mainline--2.5--patch-107


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/inode.c libglusterfs/src/xlator.h
     xlators/debug/trace/src/trace.c
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-15 00:25:44 GMT	Anand V. Avati <avati@80x25.org>	patch-106

    Summary:
      event notify framework
    Revision:
      glusterfs--mainline--2.5--patch-106


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/glusterfs.h
     libglusterfs/src/logging.c libglusterfs/src/transport.c
     libglusterfs/src/transport.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-sdp/ib-sdp.h
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c transport/ib-verbs/ib-verbs.h
     transport/ib-verbs/server/src/ib-verbs-server.c
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/src/tcp-server.c transport/tcp/tcp.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-14 22:22:00 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-105

    Summary:
      * FIXED FIXMEs, sometimes required, sometimes not required in read-ahead
    Revision:
      glusterfs--mainline--2.5--patch-105


    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/read-ahead/src/read-ahead.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-14 18:30:30 GMT	Vikas Gorur <vikas@80x25.org>	patch-104

    Summary:
      ported posix-locks from the inode_t to loc_t interface
    Revision:
      glusterfs--mainline--2.5--patch-104

    
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2007-06-14 18:21:49 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-103

    Summary:
      * fixed io-cache build errors
    Revision:
      glusterfs--mainline--2.5--patch-103

    
    

    modified files:
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/page.c


2007-06-14 17:05:48 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-102

    Summary:
      * added io-cache translator source
    Revision:
      glusterfs--mainline--2.5--patch-102


    new files:
     xlators/performance/io-cache/.arch-ids/=id
     xlators/performance/io-cache/.arch-ids/Makefile.am.id
     xlators/performance/io-cache/Makefile.am
     xlators/performance/io-cache/src/.arch-ids/=id
     xlators/performance/io-cache/src/.arch-ids/Makefile.am.id
     xlators/performance/io-cache/src/.arch-ids/io-cache.c.id
     xlators/performance/io-cache/src/.arch-ids/io-cache.h.id
     xlators/performance/io-cache/src/.arch-ids/ioc-inode.c.id
     xlators/performance/io-cache/src/.arch-ids/page.c.id
     xlators/performance/io-cache/src/Makefile.am
     xlators/performance/io-cache/src/io-cache.c
     xlators/performance/io-cache/src/io-cache.h
     xlators/performance/io-cache/src/ioc-inode.c
     xlators/performance/io-cache/src/page.c

    modified files:
     configure.ac libglusterfs/src/call-stub.c
     xlators/debug/trace/src/trace.c
     xlators/performance/Makefile.am
     xlators/performance/read-ahead/src/page.c

    new directories:
     xlators/performance/io-cache
     xlators/performance/io-cache/.arch-ids
     xlators/performance/io-cache/src
     xlators/performance/io-cache/src/.arch-ids


2007-06-14 16:48:17 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-101

    Summary:
      * changed API of readv_cbk 
    Revision:
      glusterfs--mainline--2.5--patch-101

    
    

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/defaults.c
     libglusterfs/src/xlator.h xlators/storage/posix/src/posix.c


2007-06-14 07:44:38 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-100

    Summary:
      struct timespec related changes to defaults.h posix.c filter.c which were missed in my previous commit
    Revision:
      glusterfs--mainline--2.5--patch-100

    
    

    modified files:
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/defaults.h
     xlators/features/filter/src/filter.c
     xlators/storage/posix/src/posix.c


2007-06-14 06:30:51 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-99

    Summary:
      Undoing struct timespec related changes to fop_writev, fop_truncate and fop_ftruncate
    Revision:
      glusterfs--mainline--2.5--patch-99


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/timer.c libglusterfs/src/xlator.h
     transport/tcp/tcp.c xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/encryption/rot-13/src/rot-13.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-14 05:24:12 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-98

    Summary:
      undoing patch-95
    Revision:
      glusterfs--mainline--2.5--patch-98

    
    

    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-06-13 21:02:57 GMT	Amar Tumballi <amar@80x25.org>	patch-97

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-97

    * libglusterfs/src/*:
      - edited the licence.. added year 2007 in (C)
    
    * xlators/cluster/unify:
      - more correctness.
      - added O_EXCL feature for create.
    

    modified files:
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/common-utils.c
     libglusterfs/src/common-utils.h libglusterfs/src/dict.c
     libglusterfs/src/lock.c libglusterfs/src/logging.c
     libglusterfs/src/scheduler.c libglusterfs/src/spec.y
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h
     transport/tcp/client/src/tcp-client.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c


2007-06-13 15:45:49 GMT	Amar Tumballi <amar@80x25.org>	patch-96

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-96

    * libglusterfs/src/*:
      - fixes in output of 'gf_log'
    
    * xlators/cluster/unify:
    * xlators/storage/posix:
      - bug fix with new changes done for 'struct timespec' in truncate,
        ftruncate, writev as arguments.

    modified files:
     libglusterfs/src/dict.c libglusterfs/src/lock.c
     libglusterfs/src/protocol.c libglusterfs/src/scheduler.c
     libglusterfs/src/spec.y libglusterfs/src/xlator.c
     xlators/cluster/unify/src/unify.c
     xlators/storage/posix/src/posix.c


2007-06-13 13:44:12 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-95

    Summary:
      added data_from_int64 to dict_set in writev, truncate and ftruncate in client-protocol.c
    Revision:
      glusterfs--mainline--2.5--patch-95


    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-06-13 09:31:28 GMT	Amar Tumballi <amar@80x25.org>	patch-93

    Summary:
      client-protocol
    Revision:
      glusterfs--mainline--2.5--patch-93

    * xlators/protocol/client-protocol:
      - fixed a bug in client-protocol-cleanup.

    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-06-12 14:06:08 GMT	Amar Tumballi <amar@80x25.org>	patch-92

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-92

    * xlators/debug/trace:
    * xlators/protocol/client:
    * xlators/protocol/server:
      - added 'writedir' fop.
    
    * xlators/src/posix:
      - enhancement to 'writedir' fop.
    
    * xlators/cluster/unify:
      - self-heal working properly. 
      - yet to implement 'notify ()', waiting for the patch from kr1s/avati.
    
    * schedulers/*:
      - changed 'min-free-disk' option from free space to free-space percent.
        -> ie, it got changed from 'option x.limits.min-free-disk 5GB' to 
                                   'option x.limits.min-free-disk 5 #%'
    
    * libglusterfs/src/:
      - changes done to remove the warning.

    modified files:
     libglusterfs/src/defaults.h libglusterfs/src/dict.c
     libglusterfs/src/xlator.h scheduler/alu/src/alu.c
     scheduler/nufa/src/nufa.c scheduler/random/src/random.c
     scheduler/rr/src/rr.c xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify-self-heal.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c xlators/features/Makefile.am
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-12 13:21:14 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-91

    Summary:
      Added "struct timespec tv[2]" parameter to fop_writev, fop_truncate, fop_ftruncate
    Revision:
      glusterfs--mainline--2.5--patch-91


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/call-stub.h libglusterfs/src/defaults.c
     libglusterfs/src/xlator.h xlators/cluster/Makefile.am
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/encryption/rot-13/src/rot-13.c
     xlators/features/filter/src/filter.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-06-12 01:14:06 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-90

    Summary:
      An intermediate checkin. Just in case I lose my local repository. Also fixing a bug in client-protocol, inode_update should not happen when lookup_cbk returns -1
    Revision:
      glusterfs--mainline--2.5--patch-90


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h
     xlators/protocol/client/src/client-protocol.c


2007-06-08 14:15:16 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-89

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-89

    
    

    modified files:
     glusterfs-fuse/src/glusterfs-fuse.h
     libglusterfs/src/glusterfs.h
     xlators/features/filter/src/filter.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/performance/Makefile.am
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/server/src/server-protocol.h


2007-06-09 02:17:36 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-88

    Summary:
      Intermediate checking, incase i lose my local copy.
    Revision:
      glusterfs--mainline--2.5--patch-88


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-06-08 04:15:13 GMT	Amar Tumballi <amar@80x25.org>	patch-87

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-87

    * xlators/features/trash:
      - not yet ready for usage.
      - basic changes for new API changes done.
    
    * xlators/cluster/stripe:
      - Bug fixes.
      - Code cleanup.
    
    * libglusterfs/src/common-utils.h:
      - changed 'roof' and 'floor' macros to handle divide by 0 error.
    
    * configure.ac:
      - changed version from 1.3-STABLE to 1.3.0-pre5

    modified files:
     configure.ac libglusterfs/src/common-utils.h
     xlators/cluster/stripe/src/stripe.c
     xlators/features/Makefile.am
     xlators/features/trash/src/trash.c


2007-06-07 15:52:01 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-86

    Summary:
      * changed call_resume (call_stub_t *, void *) to call_resume (call_stub_t *)
    Revision:
      glusterfs--mainline--2.5--patch-86

    
    

    modified files:
     libglusterfs/src/call-stub.c libglusterfs/src/call-stub.h
     xlators/protocol/server/src/server-protocol.c


2007-06-06 16:14:11 GMT	Amar Tumballi <amar@80x25.org>	patch-85

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-85

    * libglusterfs/src/defaults.{c,h}:
    * libglusterfs/src/xlator.{c,h}:
    * libglusterfs/src/glusterfs.h:
    * xlators/storage/posix:
      - added fop 'writedir'
    
    * xlators/cluster/stripe:
      - removed warnings.
    
    * xlators/cluster/unify:
      - added self-heal functionality.
      - clean up and more comments.

    new files:
     xlators/cluster/unify/src/.arch-ids/unify-self-heal.c.id
     xlators/cluster/unify/src/unify-self-heal.c

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/call-stub.c
     libglusterfs/src/defaults.c libglusterfs/src/defaults.h
     libglusterfs/src/glusterfs.h libglusterfs/src/inode.h
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/Makefile.am
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/storage/posix/src/posix.c


2007-06-05 20:03:41 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-84

    Summary:
      * protocol inode_ref & inode_unref fixed
         * server memory leak fixed
    Revision:
      glusterfs--mainline--2.5--patch-84


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-05 13:59:37 GMT	Amar Tumballi <amar@80x25.org>	patch-83

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-83

    * libglusterfs/src/timer.c:
      - patch by Anand V. Avati

    modified files:
     libglusterfs/src/timer.c


2007-06-04 13:15:33 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-82

    Summary:
      * during initialisation, return value was not handled
    Revision:
      glusterfs--mainline--2.5--patch-82

    
    

    modified files:
     glusterfsd/src/glusterfsd.c


2007-06-04 10:31:40 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-81

    Summary:
      
	* protocol
    Revision:
      glusterfs--mainline--2.5--patch-81


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-06-03 06:28:43 GMT	Amar Tumballi <amar@80x25.org>	patch-80

    Summary:
      unify
    Revision:
      glusterfs--mainline--2.5--patch-80

    * xlators/cluster/unify:
      - changed code according to review.
      - readdir* code changes pending.

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2007-06-02 13:42:00 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-79

    Summary:
      * cleaned up protocol source code
    Revision:
      glusterfs--mainline--2.5--patch-79


    modified files:
     libglusterfs/src/call-stub.h
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-06-01 23:34:48 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-78

    Summary:
      Another intermediate check in, comments have to be added, FIXMEs have to be fixed, and inode_unrefs should be done at correct places (inode_unref is not at all being done now)
    Revision:
      glusterfs--mainline--2.5--patch-78


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-05-31 20:46:38 GMT	Amar Tumballi <amar@80x25.org>	patch-77

    Summary:
      unify _almost_ complete. 
    Revision:
      glusterfs--mainline--2.5--patch-77

    * libglusterfs/src/dict:
      - added a function 'data_from_static_ptr ()'
    
    * xlators/cluster/unify:
      - removed warnings.
      - rename fixed.
      - all inode_ref/unref related errors fixed.
      - memory leaks fixed.

    modified files:
     libglusterfs/src/dict.c libglusterfs/src/dict.h
     xlators/cluster/unify/src/unify.c


2007-05-31 15:16:39 GMT	Amar Tumballi <amar@80x25.org>	patch-76

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-76

    * xlators/cluster/unify: 
      - minor bug fixes.
    
    * xlators/debug/trace:
      - changed to '%lld' type for all the offset variables.
    
    * xlators/performance/Makefile.am && xlators/features/Makefile.am:
      - removed compilation of trash, io-threads, posix-locks, stat-prefetch, 
        so just 'make ' will work fine on glusterfs tree :D
      - once these xlators are ready, enable them.
    

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c xlators/features/Makefile.am
     xlators/performance/Makefile.am
     xlators/storage/posix/src/posix.c


2007-05-30 14:40:21 GMT	Raghavendra G <raghavendra@sv.gnu.org>	patch-75

    Summary:
      inode related changes to read-ahead, write-behind, filter, fixed-id
    Revision:
      glusterfs--mainline--2.5--patch-75

    
    

    modified files:
     xlators/features/filter/src/filter.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/read-ahead/src/read-ahead.h
     xlators/performance/write-behind/src/write-behind.c


2007-05-30 08:44:12 GMT	Anand V. Avati <avati@80x25.org>	patch-74

    Summary:
      fixed rot-13 xlator to use new API
    Revision:
      glusterfs--mainline--2.5--patch-74


    modified files:
     xlators/encryption/rot-13/src/rot-13.c


2007-05-30 05:59:32 GMT	Amar Tumballi <amar@80x25.org>	patch-73

    Summary:
      stripe 
    Revision:
      glusterfs--mainline--2.5--patch-73

    * xlators/cluster/stripe:
      - fixed issues with inode-ref/unref. Now follows how its done in posix.

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c


2007-05-29 18:56:32 GMT	Amar Tumballi <amar@80x25.org>	patch-72

    Summary:
      unify works :-)
    Revision:
      glusterfs--mainline--2.5--patch-72

    * xlators/cluster/unify:
      - other than 'rename' all calls work.
      - followed posix to ref, unref inodes.
      - observing some memory leaks.. need to fix.
    
    * xlators/cluster/stripe:
      - if there is pattern miss match, file will be created only in FIRST_CHILD.
      - more testing needed.
      - yet to complete setxattr/getxattr feature for block-size, order of creation etc.
    
    * xlators/debug/trace:
      - removed 'option debug on' option.
    
    * xlators/storage/posix:
      - added 'inode_unref ()' in case of fops->link.

    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c
     xlators/storage/posix/src/posix.c


2007-05-29 15:13:03 GMT	Anand V. Avati <avati@80x25.org>	patch-71

    Summary:
      fixes in fuse
    Revision:
      glusterfs--mainline--2.5--patch-71


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-05-28 16:02:16 GMT	Amar Tumballi <amar@80x25.org>	patch-70

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-70

    * xlators/cluster/stripe:
      - Still need to finish tasks related to un-striped file.
     

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     xlators/cluster/stripe/src/stripe.c


2007-05-29 07:45:18 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-69

    Summary:
      * client protocol does not use frame->local
    Revision:
      glusterfs--mainline--2.5--patch-69


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-05-29 03:42:33 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-68

    Summary:
      * read/write works through protocol
    Revision:
      glusterfs--mainline--2.5--patch-68


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-05-29 01:03:27 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-67

    Summary:
      * protocol
         * client protocol segfaults. REASON: frame->local points to a local structure and the local structure contents are gettting corrupted.
    Revision:
      glusterfs--mainline--2.5--patch-67


    modified files:
     libglusterfs/src/timer.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/src/server-protocol.c


2007-05-28 07:41:19 GMT	Amar Tumballi <amar@80x25.org>	patch-66

    Summary:
      coding complete for unify/stripe. Testing pending.
    Revision:
      glusterfs--mainline--2.5--patch-66

    * libglusterfs/src/inode.h:
      - added a field 'isdir' which is used by UNIFY.
    
    * xlators/cluster/stripe:
      - basic commands 'ls' open, writev works.
      - more comments to be added.
    
    * xlators/cluster/unify:
      - using 'isdir' whereever required.
      - testing pending.

    modified files:
     libglusterfs/src/inode.h xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c


2007-05-26 21:13:32 GMT	Amar Tumballi <amar@80x25.org>	patch-65

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-65

    * xlators/cluster/unify:
      - fops complete. more comments needed.
      - testing in progress... some segfaults has to be fixed.

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2007-05-26 20:12:19 GMT	Amar Tumballi <amar@80x25.org>	patch-64

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-64

    * xlators/cluster/unify:
      - most of the fops complete. Testing in progress.
    

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c
     xlators/storage/posix/src/posix.c


2007-05-27 05:35:19 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-63

    Summary:
      * Server procotol changes to comply with loc_t based fops
         * directory related fops work
    Revision:
      glusterfs--mainline--2.5--patch-63


    modified files:
     glusterfsd/src/glusterfsd.c libglusterfs/src/call-stub.c
     xlators/debug/trace/src/trace.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/storage/posix/src/posix.c


2007-05-26 03:09:49 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-62

    Summary:
      AFR with inode changes, the file compiles. Need to make code pretty, need to test, fix bugs and checkin again. This checkin is being done just in case i delete my loca copy :P
    Revision:
      glusterfs--mainline--2.5--patch-62


    modified files:
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h


2007-05-24 22:19:19 GMT	Amar Tumballi <amar@80x25.org>	patch-61

    Summary:
      unify - intermediate commit.
    Revision:
      glusterfs--mainline--2.5--patch-61

    * xlators/cluster/unify:
      - lot of _cbk functions are pending.
      - NOT TESTED - NO WARRANTY TO WORK :|

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h


2007-05-24 20:54:58 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-60

    Summary:
      * Added call-stub.h
         * Added call-stub implementation to server protocol
    Revision:
      glusterfs--mainline--2.5--patch-60


    new files:
     libglusterfs/src/.arch-ids/call-stub.h.id
     libglusterfs/src/call-stub.h

    modified files:
     libglusterfs/src/call-stub.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h


2007-05-24 13:29:52 GMT	Anand V. Avati <avati@80x25.org>	patch-59

    Summary:
      fixes in inode.c to update lru_size correctly
    Revision:
      glusterfs--mainline--2.5--patch-59


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c


2007-05-24 12:56:14 GMT	Anand V. Avati <avati@80x25.org>	patch-58

    Summary:
      fuse + posix really working :)
    Revision:
      glusterfs--mainline--2.5--patch-58


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     libglusterfs/src/inode.h xlators/storage/posix/src/posix.c


2007-05-24 12:05:01 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-57

    Summary:
      * syntactical changes to protocol-server.c
    Revision:
      glusterfs--mainline--2.5--patch-57


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/server-protocol.c


2007-05-24 11:14:53 GMT	Amar Tumballi <amar@80x25.org>	patch-56

    Summary:
      stripe - basic functionalities complete.
    Revision:
      glusterfs--mainline--2.5--patch-56

    * xlators/cluster/stripe:
      - completed all the FOPS.
      - testing pending.
      - few TODOs left. discuss and fix them.
    

    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-05-24 06:31:24 GMT	Anand V. Avati <avati@80x25.org>	patch-55

    Summary:
      fuse + posix working
    Revision:
      glusterfs--mainline--2.5--patch-55



2007-05-23 10:07:14 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-54

    Summary:
      * Renamed protocol server souce files to server-protocol.[ch].
	 * Removed ns.[ch] from protocol server source directory.
    Revision:
      glusterfs--mainline--2.5--patch-54


    removed files:
     xlators/protocol/server/src/.arch-ids/ns.c.id
     xlators/protocol/server/src/.arch-ids/ns.h.id
     xlators/protocol/server/src/ns.c
     xlators/protocol/server/src/ns.h

    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/Makefile.am
     xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/server-protocol.h

    renamed files:
     xlators/protocol/server/src/.arch-ids/proto-srv.c.id
       ==> xlators/protocol/server/src/.arch-ids/server-protocol.c.id
     xlators/protocol/server/src/.arch-ids/proto-srv.h.id
       ==> xlators/protocol/server/src/.arch-ids/server-protocol.h.id
     xlators/protocol/server/src/proto-srv.c
       ==> xlators/protocol/server/src/server-protocol.c
     xlators/protocol/server/src/proto-srv.h
       ==> xlators/protocol/server/src/server-protocol.h


2007-05-23 07:49:31 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-53

    Summary:
      Added lookup and forget calls to client protocol
    Revision:
      glusterfs--mainline--2.5--patch-53


    modified files:
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h


2007-05-23 06:29:40 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-52

    Summary:
      inode migration changes to client protocol
    Revision:
      glusterfs--mainline--2.5--patch-52

    
    

    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-05-22 13:07:58 GMT	Anand V. Avati <avati@80x25.org>	patch-51

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-51

    call-stub.c - apis to create a stub for a call which can be later resumed with
    stack.h - typechecking for return function during STACK_WIND
    common-utils.h - moved memdup() from dict.c
    glusterfs-fuse - rewrite to loc_t based api

    new files:
     libglusterfs/src/.arch-ids/call-stub.c.id
     libglusterfs/src/call-stub.c

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/Makefile.am
     libglusterfs/src/common-utils.h libglusterfs/src/dict.c
     libglusterfs/src/stack.h libglusterfs/src/xlator.h


2007-05-21 20:39:10 GMT	Amar Tumballi <amar@80x25.org>	patch-50

    Summary:
      intermediate commit
    Revision:
      glusterfs--mainline--2.5--patch-50

    * libglusterfs/src/defaults.c:
    * xlators/debug/trace:
      - changed to latest API. Complete.
      
    * xlators/cluster/stripe:
      - changed to latest API. Few functions implemented.
     
    * xlators/cluster/unify:
      - changed to latest API.
    

    modified files:
     doc/examples/cluster-client.vol libglusterfs/src/defaults.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c


2007-05-21 14:43:43 GMT	Anand V. Avati <avati@80x25.org>	patch-49

    Summary:
      defined types for fops
    Revision:
      glusterfs--mainline--2.5--patch-49


    modified files:
     libglusterfs/src/xlator.h


2007-05-21 09:13:10 GMT	Amar Tumballi <amar@80x25.org>	patch-48

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-48

    * libglusterfs/src:
      - xlator.h : removed extra definition of 'struct _loc'
      - xlator.c : modified default functions to 'stat', 'fstat', 'close' and 'closedir'
      - defaults.{h,c} : changes according to new xlator API.
    
    -- libglusterfs compiles without errors --

    modified files:
     libglusterfs/src/defaults.c libglusterfs/src/defaults.h
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h


2007-05-21 07:13:12 GMT	Anand V. Avati <avati@80x25.org>	patch-47

    Summary:
      futher api changes in xlator.h
    Revision:
      glusterfs--mainline--2.5--patch-47

    inode.c/h commments and enhancements

    modified files:
     libglusterfs/src/glusterfs.h libglusterfs/src/inode.c
     libglusterfs/src/inode.h libglusterfs/src/xlator.h


2007-05-21 01:15:29 GMT	Amar Tumballi <amar@80x25.org>	patch-46

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-46

    * libglusterfs/src/xlator.h:
      - minor change (from inode_t * to struct _inode *, for compiling reasons)
    
    * xlators/debug/trace:
      - All functions complete. Compiles. Review needed.
    
    * xlators/cluster/unify:
      - fops/mops APIs changed to new xlator API. No body yet :|
    
    

    modified files:
     libglusterfs/src/xlator.h xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c


2007-05-20 13:58:38 GMT	Anand V. Avati <avati@80x25.org>	patch-45

    Summary:
      updated location based xlator.h APIs
    Revision:
      glusterfs--mainline--2.5--patch-45


    modified files:
     libglusterfs/src/xlator.h


2007-05-19 23:04:02 GMT	Anand V. Avati <avati@80x25.org>	patch-44

    Summary:
      fixes in glusterfs-fuse (mem leaks and segfaults)
    Revision:
      glusterfs--mainline--2.5--patch-44


    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/inode.c
     libglusterfs/src/inode.h xlators/storage/posix/src/posix.c


2007-05-19 18:12:50 GMT	Amar Tumballi <amar@80x25.org>	patch-43

    Summary:
      unify 'stat' 'mkdir' working.
    Revision:
      glusterfs--mainline--2.5--patch-43

    * xlators/cluster/unify:
      - some improvements. lookup, forget, getattr, mkdir, chmod working fine.
    
    * xlators/debug/trace:
      - more enhance to the trace.

    modified files:
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c


2007-05-19 13:43:47 GMT	Amar Tumballi <amar@80x25.org>	patch-42

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-42

    * scheduler/*:
      - minor changes to all the scheduler to compile with new changes.
    
    * xlators/cluster/stripe:
      - started fop changes
    
    * xlators/cluster/unify:
      - few more functions added. lookup, forget, mkdir, getattr, chmod etc are completed.
    
    * xlators/debug/trace:
      - formatting, and few more compile error fixes.

    modified files:
     scheduler/alu/src/alu.c scheduler/alu/src/alu.h
     scheduler/nufa/src/nufa.c scheduler/random/src/random.c
     scheduler/random/src/random.h scheduler/rr/src/rr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c


2007-05-19 10:57:41 GMT	Anand V. Avati <avati@80x25.org>	patch-41

    Summary:
      glusterfs-fuse all fops implemented, bug fixes in storage/posix
    Revision:
      glusterfs--mainline--2.5--patch-41


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/xlator.h
     xlators/storage/posix/src/posix.c


2007-05-19 07:43:25 GMT	Anand V. Avati <avati@80x25.org>	patch-40

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-40

    xlator.c: set default fops - lookup, missing, fchown, fchmod
    glusterfs-fuse: implemented chmod/fchmod chown/fchown truncate/ftruncate utimens

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/xlator.c


2007-05-19 07:18:16 GMT	Vikas Gorur <vikas@80x25.org>	patch-39

    Summary:
      modified posix-locks to use the new inode api
    Revision:
      glusterfs--mainline--2.5--patch-39

    configure.ac: changed version string to 1.3-STABLE
    posix-locks.[ch]: use the new inode api
    

    modified files:
     configure.ac libglusterfs/src/inode.h
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/posix-locks/src/posix-locks.h


2007-05-19 06:41:50 GMT	Amar Tumballi <amar@80x25.org>	patch-38

    Summary:
      intermediate commit
    Revision:
      glusterfs--mainline--2.5--patch-38

    * libglusterfs/src/glusterfs.h:
      - corrected GF_FOP* and GF_MOP* enums
    
    * xlators/debug/trace:
      - changed first argument to gf_log () from "trace" to 'this->name'
    
    * xlators/cluster/unify:
      - code not usable yet. lot more rewrite needed.

    modified files:
     libglusterfs/src/glusterfs.h xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h
     xlators/debug/trace/src/trace.c


2007-05-19 06:27:54 GMT	Anand V. Avati <avati@80x25.org>	patch-37

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-37

    storage/posix - all fops implemented
    glusterfs-fuse - added fuse-extra.h

    new files:
     glusterfs-fuse/src/.arch-ids/fuse-extra.h.id
     glusterfs-fuse/src/fuse-extra.h

    modified files:
     configure.ac glusterfs-fuse/src/fuse-bridge.c
     glusterfsd/src/glusterfsd.c libglusterfs/src/inode.c
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h
     xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2007-05-18 17:33:20 GMT	Anand V. Avati <avati@80x25.org>	patch-36

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-36

    
    glusterfs-fuse: initialize tree bottom up
    
    libglusterfs: add 'itable' to each xlator and automatically set to lowest itable manager
    
    lookup/getattr/forget/opendir/readdir/releasedir working with fuse+posix

    modified files:
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/inode.c
     libglusterfs/src/inode.h libglusterfs/src/xlator.c
     libglusterfs/src/xlator.h xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


2007-05-18 12:07:00 GMT	Basavanagowda Kanur <gowda@zresearch.com>	patch-35

    Summary:
      Added GF_FOPS_<new-fops> for lookup, forget, fchown, fchmod in glusterfs.h 
    Revision:
      glusterfs--mainline--2.5--patch-35

    
    

    modified files:
     libglusterfs/src/glusterfs.h


2007-05-18 07:42:52 GMT	Anand V. Avati <avati@80x25.org>	patch-34

    Summary:
      updates in inode api
    Revision:
      glusterfs--mainline--2.5--patch-34


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/defaults.c
     libglusterfs/src/inode.c libglusterfs/src/inode.h
     libglusterfs/src/xlator.h xlators/debug/trace/src/trace.c
     xlators/storage/posix/src/posix.c


2007-05-17 16:26:47 GMT	Anand V. Avati <avati@80x25.org>	patch-33

    Summary:
      adding fops to fuse
    Revision:
      glusterfs--mainline--2.5--patch-33


    modified files:
     glusterfs-fuse/src/fuse-bridge.c


2007-05-17 12:31:45 GMT	Anand V. Avati <avati@80x25.org>	patch-32

    Summary:
      libglusterfs and glusterfs-fuse compilable
    Revision:
      glusterfs--mainline--2.5--patch-32


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/inode.c
     libglusterfs/src/inode.h libglusterfs/src/spec.y
     libglusterfs/src/xlator.c
     xlators/performance/read-ahead/src/page.c


2007-05-18 04:32:16 GMT	Krishna Srinivas <krishna@zresearch.com>	patch-31

    Summary:
      path -> inode related chances. comlete change for trace.c one minor change in defaults.c
    Revision:
      glusterfs--mainline--2.5--patch-31


    modified files:
     libglusterfs/src/defaults.c xlators/debug/trace/src/trace.c


2007-05-17 07:11:37 GMT	Anand V. Avati <avati@80x25.org>	patch-30

    Summary:
      inode.c and initial fuse-bridge.c commit
    Revision:
      glusterfs--mainline--2.5--patch-30


    new files:
     libglusterfs/src/.arch-ids/inode.c.id libglusterfs/src/inode.c

    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/Makefile.am
     libglusterfs/src/inode.h


2007-05-16 12:23:10 GMT	Amar Tumballi <amar@80x25.org>	patch-29

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-29

    * libglusterfs/src/xlator.h:
      - corrected the definition of readlink.
    
    * libglusterfs/src/defaults.c/h:
      - changed the prototype to match new APIs.
    

    modified files:
     libglusterfs/src/defaults.c libglusterfs/src/defaults.h
     libglusterfs/src/scheduler.h libglusterfs/src/xlator.h


2007-05-16 11:32:57 GMT	Anand V. Avati <avati@80x25.org>	patch-28

    Summary:
      fixed open() flags in xlator.h
    Revision:
      glusterfs--mainline--2.5--patch-28


    modified files:
     libglusterfs/src/xlator.h


2007-05-16 10:14:55 GMT	Anand V. Avati <avati@80x25.org>	patch-27

    Summary:
      change in rename_cbk prototype
    Revision:
      glusterfs--mainline--2.5--patch-27

    
    

    modified files:
     libglusterfs/src/xlator.h


2007-05-16 10:04:05 GMT	Anand V. Avati <avati@80x25.org>	patch-26

    Summary:
      furhter changes to fop prototypes
    Revision:
      glusterfs--mainline--2.5--patch-26


    modified files:
     glusterfs-fuse/src/fuse-bridge.c libglusterfs/src/dict.h
     libglusterfs/src/inode.h libglusterfs/src/list.h
     libglusterfs/src/logging.c libglusterfs/src/xlator.h


2007-05-15 15:39:44 GMT	Anand V. Avati <avati@80x25.org>	patch-25

    Summary:
      change in fop callback prototype to use stat instead of inode
    Revision:
      glusterfs--mainline--2.5--patch-25


    modified files:
     libglusterfs/src/xlator.h


2007-05-15 12:04:25 GMT	Anand V. Avati <avati@80x25.org>	patch-24

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-24

    added prototypes in inode.h and list management in list.h

    new files:
     libglusterfs/src/.arch-ids/inode.h.id
     libglusterfs/src/.arch-ids/list.h.id libglusterfs/src/inode.h
     libglusterfs/src/list.h

    modified files:
     libglusterfs/src/Makefile.am


2007-05-15 11:50:04 GMT	Anand V. Avati <avati@80x25.org>	patch-23

    Summary:
      build br34k4g3 :D
    Revision:
      glusterfs--mainline--2.5--patch-23


    new files:
     glusterfs-fuse/src/.arch-ids/fuse-extra.c.id
     glusterfs-fuse/src/fuse-extra.c

    removed files:
     libglusterfs/src/.arch-ids/layout.c.id
     libglusterfs/src/.arch-ids/layout.h.id
     libglusterfs/src/.arch-ids/loc_hint.c.id
     libglusterfs/src/.arch-ids/loc_hint.h.id
     libglusterfs/src/.arch-ids/sdp_inet.h.id
     libglusterfs/src/layout.c libglusterfs/src/layout.h
     libglusterfs/src/loc_hint.c libglusterfs/src/loc_hint.h
     libglusterfs/src/sdp_inet.h

    modified files:
     glusterfs-fuse/src/Makefile.am glusterfs-fuse/src/fetch-spec.c
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/fuse-internals.c
     glusterfs-fuse/src/fuse-internals.h
     glusterfs-fuse/src/glusterfs-fuse.h
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/Makefile.am
     libglusterfs/src/common-utils.h libglusterfs/src/epoll.c
     libglusterfs/src/glusterfs.h libglusterfs/src/logging.c
     libglusterfs/src/stack.h libglusterfs/src/xlator.h
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-sdp/ib-sdp.h
     transport/ib-sdp/server/src/ib-sdp-server.c

    renamed files:
     glusterfs-fuse/src/.arch-ids/glusterfs.h.id
       ==> glusterfs-fuse/src/.arch-ids/glusterfs-fuse.h.id
     glusterfs-fuse/src/glusterfs.h
       ==> glusterfs-fuse/src/glusterfs-fuse.h


2007-05-10 17:11:49 GMT	Anand V. Avati <avati@80x25.org>	patch-22

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-22

    
    

    modified files:
     xlators/protocol/client/src/client-protocol.c


2007-05-10 04:16:56 GMT	Basavanagowda Kanur <gowda@freeshell.in>	patch-21

    Summary:
      * Added data_to_uint<size> to replace data_to_int previously used.
         * Added data_from_<integer-types> to replace int_to_data.
         * Added data_from_ptr to replace previously used type-casted int_to_data usage.
    Revision:
      glusterfs--mainline--2.5--patch-21


    modified files:
     libglusterfs/src/dict.c libglusterfs/src/dict.h
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c
     transport/ib-verbs/server/src/ib-verbs-server.c
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/src/tcp-server.c
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/proto-srv.c
     xlators/storage/posix/src/posix.c


2007-05-10 12:44:32 GMT	Anand V. Avati <avati@80x25.org>	patch-20

    Summary:
      fwd port of patch-171 from mainline--2.4
    Revision:
      glusterfs--mainline--2.5--patch-20


    modified files:
     xlators/cluster/stripe/src/stripe.c
     xlators/performance/read-ahead/src/page.c


2007-05-09 23:04:13 GMT	Basavanagowda Kanur <gowda@freeshell.in>	patch-19

    Summary:
      * Added data_to_int64, data_to_int32, data_to_int16 in place of data_to_int
         * Changed all usage of data_to_int to relevant data_to_<integer-type>
    Revision:
      glusterfs--mainline--2.5--patch-19

    
    

    modified files:
     libglusterfs/src/dict.c libglusterfs/src/dict.h
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c
     transport/ib-verbs/server/src/ib-verbs-server.c
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/src/tcp-server.c
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/stat-prefetch/src/stat-prefetch.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/proto-srv.c
     xlators/storage/posix/src/posix.c


2007-05-10 06:30:04 GMT	Vikas Gorur <vikas@80x25.org>	patch-18

    Summary:
      do inode_dec_ref *after* everything else in posix_locks_release
    Revision:
      glusterfs--mainline--2.5--patch-18

    
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2007-05-09 18:10:53 GMT	Anand V. Avati <avati@80x25.org>	patch-17

    Summary:
      bug fix in read-ahead for read with offsets beyond end of file
    Revision:
      glusterfs--mainline--2.5--patch-17


    modified files:
     doc/examples/cluster-server1.vol
     doc/examples/cluster-server2.vol
     doc/examples/cluster-server3.vol glusterfsd/src/Makefile.am
     xlators/meta/src/meta.c
     xlators/performance/read-ahead/src/page.c


2007-05-09 04:29:08 GMT	Anand V. Avati <avati@80x25.org>	patch-16

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-16

    glusterfs-fuse: fix --volume-name logic to make it optional (use top node by default) and fix --help string

    modified files:
     glusterfs-fuse/src/glusterfs.c


2007-05-09 00:02:45 GMT	Vikas Gorur <vikas@80x25.org>	patch-15

    Summary:
      read/write works for views in meta
    Revision:
      glusterfs--mainline--2.5--patch-15

    
    

    modified files:
     xlators/meta/src/meta.c xlators/meta/src/view.c


2007-05-08 23:00:05 GMT	Vikas Gorur <vikas@80x25.org>	patch-14

    Summary:
      meta xlator views partially working
    Revision:
      glusterfs--mainline--2.5--patch-14

    meta:
     - added xlators and view, etc.
     - readdir and getattr work on views
     
    xlator.h: added 'type' field
    

    new files:
     xlators/meta/src/.arch-ids/view.c.id
     xlators/meta/src/.arch-ids/view.h.id xlators/meta/src/view.c
     xlators/meta/src/view.h

    modified files:
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h
     xlators/meta/src/Makefile.am xlators/meta/src/meta.c
     xlators/meta/src/meta.h xlators/meta/src/misc.c
     xlators/meta/src/tree.c xlators/meta/src/tree.h


2007-05-08 19:41:25 GMT	Vikas Gorur <vikas@80x25.org>	patch-13

    Summary:
      first commit of meta (/me w Lord Murphy profusely)
    Revision:
      glusterfs--mainline--2.5--patch-13

    * Only thing that works is /.meta/version
    
    configure.ac: changed version to 1.4.0
    

    new files:
     xlators/meta/.arch-ids/=id
     xlators/meta/.arch-ids/Makefile.am.id xlators/meta/Makefile.am
     xlators/meta/src/.arch-ids/=id
     xlators/meta/src/.arch-ids/Makefile.am.id
     xlators/meta/src/.arch-ids/meta.c.id
     xlators/meta/src/.arch-ids/meta.h.id
     xlators/meta/src/.arch-ids/misc.c.id
     xlators/meta/src/.arch-ids/misc.h.id
     xlators/meta/src/.arch-ids/tree.c.id
     xlators/meta/src/.arch-ids/tree.h.id
     xlators/meta/src/Makefile.am xlators/meta/src/meta.c
     xlators/meta/src/meta.h xlators/meta/src/misc.c
     xlators/meta/src/misc.h xlators/meta/src/tree.c
     xlators/meta/src/tree.h

    modified files:
     configure.ac glusterfs-fuse/src/glusterfs.c

    new directories:
     xlators/meta xlators/meta/.arch-ids xlators/meta/src
     xlators/meta/src/.arch-ids


2007-05-08 15:36:25 GMT	Anand V. Avati <avati@80x25.org>	patch-12

    Summary:
      fwd porting patch-167 from mainline--2.4
    Revision:
      glusterfs--mainline--2.5--patch-12

    
    

    modified files:
     xlators/cluster/stripe/src/stripe.c


2007-05-08 15:09:54 GMT	Anand V. Avati <avati@80x25.org>	patch-11

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-11

    front-porting fixes from mainline--2.4 (patch-166)

    modified files:
     libglusterfs/src/common-utils.h
     transport/ib-verbs/client/src/ib-verbs-client.c
     xlators/cluster/stripe/src/stripe.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/performance/read-ahead/src/read-ahead.h


2007-05-08 11:58:31 GMT	Anand V. Avati <avati@80x25.org>	patch-10

    Summary:
      non-blocking-connect on/off for -s over slow links
    Revision:
      glusterfs--mainline--2.5--patch-10


    modified files:
     glusterfs-fuse/src/fetch-spec.c
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/tcp/client/src/tcp-client.c


2007-05-07 23:27:09 GMT	Basavanagowda Kanur <gowda@freeshell.in>	patch-9

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-9

    
    

    modified files:
     glusterfs-fuse/src/glusterfs.c libglusterfs/src/glusterfs.h


2007-05-08 10:04:52 GMT	Anand V. Avati <avati@80x25.org>	patch-8

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-8

    added 'flags' to create fop prototype in defaults.h

    modified files:
     libglusterfs/src/defaults.h


2007-05-08 06:24:22 GMT	Vikas Gorur <vikas@80x25.org>	patch-7

    Summary:
      minor fixes in posix-locks
    Revision:
      glusterfs--mainline--2.5--patch-7

    
    

    modified files:
     xlators/features/posix-locks/src/posix-locks.c


2007-05-07 21:25:42 GMT	Amar Tumballi <amar@80x25.org>	patch-6

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-6

    * xlators/cluster/afr:
      - cleanup regarding LOCK (x) and UNLOCK (x);

    modified files:
     xlators/cluster/afr/src/afr.c


2007-05-07 20:42:43 GMT	Amar Tumballi <amar@80x25.org>	patch-5

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-5

    * xlators/cluster/unify:
      - changed unify to do STACK_UNWIND to fops before calling 
        mops->unlock on namespace lock.
      - rmdir checks the directory to have no entries, and only 
        then it does rmdir on all nodes.
      - opendir and releasedir on all the nodes.

    modified files:
     configure.ac xlators/Makefile.am
     xlators/cluster/unify/src/unify.c


2007-05-07 18:48:57 GMT	Vikas Gorur <vikas@80x25.org>	patch-4

    Summary:
      posix-locks final commit (patch 162) copied to this tree
    Revision:
      glusterfs--mainline--2.5--patch-4

    
    

    modified files:
     configure.ac xlators/Makefile.am
     xlators/features/posix-locks/src/posix-locks.c


2007-05-07 18:15:06 GMT	Amar Tumballi <amar@80x25.org>	patch-3

    Summary:
      Exclusive create 
    Revision:
      glusterfs--mainline--2.5--patch-3

    * xlators/*:
      - all the fops->create () calls are added with 'int32_t flags' now.
    
    * xlators/cluster/unify:
      - support for Exclusive create is done.
    

    modified files:
     glusterfs-fuse/src/fuse-internals.c
     libglusterfs/src/defaults.c libglusterfs/src/xlator.h
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/features/filter/src/filter.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/server/src/proto-srv.c
     xlators/storage/posix/src/posix.c


2007-05-07 16:46:32 GMT	Vikas Gorur <vikas@80x25.org>	patch-2

    Summary:
      changed 'cooky' to correct spelling 'cookie' :P
    Revision:
      glusterfs--mainline--2.5--patch-2

    
    

    modified files:
     glusterfs-fuse/src/fetch-spec.c
     glusterfs-fuse/src/fuse-internals.c
     libglusterfs/src/defaults.c libglusterfs/src/stack.h
     scheduler/alu/src/alu.c scheduler/nufa/src/nufa.c
     scheduler/random/src/random.c scheduler/rr/src/rr.c
     xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/encryption/rot-13/src/rot-13.c
     xlators/features/filter/src/filter.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/trash/src/trash.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/stat-prefetch/src/stat-prefetch.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/server/src/proto-srv.c


2007-05-07 15:27:34 GMT	Amar Tumballi <amar@80x25.org>	patch-1

    Summary:
      
    Revision:
      glusterfs--mainline--2.5--patch-1

    * libglusterfs/src/stack.h:
      - added _STACK_WIND with another argument 'cooky' which will be 
        returned in STACK_UNWIND.
    
    * xlators/*:
      - changed the argument of all the '*_cbk ()' to have 'void *cooky' 
        instead of 'call_frame_t *prev_frame'
    
    * schedulers/*:
      - added another function hook 'update ()', which can be called from 
        outside to update the stat info.
    
    * xlators/cluster/*:
      - changed place of incrementing 'local->call_count'. moved just before 
        checking it

    removed files:
     .arch-ids/TODO.id TODO

    modified files:
     glusterfs-fuse/src/fetch-spec.c
     glusterfs-fuse/src/fuse-internals.c
     libglusterfs/src/defaults.c libglusterfs/src/scheduler.h
     libglusterfs/src/stack.h scheduler/alu/src/alu.c
     scheduler/nufa/src/nufa.c scheduler/random/src/random.c
     scheduler/rr/src/rr.c xlators/cluster/afr/src/afr.c
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/src/unify.c
     xlators/debug/trace/src/trace.c
     xlators/encryption/rot-13/src/rot-13.c
     xlators/features/filter/src/filter.c
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/trash/src/trash.c
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/stat-prefetch/src/stat-prefetch.c
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/server/src/proto-srv.c


2007-05-07 07:52:29 GMT	Amar Tumballi <amar@80x25.org>	base-0

    Summary:
      Initial import for release 1.4.x
    Revision:
      glusterfs--mainline--2.5--base-0


    new files:
     AUTHORS COPYING ChangeLog INSTALL Makefile.am NEWS README TODO
     autogen.sh configure.ac doc/Makefile.am
     doc/examples/Makefile.am doc/examples/cluster-client.vol
     doc/examples/cluster-server1.vol
     doc/examples/cluster-server2.vol
     doc/examples/cluster-server3.vol
     doc/examples/standalone-client.vol
     doc/examples/standalone-server.vol
     doc/glusterfs-client.vol.sample
     doc/glusterfs-server.vol.sample doc/qa/qa-client.spec
     doc/qa/qa-server.spec glusterfs-fuse/Makefile.am
     glusterfs-fuse/src/Makefile.am glusterfs-fuse/src/fetch-spec.c
     glusterfs-fuse/src/fuse-bridge.c
     glusterfs-fuse/src/fuse-internals.c
     glusterfs-fuse/src/fuse-internals.h
     glusterfs-fuse/src/glusterfs.c glusterfs-fuse/src/glusterfs.h
     glusterfs-fuse/utils/Makefile.am
     glusterfs-fuse/utils/mount.glusterfs.in
     glusterfs-shell/Makefile.am
     glusterfs-shell/extensions/Makefile.am
     glusterfs-shell/extensions/commands.scm
     glusterfs-shell/extensions/cp.scm
     glusterfs-shell/extensions/hello.scm
     glusterfs-shell/extensions/hello_test.scm
     glusterfs-shell/extensions/mkdir.scm
     glusterfs-shell/extensions/readdir.scm
     glusterfs-shell/extensions/readfile.scm
     glusterfs-shell/extensions/readlink.scm
     glusterfs-shell/extensions/stat.scm
     glusterfs-shell/extensions/test.scm
     glusterfs-shell/src/Makefile.am
     glusterfs-shell/src/extensions.c
     glusterfs-shell/src/extensions.h glusterfs-shell/src/fops.c
     glusterfs-shell/src/fops.h glusterfs-shell/src/init.c
     glusterfs-shell/src/interpreter.c
     glusterfs-shell/src/interpreter.h
     glusterfs-shell/src/primitives.c
     glusterfs-shell/src/primitives.h glusterfs-shell/src/shell.c
     glusterfs-shell/src/shell.h glusterfsd/Makefile.am
     glusterfsd/src/Makefile.am glusterfsd/src/glusterfsd.c
     libglusterfs/Makefile.am libglusterfs/src/Makefile.am
     libglusterfs/src/common-utils.c
     libglusterfs/src/common-utils.h libglusterfs/src/defaults.c
     libglusterfs/src/defaults.h libglusterfs/src/dict.c
     libglusterfs/src/dict.h libglusterfs/src/epoll.c
     libglusterfs/src/glusterfs.h libglusterfs/src/hashfn.c
     libglusterfs/src/hashfn.h libglusterfs/src/layout.c
     libglusterfs/src/layout.h libglusterfs/src/loc_hint.c
     libglusterfs/src/loc_hint.h libglusterfs/src/lock.c
     libglusterfs/src/lock.h libglusterfs/src/logging.c
     libglusterfs/src/logging.h libglusterfs/src/poll.c
     libglusterfs/src/protocol.c libglusterfs/src/protocol.h
     libglusterfs/src/scheduler.c libglusterfs/src/scheduler.h
     libglusterfs/src/sdp_inet.h libglusterfs/src/spec.l
     libglusterfs/src/spec.y libglusterfs/src/stack.h
     libglusterfs/src/timer.c libglusterfs/src/timer.h
     libglusterfs/src/transport.c libglusterfs/src/transport.h
     libglusterfs/src/xlator.c libglusterfs/src/xlator.h
     scheduler/Makefile.am scheduler/alu/Makefile.am
     scheduler/alu/src/Makefile.am scheduler/alu/src/alu.c
     scheduler/alu/src/alu.h scheduler/nufa/Makefile.am
     scheduler/nufa/src/Makefile.am scheduler/nufa/src/nufa.c
     scheduler/nufa/src/nufa.h scheduler/random/Makefile.am
     scheduler/random/src/Makefile.am scheduler/random/src/random.c
     scheduler/random/src/random.h scheduler/rr/Makefile.am
     scheduler/rr/src/Makefile.am scheduler/rr/src/rr.c
     scheduler/rr/src/rr.h transport/Makefile.am
     transport/ib-sdp/Makefile.am
     transport/ib-sdp/client/Makefile.am
     transport/ib-sdp/client/src/Makefile.am
     transport/ib-sdp/client/src/ib-sdp-client.c
     transport/ib-sdp/ib-sdp.c transport/ib-sdp/ib-sdp.h
     transport/ib-sdp/server/Makefile.am
     transport/ib-sdp/server/src/Makefile.am
     transport/ib-sdp/server/src/ib-sdp-server.c
     transport/ib-verbs/Makefile.am
     transport/ib-verbs/client/Makefile.am
     transport/ib-verbs/client/src/Makefile.am
     transport/ib-verbs/client/src/ib-verbs-client.c
     transport/ib-verbs/ib-verbs.c transport/ib-verbs/ib-verbs.h
     transport/ib-verbs/server/Makefile.am
     transport/ib-verbs/server/src/Makefile.am
     transport/ib-verbs/server/src/ib-verbs-server.c
     transport/tcp/Makefile.am transport/tcp/client/Makefile.am
     transport/tcp/client/src/Makefile.am
     transport/tcp/client/src/tcp-client.c
     transport/tcp/server/Makefile.am
     transport/tcp/server/src/Makefile.am
     transport/tcp/server/src/tcp-server.c transport/tcp/tcp.c
     transport/tcp/tcp.h xlators/Makefile.am
     xlators/cluster/Makefile.am xlators/cluster/afr/Makefile.am
     xlators/cluster/afr/src/Makefile.am
     xlators/cluster/afr/src/afr.c xlators/cluster/afr/src/afr.h
     xlators/cluster/stripe/Makefile.am
     xlators/cluster/stripe/src/Makefile.am
     xlators/cluster/stripe/src/stripe.c
     xlators/cluster/unify/Makefile.am
     xlators/cluster/unify/src/Makefile.am
     xlators/cluster/unify/src/unify.c
     xlators/cluster/unify/src/unify.h xlators/debug/Makefile.am
     xlators/debug/trace/Makefile.am
     xlators/debug/trace/src/Makefile.am
     xlators/debug/trace/src/trace.c xlators/encryption/Makefile.am
     xlators/encryption/rot-13/Makefile.am
     xlators/encryption/rot-13/src/Makefile.am
     xlators/encryption/rot-13/src/rot-13.c
     xlators/encryption/rot-13/src/rot-13.h
     xlators/features/Makefile.am
     xlators/features/filter/Makefile.am
     xlators/features/filter/src/Makefile.am
     xlators/features/filter/src/filter.c
     xlators/features/filter/src/filter.h
     xlators/features/fixed-id/Makefile.am
     xlators/features/fixed-id/src/Makefile.am
     xlators/features/fixed-id/src/fixed-id.c
     xlators/features/posix-locks/Makefile.am
     xlators/features/posix-locks/src/Makefile.am
     xlators/features/posix-locks/src/posix-locks.c
     xlators/features/posix-locks/src/posix-locks.h
     xlators/features/trash/Makefile.am
     xlators/features/trash/src/Makefile.am
     xlators/features/trash/src/trash.c
     xlators/performance/Makefile.am
     xlators/performance/io-threads/Makefile.am
     xlators/performance/io-threads/src/Makefile.am
     xlators/performance/io-threads/src/io-threads.c
     xlators/performance/io-threads/src/io-threads.h
     xlators/performance/read-ahead/Makefile.am
     xlators/performance/read-ahead/src/Makefile.am
     xlators/performance/read-ahead/src/page.c
     xlators/performance/read-ahead/src/read-ahead.c
     xlators/performance/read-ahead/src/read-ahead.h
     xlators/performance/stat-prefetch/Makefile.am
     xlators/performance/stat-prefetch/src/Makefile.am
     xlators/performance/stat-prefetch/src/stat-prefetch.c
     xlators/performance/stat-prefetch/src/stat-prefetch.h
     xlators/performance/write-behind/Makefile.am
     xlators/performance/write-behind/src/Makefile.am
     xlators/performance/write-behind/src/write-behind.c
     xlators/protocol/Makefile.am
     xlators/protocol/client/Makefile.am
     xlators/protocol/client/src/Makefile.am
     xlators/protocol/client/src/client-protocol.c
     xlators/protocol/client/src/client-protocol.h
     xlators/protocol/server/Makefile.am
     xlators/protocol/server/src/Makefile.am
     xlators/protocol/server/src/ns.c
     xlators/protocol/server/src/ns.h
     xlators/protocol/server/src/proto-srv.c
     xlators/protocol/server/src/proto-srv.h
     xlators/storage/Makefile.am xlators/storage/posix/Makefile.am
     xlators/storage/posix/src/Makefile.am
     xlators/storage/posix/src/posix.c
     xlators/storage/posix/src/posix.h


