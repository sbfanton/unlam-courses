# 1 Complete el siguiente programa en ASM de RISC-V que dado el vector, 
# imprima por consola (mediante ecall) el contenido de las posiciones de memoria pares 
# cuyo contenido sea un numero par:

.data
vector: .byte 0x01, 0x10, 0x02, 0xFF, 0x33, 0x90, 0x55
finVector:

.text
la x2, vector
la x3, finVector

loop: 
    andi a0, x2, 1
    beqz a0, get_and_print_value
    addi x2, x2, 1
    blt x2, x3, loop
    j end
    
get_and_print_value:
    lb a0, 0(x2)
    andi x4, a0, 1
    addi x2, x2, 1
    bnez x4, loop
    addi a7, x0, 34
    ecall
    addi a0, x0, 10
    addi a7, x0, 11
    ecall
    j loop
    
end:
    nop