# ejemplo de acceso a pos de memoria 
# (RISC-V usa little endian)
# en este ejemplo estaria almacenando 4321

.data
    numero: .word 0

.text
    li x6, 1
    li x4, 2
    li x7, 3
    li x8, 4
    la x5, numero
    sb x6, 0(x5)
    sb x4, 1(x5)
    sb x7, 2(x5)
    sb x8, 3(x5)
    
    lb a0, 0(x5)
    li a7, 1
    ecall
    lb a0, 1(x5)
    li a7, 1
    ecall
    lb a0, 2(x5)
    li a7, 1
    ecall
    lb a0, 3(x5)
    li a7, 1
    ecall
    
    
     