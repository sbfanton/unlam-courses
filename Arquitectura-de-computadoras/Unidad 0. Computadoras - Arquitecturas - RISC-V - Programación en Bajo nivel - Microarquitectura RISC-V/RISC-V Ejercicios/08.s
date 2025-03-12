.text
    # este grupo de instrucciones mostrara por consola:
    # 01234, ya que 11 imprime un char, y cada valor en hex aqui es un char en ascii
    # el hex pasado a decimal nos dara el valor en la tabla ascii
    addi a0,x0,0x30
    addi a7,x0,11
    ecall
    addi a0,x0,0x31
    addi a7,x0,11
    ecall
    addi a0,x0,0x32
    addi a7,x0,11
    ecall
    addi a0,x0,0x33
    addi a7,x0,11
    ecall
    addi a0,x0,0x34
    addi a7,x0,11
    ecall
    
    # salto de linea
    addi a0, x0, 0x0A
    addi a7, x0, 11
    ecall
    
    # para que se imprima 5678:
    addi a0,x0,0x35
    addi a7,x0,11
    ecall
    addi a0,x0,0x36
    addi a7,x0,11
    ecall
    addi a0,x0,0x37
    addi a7,x0,11
    ecall
    addi a0,x0,0x38
    addi a7,x0,11
    ecall