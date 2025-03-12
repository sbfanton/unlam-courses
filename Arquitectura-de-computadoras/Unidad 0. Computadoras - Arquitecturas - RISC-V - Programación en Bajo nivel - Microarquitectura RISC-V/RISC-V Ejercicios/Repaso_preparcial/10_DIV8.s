# B.10 Escriba un programa llamado “DIV8.s”. El mismo debe tomar un valor en el registro x5 y
# dividirlo por 8. NO se puede usar el método de restas sucesivas, y el mismo debe funcionar
# para valores positivos o negativos. Ej: si x5 = -25, el resultado es -3. Repase la instrucción
# SRAI.

.text
    li x5, -32
    srai x5, x5, 3 # divide x5 por 2 a la 3, o sea por 8
    add a0, x0, x5
    addi a7, x0, 1
    ecall