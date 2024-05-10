# B.20 Dado un vector con valores enteros signados, escriba un programa que encuentre cuál es
# el valor mínimo almacenado y lo informe por consola. El vector posee N elementos, pero se
# sabe que el último elemento del mismo siempre es 0. Una vez completado el programa
# modifique los valores del vector con distintos casos de prueba.

.data
vector: .word 100,20,40, -300, 0

.text
la x2, vector
li x3, 0
jal x1, get_elements_total
lw a0, 0(x2)
jal x1, loop
jal x1, print_min

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
    blt x4, a0, min
    addi x2, x2, 4
    bgtz x3, loop
    ret
    
min:
    add a0, x4, x0
    addi x2, x2, 4
    j loop

print_min:
    addi a7, x0, 1
    ecall
