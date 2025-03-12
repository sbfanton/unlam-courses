# B.24 Escriba una subrutina llamada MaxUnsigned, la cual debe recibir en a0 y en a1 (x10 y x11 respectivamente) 
# dos números sin signo y devolver cual de los dos es el mayor en a0.

.text
    li a0, 100
    li a1, 80
    jal x1, MaxUnsigned
    jal end
    
    MaxUnsigned:
        bgtu a1, a0, set_max
        ret
    
    set_max:
        add a0, a1, x0
        j MaxUnsigned
        
    end:
        addi a7, x0, 1
        ecall
        nop

