#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# public headers
set( softfloat_public_HDRS
  softfloat_version.h
  ${SRCDIR}/include/softfloat.h
  ${SRCDIR}/include/softfloat_types.h
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the sources

#
if( IBM_IEEE )
  set( softfloat_IBM
    ${IBMDIR}/f128_roundToInt.c
    ${IBMDIR}/f128_scaledResult.c
    ${IBMDIR}/f32_roundToInt.c
    ${IBMDIR}/f32_scaledResult.c
    ${IBMDIR}/f64_roundToInt.c
    ${IBMDIR}/f64_scaledResult.c
  )
else()
  set( softfloat_IBM
    ${SRCDIR}/f32_roundToInt.c
  )
endif()

#
set( softfloat_PRIMITIVES
  ${SRCDIR}/s_add128.c
  ${SRCDIR}/s_add256M.c
  ${SRCDIR}/s_approxRecipSqrt_1Ks.c
  ${SRCDIR}/s_approxRecipSqrt32_1.c
  ${SRCDIR}/s_countLeadingZeros32.c
  ${SRCDIR}/s_countLeadingZeros64.c
  ${SRCDIR}/s_countLeadingZeros8.c
  ${SRCDIR}/s_eq128.c
  ${SRCDIR}/s_le128.c
  ${SRCDIR}/s_lt128.c
  ${SRCDIR}/s_mul128By32.c
  ${SRCDIR}/s_mul128To256M.c
  ${SRCDIR}/s_mul64ByShifted32To128.c
  ${SRCDIR}/s_mul64To128.c
  ${SRCDIR}/s_shiftRightJam128.c
  ${SRCDIR}/s_shiftRightJam128Extra.c
  ${SRCDIR}/s_shiftRightJam256M.c
  ${SRCDIR}/s_shiftRightJam32.c
  ${SRCDIR}/s_shiftRightJam64.c
  ${SRCDIR}/s_shiftRightJam64Extra.c
  ${SRCDIR}/s_shortShiftLeft128.c
  ${SRCDIR}/s_shortShiftRight128.c
  ${SRCDIR}/s_shortShiftRightJam128.c
  ${SRCDIR}/s_shortShiftRightJam128Extra.c
  ${SRCDIR}/s_shortShiftRightJam64.c
  ${SRCDIR}/s_shortShiftRightJam64Extra.c
  ${SRCDIR}/s_sub128.c
  ${SRCDIR}/s_sub256M.c

  ${SRCDIR}/s_addMagsF128.c
  ${SRCDIR}/s_subMagsF128.c
  ${SRCDIR}/s_addMagsF64.c
  ${SRCDIR}/s_subMagsF64.c
  ${SRCDIR}/s_addMagsF32.c
  ${SRCDIR}/s_subMagsF32.c
  ${SRCDIR}/s_roundToUI64.c
  ${SRCDIR}/s_roundToUI32.c
  ${SRCDIR}/s_mulAddF32.c
  ${SRCDIR}/s_mulAddF64.c
  ${SRCDIR}/s_roundToI32.c
  ${SRCDIR}/s_roundToI64.c
  ${SRCDIR}/s_roundPackToF64.c
  ${SRCDIR}/s_roundPackToF32.c
  ${SRCDIR}/s_roundPackToF128.c
)

#
set( softfloat_SPECIALISED
  ${SRCDIR}/${VARIANT}/s_commonNaNToF128UI.c
  ${SRCDIR}/${VARIANT}/s_commonNaNToF32UI.c
  ${SRCDIR}/${VARIANT}/s_commonNaNToF64UI.c
  ${SRCDIR}/${VARIANT}/s_f128UIToCommonNaN.c
  ${SRCDIR}/${VARIANT}/s_f32UIToCommonNaN.c
  ${SRCDIR}/${VARIANT}/s_f64UIToCommonNaN.c

  ${SRCDIR}/${VARIANT}/s_propagateNaNF128UI.c
  ${SRCDIR}/${VARIANT}/s_propagateNaNF64UI.c
  ${SRCDIR}/${VARIANT}/s_propagateNaNF32UI.c
  ${SRCDIR}/${VARIANT}/softfloat_raiseFlags.c
)

#
set( softfloat_OTHER
  ${SRCDIR}/f128_add.c
  ${SRCDIR}/f128_div.c
  ${SRCDIR}/f128_eq.c
  ${SRCDIR}/f128_eq_signaling.c
  ${SRCDIR}/f128_isSignalingNaN.c
  ${SRCDIR}/f128_le.c
  ${SRCDIR}/f128_le_quiet.c
  ${SRCDIR}/f128_lt.c
  ${SRCDIR}/f128_lt_quiet.c
  ${SRCDIR}/f128_mul.c
  ${SRCDIR}/f128_mulAdd.c
  ${SRCDIR}/f128_rem.c
  ${SRCDIR}/f128_sqrt.c
  ${SRCDIR}/f128_sub.c
  ${SRCDIR}/f128_to_f32.c
  ${SRCDIR}/f128_to_f64.c
  ${SRCDIR}/f128_to_i32.c
  ${SRCDIR}/f128_to_i32_r_minMag.c
  ${SRCDIR}/f128_to_i64.c
  ${SRCDIR}/f128_to_i64_r_minMag.c
  ${SRCDIR}/f128_to_ui32.c
  ${SRCDIR}/f128_to_ui32_r_minMag.c
  ${SRCDIR}/f128_to_ui64.c
  ${SRCDIR}/f128_to_ui64_r_minMag.c
  ${SRCDIR}/f32_add.c
  ${SRCDIR}/f32_div.c
  ${SRCDIR}/f32_eq.c
  ${SRCDIR}/f32_eq_signaling.c
  ${SRCDIR}/f32_isSignalingNaN.c
  ${SRCDIR}/f32_le.c
  ${SRCDIR}/f32_le_quiet.c
  ${SRCDIR}/f32_lt.c
  ${SRCDIR}/f32_lt_quiet.c
  ${SRCDIR}/f32_mul.c
  ${SRCDIR}/f32_mulAdd.c
  ${SRCDIR}/f32_rem.c
  ${SRCDIR}/f32_sqrt.c
  ${SRCDIR}/f32_sub.c
  ${SRCDIR}/f32_to_f128.c
  ${SRCDIR}/f32_to_f64.c
  ${SRCDIR}/f32_to_i32.c
  ${SRCDIR}/f32_to_i32_r_minMag.c
  ${SRCDIR}/f32_to_i64.c
  ${SRCDIR}/f32_to_i64_r_minMag.c
  ${SRCDIR}/f32_to_ui32.c
  ${SRCDIR}/f32_to_ui32_r_minMag.c
  ${SRCDIR}/f32_to_ui64.c
  ${SRCDIR}/f32_to_ui64_r_minMag.c
  ${SRCDIR}/f64_add.c
  ${SRCDIR}/f64_div.c
  ${SRCDIR}/f64_eq.c
  ${SRCDIR}/f64_eq_signaling.c
  ${SRCDIR}/f64_isSignalingNaN.c
  ${SRCDIR}/f64_le.c
  ${SRCDIR}/f64_le_quiet.c
  ${SRCDIR}/f64_lt.c
  ${SRCDIR}/f64_lt_quiet.c
  ${SRCDIR}/f64_mul.c
  ${SRCDIR}/f64_mulAdd.c
  ${SRCDIR}/f64_rem.c
  ${SRCDIR}/f64_sqrt.c
  ${SRCDIR}/f64_sub.c
  ${SRCDIR}/f64_to_f128.c
  ${SRCDIR}/f64_to_f32.c
  ${SRCDIR}/f64_to_i32.c
  ${SRCDIR}/f64_to_i32_r_minMag.c
  ${SRCDIR}/f64_to_i64.c
  ${SRCDIR}/f64_to_i64_r_minMag.c
  ${SRCDIR}/f64_to_ui32.c
  ${SRCDIR}/f64_to_ui32_r_minMag.c
  ${SRCDIR}/f64_to_ui64.c
  ${SRCDIR}/f64_to_ui64_r_minMag.c
  ${SRCDIR}/i32_to_f128.c
  ${SRCDIR}/i32_to_f32.c
  ${SRCDIR}/i32_to_f64.c
  ${SRCDIR}/i64_to_f128.c
  ${SRCDIR}/i64_to_f32.c
  ${SRCDIR}/i64_to_f64.c
  ${SRCDIR}/s_mulAddF128.c
  ${SRCDIR}/s_normRoundPackToF128.c
  ${SRCDIR}/s_normRoundPackToF32.c
  ${SRCDIR}/s_normRoundPackToF64.c
  ${SRCDIR}/s_normSubnormalF128Sig.c
  ${SRCDIR}/s_normSubnormalF32Sig.c
  ${SRCDIR}/s_normSubnormalF64Sig.c
  ${SRCDIR}/s_subMagsF128.c
  ${SRCDIR}/ui32_to_f128.c
  ${SRCDIR}/ui32_to_f32.c
  ${SRCDIR}/ui32_to_f64.c
  ${SRCDIR}/ui64_to_f128.c
  ${SRCDIR}/ui64_to_f32.c
  ${SRCDIR}/ui64_to_f64.c
)

# the whole shebang
set( softfloat_SRCS
  softfloat_version.c
  "${softfloat_IBM}"
  "${softfloat_PRIMITIVES}"
  "${softfloat_SPECIALISED}"
  "${softfloat_OTHER}"
  ${SRCDIR}/softfloat_state.c
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the include directories
set( softfloat_include_DIRS
  ${CMAKE_CURRENT_BINARY_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/${SRCDIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/${SRCDIR}/${VARIANT}
  ${CMAKE_CURRENT_SOURCE_DIR}/${SRCDIR}/include
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the link directories
set( softfloat_link_DIRS
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the libraries
set( softfloat_LIBS
)

# the defs
set( softfloat_DEFS
  VERSION=${VERSION}
  RELEASE=${RELEASE}
  MODLEVL=${MODLEVL}
  BLDLEVL=${BLDLEVL}
  VERSION_TRIPLET=${VERSION_TRIPLET}
  VERSION_STRING=${VERSION_STRING}

  VARIANT=${VARIANT}

  SOFTFLOAT_ROUND_ODD
  INLINE_LEVEL=5
  INLINE=inline
  SOFTFLOAT_FAST_INT64
  SOFTFLOAT_FAST_DIV32TO16
  SOFTFLOAT_FAST_DIV64TO32

)

# the pragma diagnostics
set( softfloat_pragma_DIAG
)
