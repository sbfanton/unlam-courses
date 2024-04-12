.data
    numero: .string "9235"
    miles: .word 0,1000,2000,3000,4000,5000,6000,7000,8000,9000
    centena: .word 0,100,200,300,400,500,600,700,800,900
    decena: .word 0,10 ,20, 30, 40, 50, 60, 70, 80, 90
    unidad: .word 0,1 ,2 ,3, 4, 5, 6, 7, 8, 9
.text
    addi x4, x0, 0 #contador
    la x5,numero
    lb x6,0(x5)
    bnez x6, loop
    beqz x6, end
    
    loop:
         addi x4, x4, 1
         addi x5, x5, 1
         lb x6,0(x5)
         bnez x6, loop
         beqz x6, check_digits
    
    check_digits:
        la x5, numero
        addi x12,x0,0
        li x2, 1
        beq x2, x4, un_digito
        li x2, 2
        beq x2, x4, dos_digitos
        li x2, 3
        beq x2, x4, tres_digitos
        li x2, 4
        beq x2, x4, cuatro_digitos
    
    un_digito:
        lb x9, 0(x5) # posicion de las unidades
        addi x9, x9, -48
        #Calculo Unidad
        la x10,unidad
        slli x9,x9,2 
        add x10,x10,x9
        lb x11,0(x10)
        add x12,x12,x11
        beqz x0, end
    
    dos_digitos:
        lb x8,0(x5) # posicion de las decenas
        addi x8,x8,-48
        lb x9, 1(x5) # posicion de las unidades
        addi x9, x9, -48
        #Calculo Decena
        la x10,decena
        slli x8,x8,2 
        add x10,x10,x8
        lb x11,0(x10)
        add x12,x12,x11
        #Calculo Unidad
        la x10,unidad
        slli x9,x9,2 
        add x10,x10,x9
        lb x11,0(x10)
        add x12,x12,x11
        beqz x0, end
    
    tres_digitos:
        lb x7,0(x5) # posicion de las centenas
        addi x7,x7,-48
        lb x8,1(x5) # posicion de las decenas
        addi x8,x8,-48
        lb x9, 2(x5) # posicion de las unidades
        addi x9, x9, -48
        #Calculo Centena
        la x10,centena
        slli x7,x7,2
        add x10,x10,x7
        lh x11,0(x10) 
        add x12,x12,x11
        #Calculo Decena
        la x10,decena
        slli x8,x8,2 
        add x10,x10,x8
        lb x11,0(x10)
        add x12,x12,x11
        #Calculo Unidad
        la x10,unidad
        slli x9,x9,2 
        add x10,x10,x9
        lb x11,0(x10)
        add x12,x12,x11
        beqz x0, end
    
    cuatro_digitos:
        lb x6,0(x5) # posicion de los miles
        addi x6,x6,-48
        lb x7,1(x5) # posicion de las centenas
        addi x7,x7,-48
        lb x8,2(x5) # posicion de las decenas
        addi x8,x8,-48
        lb x9, 3(x5) # posicion de las unidades
        addi x9, x9, -48
        #Calculo Miles
        la x10,miles
        slli x6,x6,2 
        add x10,x10,x6
        lh x11,0(x10)
        add x12,x12,x11
        #Calculo Centena
        la x10,centena
        slli x7,x7,2
        add x10,x10,x7
        lh x11,0(x10) 
        add x12,x12,x11
        #Calculo Decena
        la x10,decena
        slli x8,x8,2 
        add x10,x10,x8
        lb x11,0(x10)
        add x12,x12,x11
        #Calculo Unidad
        la x10,unidad
        slli x9,x9,2 
        add x10,x10,x9
        lb x11,0(x10)
        add x12,x12,x11
        beqz x0, end
        
    end:
        nop
