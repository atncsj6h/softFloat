#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# no need for a COPYRIGHT
# just list of catgorised sources from the Makefile[s]
#

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( softFloat_PRIMITIVES
  src/s_add128.c
  src/s_add256M.c
  src/s_approxRecip32_1.c
  src/s_approxRecipSqrt_1Ks.c
  src/s_approxRecipSqrt32_1.c
  src/s_countLeadingZeros32.c
  src/s_countLeadingZeros64.c
  src/s_countLeadingZeros8.c
  src/s_eq128.c
  src/s_le128.c
  src/s_lt128.c
  src/s_mul128By32.c
  src/s_mul128To256M.c
  src/s_mul64ByShifted32To128.c
  src/s_mul64To128.c
  src/s_shiftRightJam128.c
  src/s_shiftRightJam128Extra.c
  src/s_shiftRightJam256M.c
  src/s_shiftRightJam32.c
  src/s_shiftRightJam64.c
  src/s_shiftRightJam64Extra.c
  src/s_shortShiftLeft128.c
  src/s_shortShiftRight128.c
  src/s_shortShiftRightJam128.c
  src/s_shortShiftRightJam128Extra.c
  src/s_shortShiftRightJam64.c
  src/s_shortShiftRightJam64Extra.c
  src/s_sub128.c
  src/s_sub256M.c
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( softFloat_SPECIALISED
  src/8086-SSE/s_commonNaNToF128UI.c
  src/8086-SSE/s_commonNaNToF32UI.c
  src/8086-SSE/s_commonNaNToF64UI.c
  src/8086-SSE/s_f128UIToCommonNaN.c
  src/8086-SSE/s_f32UIToCommonNaN.c
  src/8086-SSE/s_f64UIToCommonNaN.c
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
set( softFloat_OTHER
  src/f128_add.c
  src/f128_div.c
  src/f128_eq.c
  src/f128_eq_signaling.c
  src/f128_isSignalingNaN.c
  src/f128_le.c
  src/f128_le_quiet.c
  src/f128_lt.c
  src/f128_lt_quiet.c
  src/f128_mul.c
  src/f128_mulAdd.c
  src/f128_rem.c
  src/f128_sqrt.c
  src/f128_sub.c
  src/f128_to_f32.c
  src/f128_to_f64.c
  src/f128_to_i32.c
  src/f128_to_i32_r_minMag.c
  src/f128_to_i64.c
  src/f128_to_i64_r_minMag.c
  src/f128_to_ui32.c
  src/f128_to_ui32_r_minMag.c
  src/f128_to_ui64.c
  src/f128_to_ui64_r_minMag.c
  src/f32_add.c
  src/f32_div.c
  src/f32_eq.c
  src/f32_eq_signaling.c
  src/f32_isSignalingNaN.c
  src/f32_le.c
  src/f32_le_quiet.c
  src/f32_lt.c
  src/f32_lt_quiet.c
  src/f32_mul.c
  src/f32_mulAdd.c
  src/f32_rem.c
  src/f32_sqrt.c
  src/f32_sub.c
  src/f32_to_f128.c
  src/f32_to_f64.c
  src/f32_to_i32.c
  src/f32_to_i32_r_minMag.c
  src/f32_to_i64.c
  src/f32_to_i64_r_minMag.c
  src/f32_to_ui32.c
  src/f32_to_ui32_r_minMag.c
  src/f32_to_ui64.c
  src/f32_to_ui64_r_minMag.c
  src/f64_add.c
  src/f64_div.c
  src/f64_eq.c
  src/f64_eq_signaling.c
  src/f64_isSignalingNaN.c
  src/f64_le.c
  src/f64_le_quiet.c
  src/f64_lt.c
  src/f64_lt_quiet.c
  src/f64_mul.c
  src/f64_mulAdd.c
  src/f64_rem.c
  src/f64_sqrt.c
  src/f64_sub.c
  src/f64_to_f128.c
  src/f64_to_f32.c
  src/f64_to_i32.c
  src/f64_to_i32_r_minMag.c
  src/f64_to_i64.c
  src/f64_to_i64_r_minMag.c
  src/f64_to_ui32.c
  src/f64_to_ui32_r_minMag.c
  src/f64_to_ui64.c
  src/f64_to_ui64_r_minMag.c
  src/i32_to_f128.c
  src/i32_to_f32.c
  src/i32_to_f64.c
  src/i64_to_f128.c
  src/i64_to_f32.c
  src/i64_to_f64.c
  src/s_mulAddF128.c
  src/s_normRoundPackToF128.c
  src/s_normRoundPackToF32.c
  src/s_normRoundPackToF64.c
  src/s_normSubnormalF128Sig.c
  src/s_normSubnormalF32Sig.c
  src/s_normSubnormalF64Sig.c
  src/s_subMagsF128.c
  src/ui32_to_f128.c
  src/ui32_to_f32.c
  src/ui32_to_f64.c
  src/ui64_to_f128.c
  src/ui64_to_f32.c
  src/ui64_to_f64.c
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#

