#*****************************************************************************
# fsgnj.S
#-----------------------------------------------------------------------------
#
# Test fsgn{j|jn|x}.{s|d} instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_FP_OP2_S( 2,  fsgnj.s, 0, -6.3,  6.3, -1.0 );
  TEST_FP_OP2_S( 3,  fsgnj.s, 0,  7.3,  7.3,  2.0 );
  TEST_FP_OP2_S( 4,  fsgnj.s, 0, -8.3, -8.3, -3.0 );
  TEST_FP_OP2_S( 5,  fsgnj.s, 0,  9.3, -9.3,  4.0 );

  TEST_FP_OP2_S(12, fsgnjn.s, 0,  6.3,  6.3, -1.0 );
  TEST_FP_OP2_S(13, fsgnjn.s, 0, -7.3,  7.3,  2.0 );
  TEST_FP_OP2_S(14, fsgnjn.s, 0,  8.3, -8.3, -3.0 );
  TEST_FP_OP2_S(15, fsgnjn.s, 0, -9.3, -9.3,  4.0 );

  TEST_FP_OP2_S(22, fsgnjx.s, 0, -6.3,  6.3, -1.0 );
  TEST_FP_OP2_S(23, fsgnjx.s, 0,  7.3,  7.3,  2.0 );
  TEST_FP_OP2_S(24, fsgnjx.s, 0,  8.3, -8.3, -3.0 );
  TEST_FP_OP2_S(25, fsgnjx.s, 0, -9.3, -9.3,  4.0 );

  TEST_FP_OP2_D(32,  fsgnj.d, 0, -6.3,  6.3, -1.0 );
  TEST_FP_OP2_D(33,  fsgnj.d, 0,  7.3,  7.3,  2.0 );
  TEST_FP_OP2_D(34,  fsgnj.d, 0, -8.3, -8.3, -3.0 );
  TEST_FP_OP2_D(35,  fsgnj.d, 0,  9.3, -9.3,  4.0 );

  TEST_FP_OP2_D(42, fsgnjn.d, 0,  6.3,  6.3, -1.0 );
  TEST_FP_OP2_D(43, fsgnjn.d, 0, -7.3,  7.3,  2.0 );
  TEST_FP_OP2_D(44, fsgnjn.d, 0,  8.3, -8.3, -3.0 );
  TEST_FP_OP2_D(45, fsgnjn.d, 0, -9.3, -9.3,  4.0 );

  TEST_FP_OP2_D(52, fsgnjx.d, 0, -6.3,  6.3, -1.0 );
  TEST_FP_OP2_D(53, fsgnjx.d, 0,  7.3,  7.3,  2.0 );
  TEST_FP_OP2_D(54, fsgnjx.d, 0,  8.3, -8.3, -3.0 );
  TEST_FP_OP2_D(55, fsgnjx.d, 0, -9.3, -9.3,  4.0 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
