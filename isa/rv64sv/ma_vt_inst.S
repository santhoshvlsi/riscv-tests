#*****************************************************************************
# ma_vt_inst.S
#-----------------------------------------------------------------------------
#
# Test misaligned vt instruction trap.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64S
RVTEST_CODE_BEGIN

  li a0, SR_EA | SR_EI
  csrs status, a0

  la a3,handler
  csrw evec,a3

  csrr a3,status
  li a4,(1 << IRQ_COP)
  slli a4,a4,SR_IM_SHIFT
  or a3,a3,a4 # enable IM[COP]
  csrw status,a3

  vsetcfg 32,0
  li a3,4
  vsetvl a3,a3

  lui a0,%hi(vtcode1+2)
  vf %lo(vtcode1+2)(a0)
1:      j 1b

vtcode1:
  add x2,x2,x3
  stop

handler:
  vxcptkill

  li TESTNUM,2

  # check cause
  vxcptcause a3
  li a4,HWACHA_CAUSE_VF_MISALIGNED_FETCH
  bne a3,a4,fail

  # check badvaddr
  vxcptaux a3
  la a4,vtcode1+2
  andi a3, a3, -4 # mask off lower bits so that may
  andi a4, a4, -4 # ignore impl. specific behavior
  bne a3,a4,fail

  # make sure vector unit has cleared out
  vsetcfg 32,0
  li a3,4
  vsetvl a3,a3

  la a3,src1
  la a4,src2
  vld vx2,a3
  vld vx3,a4
  lui a0,%hi(vtcode1)
  vf %lo(vtcode1)(a0)
  la a5,dest
  vsd vx2,a5
  fence

  ld a1,0(a5)
  li a2,5
  li TESTNUM,2
  bne a1,a2,fail
  ld a1,8(a5)
  li TESTNUM,3
  bne a1,a2,fail
  ld a1,16(a5)
  li TESTNUM,4
  bne a1,a2,fail
  ld a1,24(a5)
  li TESTNUM,5
  bne a1,a2,fail

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src1:
  .dword 1
  .dword 2
  .dword 3
  .dword 4
src2:
  .dword 4
  .dword 3
  .dword 2
  .dword 1
dest:
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe
  .dword 0xdeadbeefcafebabe

RVTEST_DATA_END
