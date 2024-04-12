.text
    li x4, 10
    li x5, 1234
    li x6, 0

    loop:
        addi x5, x5, -10
        addi x6, x6, 1
        bge x5, x4, loop
        jal x1, mostrar
        add x5, x0, x6
        li x6, 0 
        bgt x5, x4, loop
        jal x1, mostrar 
       
    volver:
       jalr x0, x1, 0 #ret
       
    mostrar:
        addi a0, x5, 48 # se suma 48 para que coincida con la representacion del numero en ascii
        addi a7, x0, 11
        ecall
        bge x0, x0, volver
        nop  