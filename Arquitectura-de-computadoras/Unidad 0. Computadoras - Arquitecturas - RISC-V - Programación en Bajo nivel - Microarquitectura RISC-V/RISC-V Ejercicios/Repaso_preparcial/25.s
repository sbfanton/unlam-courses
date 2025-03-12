# B.25 Modifique el programa B.21 para que utilice la subrutina de B.23. Tenga en cuenta
# recorrer el vector copiando el valor de cada elemento al registro a1, el valor máximo actual en
# a0, y la subrutina dejará en a0 el valor del máximo entre esos dos elementos. Luego es
# cuestión de ir cargando en a1 el valor del elemento actual del vector hasta llegar al final.

.data
vector: .word 100,-20,40,-365,-400,65536,1,0

.text
la x2, vector
lw a0, 0(x2)
jal x1, loop
jal x1, print_max

loop:
    lw a1, 4(x2)
    addi x2, x2, 4
    j Max
    beqz a1, print_max
    addi x2, x2, 4
    j loop
    ret
    
 Max:
    bgt a1, a0, set_max
    beqz a1, print_max
    j loop
    
set_max:
    add a0, a1, x0
    j Max

print_max:
    addi a7, x0, 1
    ecall


