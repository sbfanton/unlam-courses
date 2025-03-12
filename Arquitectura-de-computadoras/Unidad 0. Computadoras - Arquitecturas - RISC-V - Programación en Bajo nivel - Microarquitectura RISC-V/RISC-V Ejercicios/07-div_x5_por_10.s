
# simula la division de lo que esta en x5 por 10
.text
    li x5, 234
    li x7, 0
    li x6, 10
    
    bge x5, x0, loop
    
    loop:
        addi x5, x5, -10
        addi x7, x7, 1
        bge x5, x6, loop
        nop
    
    add x8, x5, x0