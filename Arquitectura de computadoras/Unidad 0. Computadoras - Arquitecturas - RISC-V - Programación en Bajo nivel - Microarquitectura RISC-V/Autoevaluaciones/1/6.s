.text
    li x5, 10
    li a7, 1
    li a0, 0
    
    loop:
        ecall
        addi x5, x5, -1
        addi a0, a0, 1
        bgtz x5, loop
        
        nop