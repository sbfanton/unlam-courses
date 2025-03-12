# B.02 Escriba las instrucciones necesarias en Ripes para lograr que el registro x5 tenga el
# valor hexadecimal 0x12345678

.text
    # li x5, 0x12345678
    # o bien:
    lui x5, 0x12345
    addi x5, x5, 0x678