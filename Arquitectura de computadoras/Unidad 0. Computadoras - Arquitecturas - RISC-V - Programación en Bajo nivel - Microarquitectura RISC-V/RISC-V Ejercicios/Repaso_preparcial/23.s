# B.23 Escriba una subrutina llamada Max, la cual debe recibir en a0 y en a1 (x10 y x11 respectivamente) dos números signados y devolver cual de los dos es el mayor en a0.

.text
    li a0, 9
    li a1, 90
    jal x1, Max
    jal end
    
    Max:
        bgt a1, a0, set_max
        ret
    
    set_max:
        add a0, a1, x0
        j Max
        
    end:
        addi a7, x0, 1
        ecall
        nop

