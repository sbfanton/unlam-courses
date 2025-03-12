.data
    vector: .word 100,-20,40,-365,400,65536,1,0,3,-10 # 10 elementos

.text
    la x1, vector
    addi x5, x0, 10 # cant elementos
    addi x2, x0, 1 # contador elementos
    addi x6, x0, 10 # iteraciones para loop
    addi x7, x0, 1 # para iteracion de impresion por consola de PrintVector
    addi x8, x0, 1 # contador de loop
   
    loop:
      jal x9 pushMax  
      la x1, vector
      jal x9 print_vector
      addi a0, x0, 10
      addi a7, x0, 11
      ecall
      la x1, vector
      addi x5, x5, -1
      addi x2, x0, 1
      addi x7, x0, 1 
      addi x8, x8, 1 
      blt x8, x6, loop
      j end 
    
    pushMax:
     addi x3, x1, 4
     jal x4 max_dir
     addi x1, x1, 4
     addi x2, x2, 1
     blt x2, x5, pushMax
     jalr x0, x9, 0
    
    max_dir:
      lw a0, 0(x1)
      lw a1, 0(x3)
      bgt a0, a1, swap
      jalr x0, x4, 0 
   
    swap:
        sw a0, 0(x3)
        sw a1, 0(x1)
        jalr x0, x4, 0
    
    print_vector: 
        lw a0, 0(x1)
        addi a7, x0, 1
        ecall
        addi x7, x7, 1
        addi x1, x1, 4
        bgt x7, x6, go_back
        addi a0, x0, 44
        addi a7, x0, 11
        ecall
        j print_vector
        
    go_back:
        jalr x0, x9, 0
        
    end:
        nop