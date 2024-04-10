.text
    li x4, 10
    li x5, 1234
    li x6, 0
    li x7, 1

    loop:
        addi x5, x5, -10
        addi x6, x6, 1
        bge x5, x4, loop
        jal x1, mostrar
        add x5, x0, x6
        li x6, 0
        bgt x5, x7, loop
        jal x1, mostrar 
       
    volver:
       jalr x0, x1, 0 #ret
       
    mostrar:
        add a0, x0, x5
        addi a7, x0, 1
        ecall
        bgt x5, x7, volver
        nop  