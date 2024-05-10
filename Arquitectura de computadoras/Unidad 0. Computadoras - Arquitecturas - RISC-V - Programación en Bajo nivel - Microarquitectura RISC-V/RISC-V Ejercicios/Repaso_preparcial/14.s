#B.14 Basado en el ejercicio B.13, realice un programa que imprima por consola el valor del
# número en orden inverso (ej: 127 se imprime como 721). Luego considerando que los strings
# terminan con un carácter nulo (0x00) diseñe un programa que almacene el string “YVAN EHT
# NIOJ” y lo muestre por consola en orden inverso buscando primero la ubicación del caracter
# nulo y recorriendo en sentido inverso el string.
.data
    numero: .string "127"
    frase: .string "YVAN EHT NIOJ"
.text
    la x5,numero
    add x6, x5, x0
    jal x1, find_last_pos
    jal x1, print_reverse
    
    la x5,frase
    add x6, x5, x0
    jal x1, find_last_pos
    jal x1, print_reverse
    
    j end
 
     find_last_pos:
         lb a1, 0(x6)
         addi x6, x6, 1
         bnez a1, find_last_pos
         addi x6, x6, -1
         ret
         
     print_reverse:
         lb a0, 0(x6)
         addi a7, x0, 11
         ecall
         addi x6, x6, -1
         bge x6, x5, print_reverse
         addi a0, x0, 10
         addi a7, x0, 11
         ecall
         ret
         
     end: 
         nop