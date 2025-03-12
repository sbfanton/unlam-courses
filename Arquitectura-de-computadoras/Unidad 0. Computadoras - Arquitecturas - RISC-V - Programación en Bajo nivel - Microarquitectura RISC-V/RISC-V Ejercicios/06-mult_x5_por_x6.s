# esto simula una multiplicacion de lo que contiene x5 por lo que contiene x6
.text
    li x5, 10
    li x6, 8
    li x7, 0
    
    loop:
        add x7, x7, x5
        addi x6, x6, -1
        bgt x6, x0, loop
        nop