.data
    vector: .word 100,-20,40,-365,400,65536,1,0,3,-10

.text
    li x2, 9 #cantidad de elementos del vector (consideramos el elemento 0)
    add x3, x0, x0 #contador
    la x4, vector # se carga la direccion inicial del primer elemento del vector
    lw x5, 0(x4) # se alamcena el primer elemento (palabra) del vector
    add x6, x5, x0 # para almacenar el minimo (comenzamos con el primer elemento)
    
    loop:
        beq x3, x2, end
        addi x4, x4, 4
        lw x5, 0(x4)
        slt x7, x6, x5    # comparamos si el siguiente elemento es menor que el mínimo actual
        beqz x7, update_min # si es menor, actualizamos el mínimo
        addi x3, x3, 1
        j loop             # volvemos al inicio del loop

    update_min:
        add x6, x5, x0
        addi x3, x3, 1   # incrementamos el índice
        j loop       
    
    end:
        add a0, x6, x0
        addi a7, x0, 1
        ecall
        nop
   
