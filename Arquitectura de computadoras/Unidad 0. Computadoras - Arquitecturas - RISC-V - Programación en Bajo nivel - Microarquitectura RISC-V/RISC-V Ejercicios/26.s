.data
    num1: .word 24
    num2: .word -78
    
.text
    la a0, num1
    la a1, num2
    j max_dir
    
    max_dir:
      lw a0, 0(a0)
      lw a1, 0(a1)
      bgt a0, a1, set_max
      j end
  
    set_max:
        addi a0, x0, 1 
    
    end:
        nop 
