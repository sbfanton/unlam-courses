# B.28 Dado un vector de 10 elementos:
# .data
# vector: .word 100,-20,40,-365,400,65536,1,0,3,-10
# Escriba una subrutina llamada PrintVector, la cual reciba en a0 la dirección de comienzo del
# vector y en a1 la cantidad de elementos del mismo. Imprima por consola los elementos del
# vector separados por coma (ej: 100, -20, 40, -365, 400, 65536, 1, 0, 3, -10 ).

.data
vector: .word 100,-20,40,-365,400,65536,1,0,3,-10
finVector:
    
.text
la a0, vector
la x2, finVector 
sub x2, x2, a0
srai a1, x2, 2
add x2, x0, x0
jal x1, print_vector
jal x1, end

print_vector:
    beqz x2, first_it
    lw a0, 0(x3)
    addi a7, x0, 1
    ecall
    addi x3, x3, 4
    bne x2, a1, print_coma
    ret
    
first_it:
    add x3, a0, x0
    addi x2, x2, 1
    j print_vector
    
print_coma:
    addi a0, x0, 44
    addi a7, x0, 11
    ecall
    addi x2, x2, 1
    j print_vector
    
end:
    nop