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

#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif

#include "timer.h"
#include "logging.h"
#include "common-utils.h"

#define TS(tv) ((((unsigned long long) tv.tv_sec) * 1000000) + (tv.tv_usec))

gf_timer_t *
gf_timer_call_after (glusterfs_ctx_t *ctx,
		     struct timeval delta,
		     gf_timer_cbk_t cbk,
		     void *data)
{
  if (!ctx) {
    gf_log ("timer", GF_LOG_ERROR, "!ctx");
    return NULL;
  }

  gf_timer_registry_t *reg = gf_timer_registry_init (ctx);
  gf_timer_t *event, *trav;
  unsigned long long at;

  if (!reg) {
    gf_log ("timer", GF_LOG_ERROR, "!reg");
    return NULL;
  }

  event = calloc (1, sizeof (*event));
  if (!event) {
    gf_log ("timer", GF_LOG_CRITICAL, "Not enough memory");
    return NULL;
  }
  gettimeofday (&event->at, NULL);
  event->at.tv_usec = ((event->at.tv_usec + delta.tv_usec) % 1000000);
  event->at.tv_sec += ((event->at.tv_usec + delta.tv_usec) / 1000000);
  event->at.tv_sec += delta.tv_sec;
  at = TS (event->at);
  event->cbk = cbk;
  event->data = data;
  pthread_mutex_lock (&reg->lock);
  {
    trav = reg->active.prev;
    while (trav != &reg->active) {
      if (TS (trav->at) < at)
	break;
      trav = trav->prev;
    }
    event->prev = trav;
    event->next = event->prev->next;
    event->prev->next = event;
    event->next->prev = event;
  }
  pthread_mutex_unlock (&reg->lock);
  return event;
}

int32_t
gf_timer_call_stale (gf_timer_registry_t *reg,
		     gf_timer_t *event)
{
  if (!reg || !event) {
    gf_log ("timer", GF_LOG_ERROR, "!reg || !event");
    return 0;
  }

  event->next->prev = event->prev;
  event->prev->next = event->next;
  event->next = &reg->stale;
  event->prev = event->next->prev;
  event->next->prev = event;
  event->prev->next = event;

  return 0;
}

int32_t
gf_timer_call_cancel (glusterfs_ctx_t *ctx,
		      gf_timer_t *event)
{
  if (!ctx || !event) {
    gf_log ("timer", GF_LOG_ERROR, "!ctx || !event");
    return 0;
  }

  gf_timer_registry_t *reg = gf_timer_registry_init (ctx);
  if (!reg) {
    gf_log ("timer", GF_LOG_ERROR, "!reg");
    return 0;
  }

  pthread_mutex_lock (&reg->lock);
  {
    event->next->prev = event->prev;
    event->prev->next = event->next;
  }
  pthread_mutex_unlock (&reg->lock);

  freee (event);
  return 0;
}

void *
gf_timer_proc (void *ctx)
{
  if (!ctx) {
    gf_log ("timer", GF_LOG_ERROR, "(!ctx)");
    return 0;
  }

  gf_timer_registry_t *reg = gf_timer_registry_init (ctx);
  if (!reg) {
    gf_log ("timer", GF_LOG_ERROR, "!reg");
    return NULL;
  }

  while (!reg->fin) {
    unsigned long long now;
    struct timeval now_tv;
    gf_timer_t *event;

    gettimeofday (&now_tv, NULL);
    now = TS (now_tv);
    while (1) {
      unsigned long long at;
      char need_cbk = 0;

      pthread_mutex_lock (&reg->lock);
      {
	event = reg->active.next;
	at = TS (event->at);
	if (event != &reg->active && now >= at) {
	  need_cbk = 1;
	  gf_timer_call_stale (reg, event);
	}
      }
      pthread_mutex_unlock (&reg->lock);
      if (need_cbk)
	event->cbk (event->data);

      else
	break;
    }
    usleep (100000);
  }
  return NULL;
}

gf_timer_registry_t *
gf_timer_registry_init (glusterfs_ctx_t *ctx)
{
  if (!ctx) {
    gf_log ("timer", GF_LOG_ERROR, "!ctx");
    return NULL;
  }
  
  if (!ctx->timer) {
    gf_timer_registry_t *reg;

    ctx->timer = reg = calloc (1, sizeof (*reg));
    pthread_mutex_init (&reg->lock, NULL);
    reg->active.next = &reg->active;
    reg->active.prev = &reg->active;
    reg->stale.next = &reg->stale;
    reg->stale.prev = &reg->stale;

    pthread_create (&reg->th, NULL, gf_timer_proc, ctx);
  }
  return ctx->timer;
}
