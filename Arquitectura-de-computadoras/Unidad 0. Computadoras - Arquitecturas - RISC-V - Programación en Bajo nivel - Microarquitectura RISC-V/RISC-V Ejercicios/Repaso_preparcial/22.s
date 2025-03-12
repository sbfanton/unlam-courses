# B.22 Dado un vector con valores enteros sin signo, escriba un programa que encuentre cuál es
# el valor mínimo almacenado y lo informe por consola. El vector posee N elementos, pero se
# sabe que el último elemento del mismo siempre es 0 (el cual no debe ser tenido en cuenta en el resultado). 
# Una vez completado el programa modifique los valores del vector con distintos casos de prueba.

.data
vector: .word 100,20,40,365,400,65536,0

.text
la x2, vector
lw a0, 0(x2)
jal x1, loop
jal x1, print_min

loop:
    lw x4, 4(x2)
    beqz x4, print_min
    bltu x4, a0, min # se usa bltu en vez de blt porque se sabe que son enteros sin signo
    addi x2, x2, 4
    j loop
    ret
    
min:
    add a0, x4, x0
    addi x2, x2, 4
    j loop

print_min:
    addi a7, x0, 1
    ecall
