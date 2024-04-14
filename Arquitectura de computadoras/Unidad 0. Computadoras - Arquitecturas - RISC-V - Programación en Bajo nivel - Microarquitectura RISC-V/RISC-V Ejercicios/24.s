.text

    addi a0, x0, 90
    addi a1, x0, 789

    max:
        bgtu a1, a0, set_max
        j end
        
    set_max:
        add a0, a1, x0
        
    end:
        nop
   
