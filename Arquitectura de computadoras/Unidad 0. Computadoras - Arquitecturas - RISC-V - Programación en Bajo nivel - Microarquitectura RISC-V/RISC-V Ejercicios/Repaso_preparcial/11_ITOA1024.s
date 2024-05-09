# B.11 Escriba el programa “ITOA1024.s” basado en el punto B.09, de forma tal que el número
# impreso por consola sea “1234” y no “4321”. Recomendamos almacenar cada dígito en
# memoria e ir recorriendo la memoria en orden inverso para imprimir por consola. Puede crear
# en memoria .data una variable de 4 bytes que almacene ceros inicialmente y utilizar este
# espacio de memoria para invertir el número.
.data
    num: .word 0

.text
    li x5, 1234
    li x6, 10
    li x7, 0
    la x8 num
    la x9 num
    
    loop:
        sub x5, x5, x6
        addi x7, x7, 1
        bgt x5, x6, loop
        sb x5, 0(x8)
        addi x8, x8, 1
        add x5, x0, x7
        li x7, 0
        bgt x5, x6, loop 
        sb x5, 0(x8)
        
    loop_print:
        lb x7, 0(x8)
        add a0, x0, x7
        addi a7, x0, 1
        ecall
        addi x8, x8, -1
        bge x8, x9, loop_print
nop
        