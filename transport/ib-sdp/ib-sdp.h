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

#ifndef _XPORT_IB_SDP_H
#define _XPORT_IB_SDP_H


#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif

#include <stdio.h>
#include <arpa/inet.h>

#define CLIENT_PORT_CIELING 1023

#ifndef AF_INET_SDP
#define AF_INET_SDP 27
#endif

struct wait_queue {
  struct wait_queue *next;
  char *buf;
  int32_t len;
};

typedef struct ib_sdp_private ib_sdp_private_t;
struct ib_sdp_private {
  int32_t sock;
  unsigned char connected;
  unsigned char connection_in_progress;
  unsigned char is_debug;
  in_addr_t addr;
  unsigned short port;
  char *volume;
  pthread_mutex_t read_mutex;
  pthread_mutex_t write_mutex;

  //  pthread_mutex_t queue_mutex;
  //  struct wait_queue *queue;

  dict_t *options;
  event_notify_fn_t notify; /* used by ib-sdp/server */
};

int32_t ib_sdp_bail (transport_t *this);
int32_t ib_sdp_except (transport_t *this);
int32_t ib_sdp_disconnect (transport_t *this);
int32_t ib_sdp_recieve (transport_t *this, char *buf, int32_t len);
int32_t ib_sdp_readv (transport_t *this,
		      const struct iovec *vector,
		      int32_t count);

#endif /* _XPORT_IB_SDP_H */
