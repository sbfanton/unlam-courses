.data
    num1: .word 24
    num2: .word -78
    
.text
    la a0, num1
    la a1, num2
    jal x1, swap
    j end
    
    swap:
        lw x2, 0(a0)
        lw x3, 0(a1)
        sw x2, 0(a1)
        sw x3, 0(a0)
        jalr x0, x1, 0
    
    end:
        nop 
