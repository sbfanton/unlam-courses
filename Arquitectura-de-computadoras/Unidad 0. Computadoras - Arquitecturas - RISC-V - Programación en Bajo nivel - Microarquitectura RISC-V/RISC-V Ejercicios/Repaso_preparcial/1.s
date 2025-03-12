# B.01 Escriba la instrucción necesaria en Ripes para lograr que el registro x5 tenga el valor
# hexadecimal 0x000003FF (note que 3FF se codifica con menos de 12 bits)

.text
    # li x5, 0x000003FF
    # o bien:
    lui x5, 0x00000
    addi x5, x5, 0x3FF