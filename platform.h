#ifndef platform_h_included
#define platform_h_included

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/
#if !defined( __has_include )
  #define __has_include(_X) 0
#endif

#if !defined( __has_builtin )
  #define __has_builtin(_X) 0
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/
#ifndef LITTLEENDIAN
  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
    #define LITTLEENDIAN
  #endif
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

#ifndef HAVE_INT128_T
#define HAVE_INT128_T
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

#ifndef INLINE
#define INLINE inline
#endif

#ifndef THREAD_LOCAL
#define THREAD_LOCAL __thread
#endif

#ifndef HAVE_BUILTIN_BSWAP
#define HAVE_BUILTIN_BSWAP
#endif


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//  see opts_GCC.h for the attribution of COPYRIGHT

#ifdef INLINE

#include <stdint.h>
#include "primitiveTypes.h"

#if __has_builtin( __builtin_clzs ) && \
    __has_builtin( __builtin_clz ) && \
    __has_builtin( __builtin_clzll )

  static INLINE
  uint_fast8_t softFloat_countLeadingZeros16( uint16_t a )
    { return a ? __builtin_clzs( a ) :16; }
  #define softFloat_countLeadingZeros16 softFloat_countLeadingZeros16

  static INLINE
  uint_fast8_t softFloat_countLeadingZeros32( uint32_t a )
    { return a ? __builtin_clz( a ) : 32; }
  #define softFloat_countLeadingZeros32 softFloat_countLeadingZeros32

  static INLINE
  uint_fast8_t softFloat_countLeadingZeros64( uint64_t a )
    { return a ? __builtin_clzll( a ) : 64; }
  #define softFloat_countLeadingZeros64 softFloat_countLeadingZeros64

#endif  //  count leading zeros builtins

#ifdef HAVE_INT128_T

  static INLINE
  struct uint128 softFloat_mul64ByShifted32To128( uint64_t a, uint32_t b )
  {
    union { unsigned __int128 ui; struct uint128 s; } uZ;
    uZ.ui = (unsigned __int128) a * ((uint_fast64_t) b<<32);
    return uZ.s;
  }
  #define softFloat_mul64ByShifted32To128 softFloat_mul64ByShifted32To128

  static INLINE
  struct uint128 softFloat_mul64To128( uint64_t a, uint64_t b )
  {
    union { unsigned __int128 ui; struct uint128 s; } uZ;
    uZ.ui = (unsigned __int128) a * b;
    return uZ.s;
  }
  #define softFloat_mul64To128 softFloat_mul64To128

  static INLINE
  struct uint128 softFloat_mul128By32( uint64_t a64, uint64_t a0, uint32_t b )
  {
    union { unsigned __int128 ui; struct uint128 s; } uZ;
    uZ.ui = ((unsigned __int128) a64<<64 | a0) * b;
    return uZ.s;
  }
  #define softFloat_mul128By32 softFloat_mul128By32

  static INLINE
  void softFloat_mul128To256M(
    uint64_t a64, uint64_t a0, uint64_t b64, uint64_t b0, uint64_t *zPtr )
  {
    unsigned __int128 z0, mid1, mid, z128;
    z0 = (unsigned __int128) a0 * b0;
    mid1 = (unsigned __int128) a64 * b0;
    mid = mid1 + (unsigned __int128) a0 * b64;
    z128 = (unsigned __int128) a64 * b64;
    z128 += (unsigned __int128) (mid < mid1)<<64 | mid>>64;
    mid <<= 64;
    z0 += mid;
    z128 += (z0 < mid);
    zPtr[indexWord( 4, 0 )] = z0;
    zPtr[indexWord( 4, 1 )] = z0>>64;
    zPtr[indexWord( 4, 2 )] = z128;
    zPtr[indexWord( 4, 3 )] = z128>>64;
  }
  #define softFloat_mul128To256M softFloat_mul128To256M

#endif  //  HAVE_INT128_T

#endif  //  INLINE

#endif  // platform_h_included
