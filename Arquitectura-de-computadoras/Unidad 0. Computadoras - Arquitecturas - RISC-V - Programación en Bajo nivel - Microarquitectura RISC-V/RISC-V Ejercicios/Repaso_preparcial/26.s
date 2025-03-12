# B.26 Escriba una subrutina llamada MaxDir. La misma va a recibir en a0 la dirección de un
# dato (número signado) y en a1 la dirección de otro dato (número signado). La subrutina debe
# retornar en a0 el valor 1 si el dato almacenado en la dirección de memoria apuntada por a0 es
# mayor que el dato almacenado en la dirección de memoria apuntada por a1.

.data
num1: .word 10
num2: .word -2

.text
 la a0, num1
 la a1, num2
 jal x1, MaxDir
 j end
 
 MaxDir:
     lw a0, 0(a0)
     lw a1, 0(a1)
     bgt a0, a1, set_one
     ret
     
 set_one:
     addi a0, x0, 1
     ret
 
 end: 
     nop
     
     
     
