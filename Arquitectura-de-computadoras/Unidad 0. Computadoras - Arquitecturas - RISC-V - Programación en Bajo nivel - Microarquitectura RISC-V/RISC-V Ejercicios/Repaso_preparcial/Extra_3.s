# 3 Complete el siguiente programa en ASM de RISC-V que dado el vector cuente la cantidad de 
# elementos cuyos últimos dos bits sean 10. Imprima el valor encontrado en la consola 
# (mediante el ecall correspondiente)

.data
vector: .word 1, 20, 44, 2, 2306, 258, 259, 14594
finVector:
    
.text
    la x2, vector
    la x3, finVector
    li x4, 2
    
    loop:
        lw a0, 0(x2)
        andi x5, a0, 3
        beq x5, x4, print
        addi x2, x2, 4
        blt x2, x3, loop
        j end
        
    print:
        addi a7, x0, 1
        ecall
        addi a0, x0, 10
        addi a7, x0, 11
        ecall
        addi x2, x2, 4
        blt x2, x3, loop
        j end
        
    end:
        nop
