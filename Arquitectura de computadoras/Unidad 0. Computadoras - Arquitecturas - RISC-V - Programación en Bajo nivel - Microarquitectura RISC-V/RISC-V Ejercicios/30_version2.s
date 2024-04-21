.data
    vector: .word 100,-20,40,-365,400,65536,1,0,3,-10 # 10 elementos

.text
    la x1, vector
    addi x5, x0, 10
    addi x2, x0, 1 # contador
    
   loop:
     addi x3, x1, 4
     jal x4 pushMax
     addi x1, x1, 4
     addi x2, x2, 1
     blt x2, x5, loop
     la x1, vector
     j print_vector
    
   pushMax:
      lw a0, 0(x1)
      lw a1, 0(x3)
      bgt a1, a0, exit_pushMax
      sw a0, 0(x3)
      sw a1, 0(x1)
      beqz x0, exit_pushMax
        
    exit_pushMax:
        jalr x0, x4, 0 
    
    print_vector: 
        lw a0, 0(x1)
        addi a7, x0, 1
        ecall
        addi x2, x2, -1
        addi x1, x1, 4
        beqz x2, end
        addi a0, x0, 44
        addi a7, x0, 11
        ecall
        j print_vector
        
    end:
        nop