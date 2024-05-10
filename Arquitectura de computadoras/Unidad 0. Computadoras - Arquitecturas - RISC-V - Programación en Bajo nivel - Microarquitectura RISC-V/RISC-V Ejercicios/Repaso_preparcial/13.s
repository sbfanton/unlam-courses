# B.13 Indique qué valores quedan almacenados en x6,x7 y x8. ¿Qué ocurre si en vez de usar lb
# se utiliza lh o lw?
.data
    numero: .string "127"
.text
    la x5,numero
    lb x6,0(x5) 
    lb x7,1(x5)
    lb x8,2(x5)
    
    add a0, x0, x6
    addi a7, x0, 11
    ecall
    
    add a0, x0, x7
    addi a7, x0, 11
    ecall
    
    add a0, x0, x8
    addi a7, x0, 11
    ecall
        
    lh x6,0(x5) # 21
    lh x7,1(x5) # 72
    lh x8,2(x5) # 7
    
    lw x6,0(x5) # 721
    lw x7,1(x5) # 72
    lw x8,2(x5) # 7