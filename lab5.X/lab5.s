.set noreorder
.global main
# Begin the .text segment of the assembly file
.text
main: # Label for the main() function in C

    la $a0, msg1 # put msg1 address in register $s0    
    jal capitalization
    add $0, $0, $0 # branch delay slot, does nothing!
    la $a0, msg2
    jal capitalization
    add $0, $0, $0 # branch delay slot, does nothing!
   
capitalization:
    li $t2, 97
    li $t3, 122

loop:
    add $t0, $a0, $s5 # Calculate memory addr of str[count]
    lbu $t1, 0($t0) # Load character into t1
    beq $t1, $0, done # Stop if character '\0'
    
    
    slt $t4, $t1, $t2
    slt $t5, $t3, $t1
    or $t6, $t4, $t5
    
    bne $t6, $0, Next
    addi $t1, $t1, -32
    
    sb $t1, 0($a0)
    
Next:
    addi $a0, $a0, 0x1
    j loop
    add $0, $0, $0 # branch delay slot, does nothing!
done:
    jr $ra
    add $0, $0, $0 # branch delay slot, does nothing!
    j done
    add $0, $0, $0 # branch delay slot, does nothing!
    
    
    
# Begin the .data segment of the assembly file
.data
msg1: # Label for the following data element
.asciz "hello" # Defines an String with the value "hello"
msg2:
.asciz "I wAS working in the LAB late ONE Night" # Defines an String with the value "hello" 

