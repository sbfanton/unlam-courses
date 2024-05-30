.data
vector: .word 1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90
final:

.text
la x5,vector
la x6, final
addi x6, x6, -4

invertir:
lw x10, 0(x5)
lw x11, 0(x6)
sw x11, 0(x5)
sw x10, 0(x6)
addi x5, x5, 4
addi x6, x6, -4
bge x6, x5, invertir

fin:
beq x0,x0,fin