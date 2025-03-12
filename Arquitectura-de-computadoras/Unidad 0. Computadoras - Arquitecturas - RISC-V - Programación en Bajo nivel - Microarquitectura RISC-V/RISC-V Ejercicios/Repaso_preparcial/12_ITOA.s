# B.12 Escriba el programa “ITOA.s” basado en los puntos anteriores pero ahora el número a
# convertir no es solamente el 1024 en x5 sino que puede tener cualquier valor positivo en x5.
# Ejemplo: Si x5=0xBC614E , entonces debe imprimir por consola el 12345678.
.data
    num: .word 0

.text
    li x5, 0x2FC
    li x6, 10
    li x7, 0
    la x8 num
    la x9 num
    
    loop:
        sub x5, x5, x6
        addi x7, x7, 1
        bge x5, x6, loop
        sb x5, 0(x8)
        addi x8, x8, 1
        add x5, x0, x7
        li x7, 0
        bge x5, x6, loop 
        sb x5, 0(x8)
        
    loop_print:
        lb x7, 0(x8)
        addi a0, x7, 48
        addi a7, x0, 11
        ecall
        addi x8, x8, -1
        bge x8, x9, loop_print
nop
        