# B.27 Escriba una subrutina llamada Swap. La misma va a recibir en a0 la dirección de un dato
# (número signado) y en a1 la dirección de otro dato (número signado). La subrutina debe
# intercambiar el contenido de ambos. Ej: Si a0=0x10000000 , quiere decir que en la dirección
# de memoria 0x1000000 existe un dato (supongamos -10). Luego si a1=0x10000004, quiere
# decir que en 0x10000004 existe otro dato (supongamos 5). Si se llama a la subrutina con esas
# referencias a memoria la misma debe retornar habiendo guardado 5 en 0x10000000 y -10 en
# 0x10000004.

.data
num1: .word 10
num2: .word -3
    
.text
    la a0, num1
    la a1, num2
    jal x1, Swap
    jal x1, Print
    jal x1, end
    
    Swap:
        lw x2, 0(a0)
        lw x3, 0(a1)
        sw x2, 0(a1)
        sw x3, 0(a0)
        ret
        
    Print:
        lw a0, 0(a0)
        addi a7, x0, 1
        ecall
        addi, a0, x0, 10
        addi a7, x0, 11
        ecall
        lw a0, 0(a1)
        addi a7, x0, 1
        ecall
        ret
        
    end:
        nop
