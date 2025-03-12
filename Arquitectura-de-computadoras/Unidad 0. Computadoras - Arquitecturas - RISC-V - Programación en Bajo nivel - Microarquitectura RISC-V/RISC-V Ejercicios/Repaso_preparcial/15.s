# B.15 Se define un vector de 10 elementos (cada uno de 32 bits) llamado centena de la
# siguiente forma:
# Dado que x5 posee la dirección de comienzo del vector, y x6=8, escriba las instrucciones
# necesarias para que x7 obtenga el número 800 (almacenado en el vector). Recuerde que el
# direccionamiento en RISC-V es al byte, por ende la palabra 8 de un vector se encuentra
# almacenada en la dirección 8*4 relativa al comienzo del vector.

.data
    centena: .word 0,100,200,300,400,500,600,700,800,900

.text
    la x5,centena
    addi x6,x0,8
    slli x6, x6, 2 # multiplica x6 por 2 a la 2
    add x5, x5, x6
    lw x7, 0(x5)