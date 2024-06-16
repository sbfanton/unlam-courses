.data
    cadena: .string "Trabajo practico de memoria cache en Ripes"

.text
    la x5, cadena
    salto:
        lb x6, 0(x5)
        add a0, x0, x6
        addi a7, x0, 11
        ecall
        addi x5, x5, 1
        bne x6, x0, salto
    fin:
        beq x0,x0,fin