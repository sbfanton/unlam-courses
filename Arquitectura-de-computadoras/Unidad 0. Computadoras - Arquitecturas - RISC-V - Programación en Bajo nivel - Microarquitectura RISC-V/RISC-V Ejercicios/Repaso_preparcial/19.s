# B.19 Dado un vector con valores enteros signados, escriba un programa que encuentre cuál es
# el valor mínimo almacenado y lo informe por consola. El vector posee 10 elementos. Una vez
# completado el programa modifique los valores del vector con distintos casos de prueba.

.data
vector: .word 100,-20,40,-365,400,6556,1,0,3,-10

.text
la x2, vector
li x3, 10
lw a0, 0(x2)

loop:
    lw x4, 4(x2)
    addi x3, x3, -1
    blt x4, a0, min
    addi x2, x2, 4
    bgtz x3, loop
    j print_min
    
min:
    add a0, x4, x0
    addi x2, x2, 4
    j loop

print_min:
    addi a7, x0, 1
    ecall
