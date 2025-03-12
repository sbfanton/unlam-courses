.data
    numero: .string "9871"
    miles: .word 0,1000,2000,3000,4000,5000,6000,7000,8000,9000
    centena: .word 0,100,200,300,400,500,600,700,800,900
    decena: .word 0,10 ,20, 30, 40, 50, 60, 70, 80, 90
    unidad: .word 0,1 ,2 ,3, 4, 5, 6, 7, 8, 9
.text
    #Lectura
    la x5,numero
    lb x6,0(x5) # posicion de los miles
    addi x6,x6,-48
    lb x7,1(x5) # posicion de las centenas
    addi x7,x7,-48
    lb x8,2(x5) # posicion de las decenas
    addi x8,x8,-48
    lb x9, 3(x5) # posicion de las unidades
    addi x9, x9, -48
    
    addi x12,x0,0
    
    #Calculo Miles
    la x10,miles
    slli x6,x6,2 #direccion al byte a palabra
    add x10,x10,x6
    lh x11,0(x10)
    add x12,x12,x11
    
    #Calculo Centena
    la x10,centena
    slli x7,x7,2 #direccion al byte a palabra
    add x10,x10,x7
    lh x11,0(x10) #centena almacena valores mayores al rango [-128:127]
    add x12,x12,x11
   
    #Calculo Decena
    la x10,decena
    slli x8,x8,2 #direccion al byte a palabra
    add x10,x10,x8
    lb x11,0(x10)
    add x12,x12,x11
    
    #Calculo Unidad
    la x10,unidad
    slli x9,x9,2 #direccion al byte a palabra
    add x10,x10,x9
    lb x11,0(x10)
    add x12,x12,x11
    
    # La utilidad de este programa es convertir un número en formato de cadena de caracteres ASCII 
    # en su valor numérico correspondiente. Esto podría ser útil en aplicaciones donde se necesite 
    # manipular o realizar operaciones aritméticas con números representados en forma de texto.
