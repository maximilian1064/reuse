/* malloc.h -- header file for memory routines.  */

#ifndef _INCLUDE_HBWMALLOC_H_
#define _INCLUDE_HBWMALLOC_H_

#include <_ansi.h>
#include <sys/reent.h>

#define __need_size_t
#include <stddef.h>

#include <malloc.h>

/*[> include any machine-specific extensions <]*/
//#include <machine/malloc.h>

#ifdef __cplusplus
extern "C" {
#endif

#if 0
/* This version of struct mallinfo must match the one in
   libc/stdlib/mallocr.c.  */

struct mallinfo {
  size_t arena;    /* total space allocated from system */
  size_t ordblks;  /* number of non-inuse chunks */
  size_t smblks;   /* unused -- always zero */
  size_t hblks;    /* number of mmapped regions */
  size_t hblkhd;   /* total space in mmapped regions */
  size_t usmblks;  /* unused -- always zero */
  size_t fsmblks;  /* unused -- always zero */
  size_t uordblks; /* total allocated space */
  size_t fordblks; /* total non-inuse space */
  size_t keepcost; /* top-most, releasable (via malloc_trim) space */
};	
#endif

/* The routines.  */

extern _PTR hbw_malloc _PARAMS ((size_t));
#ifdef __CYGWIN__
#undef _malloc_r
#define _malloc_r(r, s) malloc (s)
#else
extern _PTR _hbw_malloc_r _PARAMS ((struct _reent *, size_t));
#endif

extern _VOID hbw_free _PARAMS ((_PTR));
#ifdef __CYGWIN__
#undef _free_r
#define _free_r(r, p) free (p)
#else
extern _VOID _hbw_free_r _PARAMS ((struct _reent *, _PTR));
#endif

extern _PTR hbw_realloc _PARAMS ((_PTR, size_t));
#ifdef __CYGWIN__
#undef _realloc_r
#define _realloc_r(r, p, s) realloc (p, s)
#else
extern _PTR _hbw_realloc_r _PARAMS ((struct _reent *, _PTR, size_t));
#endif

extern _PTR hbw_calloc _PARAMS ((size_t, size_t));
#ifdef __CYGWIN__
#undef _calloc_r
#define _calloc_r(r, s1, s2) calloc (s1, s2);
#else
extern _PTR _hbw_calloc_r _PARAMS ((struct _reent *, size_t, size_t));
#endif

extern _PTR hbw_memalign _PARAMS ((size_t, size_t));
#ifdef __CYGWIN__
#undef _memalign_r
#define _memalign_r(r, s1, s2) memalign (s1, s2);
#else
extern _PTR _hbw_memalign_r _PARAMS ((struct _reent *, size_t, size_t));
#endif

extern struct mallinfo hbw_mallinfo _PARAMS ((void));
#ifdef __CYGWIN__
#undef _mallinfo_r
#define _mallinfo_r(r) mallinfo ()
#else
extern struct mallinfo _hbw_mallinfo_r _PARAMS ((struct _reent *));
#endif

extern void hbw_malloc_stats _PARAMS ((void));
#ifdef __CYGWIN__
#undef _malloc_stats_r
#define _malloc_stats_r(r) malloc_stats ()
#else
extern void _hbw_malloc_stats_r _PARAMS ((struct _reent *));
#endif

extern int hbw_mallopt _PARAMS ((int, int));
#ifdef __CYGWIN__
#undef _mallopt_r
#define _mallopt_r(i1, i2) mallopt (i1, i2)
#else
extern int _hbw_mallopt_r _PARAMS ((struct _reent *, int, int));
#endif

extern size_t hbw_malloc_usable_size _PARAMS ((_PTR));
#ifdef __CYGWIN__
#undef _malloc_usable_size_r
#define _malloc_usable_size_r(r, p) malloc_usable_size (p)
#else
extern size_t _hbw_malloc_usable_size_r _PARAMS ((struct _reent *, _PTR));
#endif

/* These aren't too useful on an embedded system, but we define them
   anyhow.  */

extern _PTR hbw_valloc _PARAMS ((size_t));
#ifdef __CYGWIN__
#undef _valloc_r
#define _valloc_r(r, s) valloc (s)
#else
extern _PTR _hbw_valloc_r _PARAMS ((struct _reent *, size_t));
#endif

extern _PTR hbw_pvalloc _PARAMS ((size_t));
#ifdef __CYGWIN__
#undef _pvalloc_r
#define _pvalloc_r(r, s) pvalloc (s)
#else
extern _PTR _hbw_pvalloc_r _PARAMS ((struct _reent *, size_t));
#endif

extern int hbw_malloc_trim _PARAMS ((size_t));
#ifdef __CYGWIN__
#undef _malloc_trim_r
#define _malloc_trim_r(r, s) malloc_trim (s)
#else
extern int _hbw_malloc_trim_r _PARAMS ((struct _reent *, size_t));
#endif

/* A compatibility routine for an earlier version of the allocator.  */

extern _VOID hbw_mstats _PARAMS ((char *));
#ifdef __CYGWIN__
#undef _mstats_r
#define _mstats_r(r, p) mstats (p)
#else
extern _VOID _hbw_mstats_r _PARAMS ((struct _reent *, char *));
#endif

/* SVID2/XPG mallopt options */

#define M_MXFAST  1    /* UNUSED in this malloc */
#define M_NLBLKS  2    /* UNUSED in this malloc */
#define M_GRAIN   3    /* UNUSED in this malloc */
#define M_KEEP    4    /* UNUSED in this malloc */

/* mallopt options that actually do something */
  
#define M_TRIM_THRESHOLD    -1
#define M_TOP_PAD           -2
#define M_MMAP_THRESHOLD    -3 
#define M_MMAP_MAX          -4

#ifndef __CYGWIN__
/* Some systems provide this, so do too for compatibility.  */
extern void hbw_cfree _PARAMS ((_PTR));
#endif /* __CYGWIN__ */

#ifdef __cplusplus
}
#endif

#endif /* _INCLUDE_HBWMALLOC_H_ */
