# 2 Dado el vector anterior, escriba un programa que lea cada elemento que conforma el vector, 
# complemente a la base dicho elemento, y finalmente guarde el elemento complementado en la misma 
# posición de memoria donde fue leído

.data
vector: .byte 0x01, 0x10, 0x02, 0xFF, 0x33, 0x90, 0x55
finVector:

.text
la x2, vector
la x3, finVector

loop:
    lb a0, 0(x2)
    #addi a7, x0, 35
    #ecall
    not a0, a0 # invierte todos los bits
    addi a0, a0, 1 # se suma 1 para lograr el complemento a la base
    #addi a7, x0, 35
    #ecall
    addi a7, x0, 34 # se imprime rl complemento en hexa
    ecall
    sb a0, 0(x2)
    addi a0, x0, 10 # salto de linea
    addi a7, x0, 11
    ecall
    addi x2, x2, 1
    blt x2, x3, loop
    j end
    
end:
    nop
