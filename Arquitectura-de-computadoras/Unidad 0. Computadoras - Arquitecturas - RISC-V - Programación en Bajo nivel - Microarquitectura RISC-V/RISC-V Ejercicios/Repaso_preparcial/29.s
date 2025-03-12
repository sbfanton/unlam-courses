# B.29 Dado un vector de 10 elementos:
# .data
# vector: .word 100,-20,40,-365,400,65536,1,0,3,-10
# Utilizando las subrutinas MaxDir y Swap, recorra el vector desde el primer elemento hasta el
# último comparando direcciones consecutivas (ej: vector[0] vs vector[1], luego vector[1] vs vector[2], luego vector[2] vs vector[3]....).
# En cada iteración si el primer elemento es mayor
# que el segundo, utilice swap para intercambiarlos. Al final de las iteraciones debe quedar el
# elemento mayor ubicado al final del vector. Utilice entonces un llamado a PrintVector para
# ver el mismo por consola.

.data
    vector: .word 100,-20,40,-365,400,65536,1,0,3,-10
    finVector:
    
.text
la a0, vector
la x2, finVector
sub x2, x2, a0
srai x4, x2, 2
addi x5, x0, 1
jal x1, loop

la a0, vector
addi x5, x0, 0
jal x1, print_vector
jal x1, end

loop:
    addi a1, a0, 4
    addi x5, x5, 1
    jal x6, MaxDir
    addi a0, a0, 4
    blt x5, x4, loop
    jalr x0, x1, 0

MaxDir:
     lw x2, 0(a0)
     lw x3, 0(a1)
     bgt x2, x3, Swap
     jalr x0, x6, 0
     
Swap:
    sw x2, 0(a1)
    sw x3, 0(a0)
    jalr x0, x6, 0
    
print_vector:
    beqz x5, first_it
    lw a0, 0(x3)
    addi a7, x0, 1
    ecall
    addi x3, x3, 4
    bne x5, x4, print_coma
    ret
    
first_it:
    add x3, a0, x0
    addi x5, x5, 1
    j print_vector
    
print_coma:
    addi a0, x0, 44
    addi a7, x0, 11
    ecall
    addi x5, x5, 1
    j print_vector

end:
    nop