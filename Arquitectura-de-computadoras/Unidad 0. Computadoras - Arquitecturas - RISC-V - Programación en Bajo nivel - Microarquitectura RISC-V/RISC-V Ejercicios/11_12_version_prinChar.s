.data
    numero: .word 0

.text
    li x4, 10
    li x5, 0xbc
    li x6, 0
    la x7, numero
    la x8, numero

    loop1:
        addi x5, x5, -10
        addi x6, x6, 1
        bge x5, x4, loop1
        sb x5, 0(x7)
        addi x7, x7, 1
        add x5, x0, x6
        li x6, 0 
        bgt x5, x4, loop1
        sb x5, 0(x7)
    
    loop2:
       lb x5, 0(x7)
       addi a0, x5, 48
       li a7, 11
       ecall
       addi x7, x7, -1
       bge x7, x8, loop2
       nop

