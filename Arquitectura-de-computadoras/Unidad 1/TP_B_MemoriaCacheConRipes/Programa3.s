.data
vector: .word 1234, 5678, 3756, 2569
final:

.text
la x12, vector
la x13, final

siguiente:
  lw x5, 0(x12)
  li x6, 10
  li x7, 0

loop:
  sub x5, x5, x6
  addi x7, x7, 1
  bge x5, x6, loop
  addi x5, x5, 0x30
  add a0, x0, x5
  addi a7, x0, 11
  ecall
  add x5, x0, x7
  addi x7, x0, 0
  bge x5, x6, loop

addi x5, x5, 0x30
add a0, x0, x5
addi a7, x0, 11
ecall
addi x12, x12, 4
bne x12, x13, siguiente

fin:
  beq x0, x0 fin