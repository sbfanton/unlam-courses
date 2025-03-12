.data
    vector: .word 100,-20,40,-365,-400,65536,1,0

.text
    la x4, vector # se carga la direccion inicial del primer elemento del vector
    lw x5, 0(x4) # se alamcena el primer elemento (palabra) del vector
    add x6, x5, x0 # para almacenar el minimo (comenzamos con el primer elemento)
    
    # se hace uso de slt: set less than
    # 1 si registro1 es menor que registro2, 0 en caso contrario
    
    loop:
        beqz x5, end
        addi x4, x4, 4
        lw x5, 0(x4)
        slt x7, x6, x5    # comparamos si el siguiente elemento es menor que el m�nimo actual
        beqz x7, update_min # si es menor, actualizamos el m�nimo
        j loop             # volvemos al inicio del loop

    update_min:
        add x6, x5, x0
        j loop       
    
    end:
        add a0, x6, x0
        addi a7, x0, 1
        ecall
        nop
   
