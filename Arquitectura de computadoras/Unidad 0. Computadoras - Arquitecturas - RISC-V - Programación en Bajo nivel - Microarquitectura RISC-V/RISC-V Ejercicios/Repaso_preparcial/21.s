# B.21 Modifique el programa de B.20 para encontrar el valor máximo.

.data
vector: .word 100,20,40, -300, 890, 0

.text
la x2, vector
li x3, 0
jal x1, get_elements_total
lw a0, 0(x2)
jal x1, loop
jal x1, print_max

get_elements_total:
    lw x4, 0(x2)
    addi x3, x3, 1
    addi x2, x2, 4
    bnez x4, get_elements_total
    la x2, vector
    ret

loop:
    lw x4, 4(x2)
    addi x3, x3, -1
    bgt x4, a0, max
    addi x2, x2, 4
    bgtz x3, loop
    ret
    
max:
    add a0, x4, x0
    addi x2, x2, 4
    j loop

print_max:
    addi a7, x0, 1
    ecall
