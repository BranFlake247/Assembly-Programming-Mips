#Author: Brandon Daley

.data
prompt:         .asciiz "Enter the first integer: "
prompt2:        .asciiz "Enter the second integer: "
larger:         .asciiz "larger integer: "
smaller:        .asciiz "smaller integer: "
quotient:       .asciiz "quotient: "
remainder:      .asciiz "remainder: "
newline:        .asciiz "\n"

.text
.globl main

main:

    # prompt for the first integer
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x0000            #OR Immediate, set lower 16 bits of $a0
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print strin               
    syscall
    
    # Read the first integer
    ori $v0, $zero, 5               #OR Immediate, set $v0 to 5 to system call for read an integer
    syscall
    sw $v0, 0($sp)                  #Store word, store the value read into $v0 in the stack
    
    # prompt for the second integer
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x001A            #Load Upper Immediate, Load the upper 16 bits of string address
    syscall
    
    # Read the second integer
    ori  $v0, $zero, 5              #OR Immediate, set $v0 to 5 to system call for read an integer
    syscall
    sw $v0, 4($sp)                  #Store word, store the value read into $v0 in the stack
    
    lw $t0, 0($sp)                  #Load Word, Load the first intege from the stack into $t0
    lw $t1, 4($sp)                  #Load Word, Load the second integer from the stack into $t1
    
    # compare to find the smaller and larger integers
    slt $t2, $t0, $t1               #Set on Less Than, set $t2 to 1 if $t0 is less than $t1, 0 otherwise
    beq $t2, $zero, not_swapped     #Branch Equal, Branch to not swapped if $t2 is zero
        
    sw  $t0, 4($sp)                 #Store Word, store the larger integer $t0 in the stack at offset 4
    sw $t1, 0($sp)                  #Store Word, store the smaller integer $t1 in the stack at offset 0
    j end_comparison                #Jump, Unconditional jump to end comparison

not_swapped:
    sw $t1, 4($sp)                  #Store Word, store the second integer $t1 in the stack at offset 4
    sw $t0, 0($sp)                  #Store Word, store the first integer $t1 in the stack at offset 0
    
end_comparison:
    
    lw $t2, 0($sp)                  #Load Word, Load the first integer from the stack into $t2
    lw $t3, 4($sp)                  #Load Word, Load the second integer from the stack into $t3
    
    div $t2, $t3                    #Divide $t2 by $t3
    mflo $t4                        #Move From LO, Move the quotient from the LO register to $t4
    mfhi $t5                        #Move from HI, Move the  remainder from the HI register to $t5
    
    sw $t4, 8($sp)                  #Store Word, Store teh quotient ($t4) in the stack at ofset 8
    sw $t5,  12($sp)                #Store Word, Store the remainder $t5 in the stack at offset 12
    
    #newline
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x006F            #OR Immediate, set lower 16 bits of $a0
    syscall
    
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x0035            #OR Immediate, set lower 16 bits of $a0
    syscall
    lw $a0, 0($sp)                  #Load Word, Load the first integer from the stack in $a0
    ori $v0, $zero, 1               #OR Immediate, set $v0  to 1 system call to print integer
    syscall
    
    #newline
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x006F            #OR Immediate, set lower 16 bits of $a0
    syscall
    
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x0046            #OR Immediate, set lower 16 bits of $a0
    syscall
    lw $a0, 4($sp)                  #Load Word, load the second integer from the stack into $a0
    ori $v0, $zero, 1               #OR Immediate, set $v0 to 1 system call to print integer
    syscall
    
    #newline
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x006F            #OR Immediate, set lower 16 bits of $a0
    syscall
   
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x0058            #OR Immediate, set lower 16 bits of $a0
    syscall
    lw $a0, 8($sp)                  #Load Word, load the quotient from the stack  into $a0
    ori $v0, $zero, 1               #OR Immediate, set $v0 to 1 to system call for print integer
    syscall
    
    #newline
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x006F            #OR Immediate, set lower 16 bits of $a0
    syscall
   
    ori $v0, $zero, 4               #OR Immediate, set $v0 to 4 to system call to  print string
    lui $a0, 0x1001                 #Load Upper Immediate, Load the upper 16 bits of string address
    ori $a0, $a0, 0x0063            #OR Immediate, set lower 16 bits of $a0
    syscall
    lw $a0, 12($sp)                 #Load Word, load the remainder from the stack  into $a0
    ori $v0, $zero, 1               #OR Immediate, set $v0 to 1 to system call for print integer
    syscall
   
    # Exit
    ori  $v0, $zero, 10             #OR immediate, set $v0 to 10 to system call to exit
    syscall


    
    
    
    
    
    
    

    
    