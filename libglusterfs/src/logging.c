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

#ifndef _CONFIG_H
#define _CONFIG_H
#include "config.h"
#endif

#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdarg.h>
#include <time.h>
#include <locale.h>
#include <string.h>
#include <stdlib.h>
#include "logging.h"

static pthread_mutex_t logfile_mutex;
static FILE *logfile = NULL;
static char *filename = NULL;
static uint8_t logrotate = 0;
static gf_loglevel_t loglevel = GF_LOG_MAX;

gf_loglevel_t gf_log_loglevel; /* extern'd */
FILE *gf_log_logfile;

void 
gf_log_logrotate (int signum)
{
  logrotate = 1;
}

gf_loglevel_t 
gf_log_get_loglevel (void)
{
  return loglevel;
}

void
gf_log_set_loglevel (gf_loglevel_t level)
{
  gf_log_loglevel = loglevel = level;
}

int32_t 
gf_log_init (const char *file)
{
  if (!file){
    fprintf (stderr, "gf_log_init: no filename specified\n");
    return -1;
  }

  pthread_mutex_init (&logfile_mutex, NULL);
  filename = strdup (file);
  if (!filename) {
    fprintf (stderr, "gf_log_init: strdup error\n");
    return -1;
  }

  logfile = fopen (file, "a");
  if (!logfile){
    fprintf (stderr,
	     "gf_log_init: failed to open logfile \"%s\" (%s)\n",
	     file,
	     strerror (errno));
    return -1;
  }
  gf_log_logfile = logfile;
  return 0;
}

int32_t 
_gf_log (const char *domain,
	 const char *file,
	 const char *function,
	 int32_t line,
	 gf_loglevel_t level, const char *fmt, ...)
{
  static char *level_strings[] = {"N", /* NONE */
				  "C", /* CRITICAL */
				  "E", /* ERROR */
				  "W", /* WARNING */
				  "T", /* TRACE (GF_LOG_NORMAL) */
				  "D", /* DEBUG */
				  ""};
  const char *basename;

  va_list ap;

  if (!logfile) {
    fprintf (stderr, "no logfile set\n");
    return (-1);
  }

  if (!domain || !fmt)
    return (-1);

  if (logrotate) {
    logrotate = 0;
    fclose (logfile);
    logfile = NULL;

    logfile = fopen (filename, "a");
    gf_log_logfile = logfile;
    if (!logfile) {
      fprintf (stderr, 
	       "gf_log: failed to open logfile \"%s\" (%s) while logrotating\n",
	       filename,
	       strerror (errno));
      return -1;
    }
  }

  if (level <= loglevel) {
    pthread_mutex_lock (&logfile_mutex);

    va_start (ap, fmt);
    time_t utime = time (NULL);
    struct tm *tm = localtime (&utime);
    char timestr[256];

    strftime (timestr, 256, "%Y-%m-%d %H:%M:%S", tm); 
    /* strftime (timestr, sizeof(timestr), nl_langinfo (D_T_FMT), tm); */

    basename = strrchr (file, '/');
    if (basename)
      basename++;
    else
      basename = file;
    fprintf (logfile, "%s %s [%s:%d:%s] %s: ",
	     timestr,
	     level_strings[level],
	     basename,
	     line,
	     function,
	     domain);
      
    vfprintf (logfile, fmt, ap);
    va_end (ap);
    fprintf (logfile, "\n");
    fflush (logfile);

    pthread_mutex_unlock (&logfile_mutex);
  }
  return (0);
}
