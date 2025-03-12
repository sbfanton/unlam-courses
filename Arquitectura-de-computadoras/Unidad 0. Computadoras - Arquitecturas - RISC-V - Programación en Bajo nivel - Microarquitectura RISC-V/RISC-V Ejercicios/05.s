.text
    li x7, 100 # valor inicial en x7
    li x8, 10
    
    loop:
        addi x7, x7, 1
        addi x8, x8, -1
        bge x8, x0, loop
        nop
    # valor final de x7 al salir del loop: 111, pues el 0 se considero una iteracion extra