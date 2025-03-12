.data
    cadena: .string "Largo del vector: "
    vector: .word 100, 200, 20, 10, 3, 50
    finVector: 
    
.text
    la a0, cadena
    li a7, 4 #PrintString
    ecall
    la x5, finVector
    la x6, vector
    sub a0, x5, x6
    srli a0, a0, 2 # desplazamiento a derecha, pensarlo como que lo que hay en a0 (24) se divide por 2 a la 2
    #Ajuste de bytes a palabras
    li a7, 1
    ecall