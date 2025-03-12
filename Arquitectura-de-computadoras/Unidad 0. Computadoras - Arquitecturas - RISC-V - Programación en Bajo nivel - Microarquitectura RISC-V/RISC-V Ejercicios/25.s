.data
    vector: .word 100,-20,40,-365,-400,65,501,0

.text
    la x4, vector # se carga la direccion inicial del primer elemento del vector
    lw a1, 0(x4) # se alamcena el primer elemento (palabra) del vector
    add a0, a1, x0 # para almacenar el maximo (comenzamos con el primer elemento)
    
    loop:
        beqz a1, end
        addi x4, x4, 4
        lw a1, 0(x4)
        beqz x0, max
        j loop             # volvemos al inicio del loop

     max:
        bgt a1, a0, set_max
        j loop
        
    set_max:
        add a0, a1, x0
        j loop     
    
    end:
        addi a7, x0, 1
        ecall
        nop

