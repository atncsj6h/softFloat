#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_guard( GLOBAL )

# the repository

# the defs
set( softfloat_DEFS
  VERSION=${VERSION}
  RELEASE=${RELEASE}
  MODLEVL=${MODLEVL}
  BLDLEVL=${BLDLEVL}
  VERSION_TRIPLET=${VERSION_TRIPLET}
  VERSION_STRING=${VERSION_STRING}

  SOFTFLOAT_ROUND_ODD
  INLINE_LEVEL=5
  INLINE=inline
  SOFTFLOAT_FAST_INT64
  SOFTFLOAT_FAST_DIV32TO16
  SOFTFLOAT_FAST_DIV64TO32
)

