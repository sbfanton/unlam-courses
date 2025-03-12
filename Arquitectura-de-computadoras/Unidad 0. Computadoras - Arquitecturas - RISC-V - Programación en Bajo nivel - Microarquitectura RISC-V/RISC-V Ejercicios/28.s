.data
    vector: .word 100,-20,40,-365,400,65536,1,0,3,-10

.text
    la a0, vector
    addi a1, x0, 10
    add x2, x0, x0
    
    print_vector: 
        beqz x2, first_it
        lw a0, 0(x3)
        addi a7, x0, 1
        ecall
        addi x2, x2, 1
        addi x3, x3, 4
        bgt x2, a1, end
        addi a0, x0, 44
        addi a7, x0, 11
        ecall
        j print_vector
        
    first_it:
        add x3, a0, x0
        addi x2, x2, 1
        j print_vector
        
    end:
        nop