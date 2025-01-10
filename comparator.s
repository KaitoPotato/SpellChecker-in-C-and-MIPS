.data
$string1:
        .asciiz  "my_strcmp(\""
$string2:
        .asciiz  "\", \""
$string3:
        .asciiz  "\") = "

.text

###############################################################################
# main function - Used for environment startup, then calls _main
###############################################################################
main:
        lw      $a0, 0($sp)
        addiu   $a1, $sp, 4
        addiu   $a2, $a1, 4
        sll     $v0, $a0, 2
        addu    $a2, $a2, $v0
        jal     _main
        nop
        li      $v0, 10
        syscall


###############################################################################
# _main function
# This is the actual user-defined main function
###############################################################################
_main:                                  # user program code
        addiu   $sp,$sp,-32             # preserve registers
        sw      $31,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp                 # set frame pointer

	lw $a0, 0($a1)			# argv[1] - first command line parameter in $a0
        lw $a1, 4($a1)			# argv[2] - second command line parameter in $a1       
	jal compare                     # Now call compare function

        move    $sp,$fp                 # restore registers
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32              # clear stack
        jr      $31                     # return (to _main)



###############################################################################
# compare function
# This functions call the my_strcmp function and prints the result
###############################################################################
compare:
        addiu   $sp,$sp,-32
        sw      $31,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        sw      $5,36($fp)

        la      $4,$string1
        jal     printString

        lw      $4,32($fp)
        jal     printString

        la      $4,$string2
        jal     printString

        lw      $4,36($fp)
        jal     printString

        la      $4,$string3
        jal     printString

        lw      $5,36($fp)
        lw      $4,32($fp)
        jal     my_strcmp

        move    $4,$2
        jal     printInt

        li      $4,10                 # 0xa
        jal     printChar

        move    $sp,$fp
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        jr      $31


###############################################################################
# my_strcmp function
# This is where your own string comparison functions goes
###############################################################################
my_strcmp:

        # Initialize result to 0 in $v0 (although not strictly needed here)
        li $v0, 0

        # Main comparison loop
        loop:
        lb  $t0, 0($a0)      # Load byte from s1
        lb  $t1, 0($a1)      # Load byte from s2
        beq $t0, $zero, check_s2_end  # If s1 is at end of string, go to check_s2_end
        bne $t0, $t1, different       # If bytes are different, exit loop to compare
        addiu $a0, $a0, 1   # Increment s1 pointer
        addiu $a1, $a1, 1   # Increment s2 pointer
        j loop              # Jump back to the start of the loop

        # Check if s2 also ended
        check_s2_end:
        beq $t1, $zero, equal         # If s2 is also at end, strings are equal

        # If characters are different or one string ended before the other
        different:
        slt $t2, $t0, $t1   # Set $t2 to 1 if s1 < s2 (i.e., $t0 < $t1)
        beq $t2, $zero, greater_than  # If $t2 is 0, s1 > s2
        li $v0, -1          # Set return value to -1 (s1 < s2)
        j end_function      # Jump to end of function

        greater_than:
        li $v0, 1           # Set return value to 1 (s1 > s2)
        j end_function      # Jump to end of function

        equal:
        li $v0, 0           # Set return value to 0 (strings equal)

        end_function:
        jr      $31         # return
