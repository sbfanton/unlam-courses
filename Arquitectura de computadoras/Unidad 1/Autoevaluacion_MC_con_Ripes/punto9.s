.data
    resultado: .word 0
.text
    la x11, resultado
    li x5, 1234
    li x6, 10
    li x7, 0
    loop:
        sub x5, x5, x6
        addi x7, x7, 1
        bge x5, x6, loop
        addi x5, x5, 0x30
        sw x5, 0(x11)
        addi x11, x11, 4
        add x5, x0, x7
        addi x7, x0, 0
        bge x5, x6, loop
    addi x5, x5, 0x30
    sw x5, 0(x11)
    la x12, resultado
    imprime:
        lw x7, 0(x11)
        addi x11, x11, -4
        add a0, x0, x7
        addi a7, x0, 11
        ecall
    bge x11, x12, imprime
    fin:
        beq x0,x0,fin