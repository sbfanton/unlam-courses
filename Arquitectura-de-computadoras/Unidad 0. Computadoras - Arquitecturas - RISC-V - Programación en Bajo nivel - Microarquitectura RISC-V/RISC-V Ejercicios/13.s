.data
    numero: .string "127"
.text
    la x5, numero # el string es 3 caracteres, es decir 3 bytes y el 4to byte es cero
    
    # carga 1 byte
    lb x6,0(x5) # 49 en decimal, 0x31 (en ASCII es 1) alineado
    lb x7,1(x5) # 50 en decimal, 0x32 (en ASCII es 2) alineado
    lb x8,2(x5) # 55 en decimal, 0x37 (en ASCII es 7) alineado
    
    # carga 2 bytes
    lh x6,0(x5) # 0x3231 alineado
    lh x7,1(x5) # 0x3732 alineado
    lh x8,2(x5) # 0x0037 alineado
    lh x8,3(x5) # 0x0000 NO alineado
    
    # carga 4 bytes
    lw x6,0(x5) # 0x00373231 alineado
    lw x7,1(x5) # 0x00003732 NO alineado
    lw x8,2(x5) # 0x00000037 NO alineado