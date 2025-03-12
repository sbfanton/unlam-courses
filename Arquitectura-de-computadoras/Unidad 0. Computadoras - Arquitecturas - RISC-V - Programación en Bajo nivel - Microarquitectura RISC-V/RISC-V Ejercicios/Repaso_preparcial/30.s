# B.30 Transforme el ejercicio B.28 en una subrutina llamada PushMax, la cual reciba en a0 la
# dirección de comienzo del vector y en a1 la cantidad de elementos del mismo. Cuando la
# subrutina retorna debe haber “empujado” el elemento mayor a la última posición del vector.
# Verifique luego del retorno llamando a PrintVector.

.data
    vector: .word 100,-20,40,-365,400,65536,1,0,3,-10
    finVector:
    
.text
la a0, vector
la x2, finVector
sub x2, x2, a0
srai a1, x2, 2
addi x5, x0, 1
jal x1, PushMax

la a0, vector
addi x5, x0, 0
jal x1, print_vector
jal x1, end

PushMax:
    addi x4, a0, 4
    addi x5, x5, 1
    jal x6, MaxDir
    addi a0, a0, 4
    blt x5, a1, PushMax
    jalr x0, x1, 0

MaxDir:
     lw x2, 0(a0)
     lw x3, 0(x4)
     bgt x2, x3, Swap
     jalr x0, x6, 0
     
Swap:
    sw x2, 0(x4)
    sw x3, 0(a0)
    jalr x0, x6, 0
    
print_vector:
    beqz x5, first_it
    lw a0, 0(x3)
    addi a7, x0, 1
    ecall
    addi x3, x3, 4
    bne x5, a1, print_coma
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