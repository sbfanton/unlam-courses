.data
    numero: .string "127\n"
    frase: .string "YVAN EHT NIOJ\n"
.text
    la x5, numero
    la x7, numero
    lb x6, 0(x5)
    
    jal x1, loop
    jal x1, mostrar
    
    la x5, frase
    la x7, frase
    lb x6, 0(x5)
    
    jal x1, loop
    jal x1, mostrar
    jal x1, end
    
    loop:
        addi x5, x5, 1
        lb x6, 0(x5)
        bnez x6, loop
        ret
    
    mostrar:
        lb x6, 0(x5)
        add a0, x0, x6
        addi a7, x0, 11
        ecall
        addi x5, x5, -1
        bge x5, x7, mostrar
        ret
        
    end:
        nop