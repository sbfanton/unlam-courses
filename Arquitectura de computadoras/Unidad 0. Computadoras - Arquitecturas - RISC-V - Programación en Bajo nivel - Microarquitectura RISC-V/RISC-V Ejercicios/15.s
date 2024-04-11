.data
    centena: .word 0,100,200,300,400,500,600,700,800,900

.text
    la x5,centena
    addi x6,x0,8
    slli x6, x6, 2
    add x7, x6, x5
    lw x7, 0(x7)
    add a0, x0, x7
    addi a7, x0, 1
    ecall