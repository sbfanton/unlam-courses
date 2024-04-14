.data
    vector: .word 10,20,40,365,400,65536,14,0

.text
    la x4, vector # se carga la direccion inicial del primer elemento del vector
    lw x5, 0(x4) # se almacena el primer elemento (palabra) del vector
    beqz x5, end
    add x6, x5, x0 # para almacenar el minimo (comenzamos con el primer elemento)
    
    # se hace uso de sltu: set less than unsigned (lo mismo que slt pero para numeros no signados)
    # 1 si registro1 es menor que registro2, 0 en caso contrario
    
    loop:
        addi x4, x4, 4
        lw x5, 0(x4)
        beqz x5, end
        sltu x7, x6, x5    # comparamos si el siguiente elemento es mayor que el maximo actual
        beqz x7, update_min # si es mayor, actualizamos el maximo
        j loop             # volvemos al inicio del loop

    update_min:
        add x6, x5, x0
        j loop       
    
    end:
        add a0, x6, x0
        addi a7, x0, 1
        ecall
        nop
   
