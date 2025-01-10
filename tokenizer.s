.data
$string1:
        .asciiz  "Input = "

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

	la	$a0, $string1
	jal 	printString
	lw 	$a0, 0($a1)		# argv[1] - first command line parameter in $a0
	jal	printString
        lw      $a0, 0($a1)             # argv[1] - first command line parameter in $a0
	jal 	tokenize                # Now call tokenize function
	jal 	printLn

        move    $sp,$fp                 # restore registers
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32              # clear stack
        jr      $31                     # return (to _main)



###############################################################################
# tokenize function
# This functions tokenizes the input string and prints out individual tokens
###############################################################################
tokenize:

        # Initialize and preserve registers
        addiu   $sp, $sp, -32     # Allocate stack space for local variables and saved registers
        sw      $31, 28($sp)      # Save return address
        sw      $fp, 24($sp)      # Save $fp
        sw      $s0, 20($sp)      # Save $s0
        sw      $s1, 16($sp)      # Save $s1
        sw      $s2, 12($sp)      # Save $s2
        sw      $s3, 8($sp)       # Save $s3
        sw      $s4, 4($sp)       # Save $s4
        sw      $s5, 0($sp)       # Save $s5

        # Initialize local variables
        li      $s0, 0            # offset = 0
        la      $s1, separators   # Load address of separators
        la      $s3, token        # Load address of the token buffer
        move    $s4, $a0          # preserve input

        #for format-matching purposes
        jal     printLn 

        main_loop_start:
        add     $a0, $s4, $s0     # $a1 = str + offset
        move    $a1, $s1          # $a2 = address of separators
        jal     strcspn           # Call strcspn to find the first token length
        move    $s2, $v0          # Store length of token in $s2 (basically acts as 'first')

        # Check if we found a token
        bnez    $s2, process_token  # If length is non-zero, process the token
        j       update_offset       # Otherwise, skip processing and update offset

        process_token:
        move    $a0, $s3          # $a0 = token buffer (destination)
        add     $a1, $s4, $s0     # $a1 = str + offset for strncpy
        move    $a2, $s2          # $a2 = length of token (number of chars to copy)
        jal     strncpy           # Copy token to buffer
        # Null-terminate the token
        add     $t3, $s3, $s2     # Calculate address to null-terminate the token
        sb      $zero, 0($t3)     # Null-terminate the token
        
        # Print the token 
        la      $a0, msg_token    # Load address of "Token = "
        jal     printString       # Print "Token = "
        move    $a0, $s3          # Set $a0 to address of the token
        jal     printString       # Print the token
        jal     printLn           # Print a newline

        update_offset:
        add     $s0, $s0, $s2     # Increment offset by the length of the token
        addi    $s0, $s0, 1       # Skip past the separator
        add     $a0, $s4, $s0     # Prepare $a1 for strlen (str + offset)
        subi    $a0, $a0, 1       # str + offset - 1
        jal     strlen            # Call strlen to check remaining length
        bnez    $v0, main_loop_start # If not at end of string, repeat loop

        # Restore registers and return
        lw      $31, 28($sp)      # Restore $ra
        lw      $fp, 24($sp)      # Restore $fp
        lw      $s0, 20($sp)      # Restore $s0
        lw      $s1, 16($sp)      # Restore $s1
        lw      $s2, 12($sp)      # Restore $s2
        lw      $s3, 8($sp)       # Restore $s3
        lw      $s4, 4($sp)       # Restore $s4
        lw      $s5, 0($sp)       # Restore $s5
        addiu   $sp, $sp, 32      # Deallocate stack space
        jr      $31

.data
        separators: .asciiz " ()[].,;?!:\"#0123456789"
        token: .space 30          # Allocate 30 bytes for token buffer
        msg_token: .asciiz "Token = "