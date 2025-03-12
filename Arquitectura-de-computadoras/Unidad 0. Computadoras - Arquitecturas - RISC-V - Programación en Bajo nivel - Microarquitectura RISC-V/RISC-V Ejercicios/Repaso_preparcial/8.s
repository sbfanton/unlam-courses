# B.08 Dadas las siguientes instrucciones en Ripes, indique qué valor se muestra en la salida
# “Console” luego de ejecutar las instrucciones. Relacione estos valores con la tabla ASCII.
# Indique qué modificaciones debe hacer a las instrucciones para lograr que imprima “5678”.

.text:
    addi a0,x0,0x30 # 48 en decimal, 0 en ascii
    addi a7,x0,11
    ecall
    addi a0,x0,0x31 # 49 en decimal, 1 en ascii
    addi a7,x0,11
    ecall
    addi a0,x0,0x32 # 50 en decimal, 2 en ascii
    addi a7,x0,11
    ecall
    addi a0,x0,0x33 # 51 en decimal, 3 en ascii
    addi a7,x0,11
    ecall
    addi a0,x0,0x34 # 52 en decimal, 4 en ascii
    addi a7,x0,11
    ecall
    
    addi a0,x0,0xa # salto de linea
    addi a7,x0,11
    ecall
    addi a0,x0,0x35 # 53 en decimal, 5 en ascii
    addi a7,x0,11
    ecall
    addi a0,x0,0x36 # 54 en decimal, 6 en ascii
    addi a7,x0,11
    ecall
    addi a0,x0,0x37 #55 en decimal, 7 en ascii
    addi a7,x0,11
    ecall
    addi a0,x0,0x38 # 56 en decimal, 8 en ascii
    addi a7,x0,11
    ecall