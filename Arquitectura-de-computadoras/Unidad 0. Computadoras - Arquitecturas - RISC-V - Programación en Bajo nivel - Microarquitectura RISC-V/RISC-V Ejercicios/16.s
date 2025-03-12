.data
    numero: .string "987"
    centena: .word 0,100,200,300,400,500,600,700,800,900
    decena: .word 0,10 ,20, 30, 40, 50, 60, 70, 80, 90
    unidad: .word 0,1 ,2 ,3, 4, 5, 6, 7, 8, 9
.text
    #Lectura
    la x5,numero
    lb x6,0(x5)
    addi x6,x6,-48
    lb x7,1(x5)
    addi x7,x7,-48
    lb x8,2(x5)
    addi x8,x8,-48
    
    #Calculo Centena
    addi x9,x0,0
    la x10,centena
    slli x6,x6,2 #direccion al byte a palabra
    add x10,x10,x6
    lh x11,0(x10) #centena almacena valores mayores al rango [-128:127]
    add x9,x9,x11
   
    #Calculo Decena
    la x10,decena
    slli x7,x7,2 #direccion al byte a palabra
    add x10,x10,x7
    lb x11,0(x10)
    add x9,x9,x11
    
    #Calculo Unidad
    la x10,unidad
    slli x8,x8,2 #direccion al byte a palabra
    add x10,x10,x8
    lb x11,0(x10)
    add x9,x9,x11
    
    #x9 tiene al final de la ejecucion el valor en decimal 127, con 127 en el string
    #x9 tiene al final de la ejecucion el valor en decimal 987, con 987 en el string
    
    # La utilidad de este programa es convertir un número en formato de cadena de caracteres ASCII 
    # en su valor numérico correspondiente. Esto podría ser útil en aplicaciones donde se necesite 
    # manipular o realizar operaciones aritméticas con números representados en forma de texto.
