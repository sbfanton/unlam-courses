# B.31 Escriba un programa llamado Burbujeo, que utilice PushMax 10 veces consecutivamente
# sobre el vector. El mismo debería quedar ordenado de menor a mayor luego de las 10
# iteraciones. En cada iteración llame a PrintVector para ver como se ordena.

.data
    vector: .word 100,-20,40,-365,400,65536,1,0,3,-10
    finVector:
    
.text
la a0, vector
la x2, finVector
sub x2, x2, a0
srai a1, x2, 2
add x7, a1, x0

loop:
    la a0, vector
    addi x5, x0, 1
    jal x1, PushMax
    la a0, vector
    addi x5, x0, 0
    jal x1, print_vector
    addi a0, x0, 10
    addi a7, x0, 11
    ecall
    addi x7, x7, -1
    bgtz x7, loop 
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