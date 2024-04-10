.text
    li x5, -25
    srai x5, x5, 3
    
    # 25 = 0 11001 , -25 = 1 00111
    # corriendo 3 bits a la derecha:
    # 1 11100 -> ya que mantiene el signo
    # tomando los ultimos 4 bits: 1100 = 12 en decimal = c en hexa
    # es correcto ya que el resultado en hexa completo con los 32 bits da: 0xfffffffc

    