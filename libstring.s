.text


###############################################################################
# strcmp function
# Compares two strings
# Parameters: first string in $a0; second string in $a1
# Return value:  $v0
###############################################################################
.globl strcmp
strcmp:

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
        jr      $31


###############################################################################
# strncpy function
# Copies the first num characters of source to destination.
# Parameters: destination string in $a0, source string in $a1, num in $a2
###############################################################################
.globl strncpy
strncpy:
        move    $t2, $a0          # $t2 preserves the original address of destination

        # Initialize index i in $t0 to 0
        move    $t0, $zero         

        # First loop to copy 
        loop_strncpy: 
        # Check if i < num
        bge     $t0, $a2, end_loop # if i >= num, break loop
        # Load byte from source[i] into $t1
        lb      $t1, 0($a1)        # $t1 = source[i]

        # Check if source[i] == '\0'
        beq     $t1, $zero, fill_loop   # if source[i] == '\0', go to fill rest with '\0'

        # Store byte to destination[i]
        sb      $t1, 0($a0)        # destination[i] = source[i]

        # Increment source and destination pointers
        addi    $a1, $a1, 1        # source++
        addi    $a0, $a0, 1        # destination++

        # Increment index i
        addi    $t0, $t0, 1        # i++

        # Loop back
        j       loop_strncpy

        # Second loop to fill terminator
        fill_loop:
        # Check if i < num
        bge     $t0, $a2, end_loop # if i >= num, exit loop

        # Store '\0' to destination[i]
        sb      $t1, 0($a0)        # destination[i] = '\0'

        # Increment destination pointer
        addi    $a0, $a0, 1        # destination++

        # Increment index i
        addi    $t0, $t0, 1        # i++

        j fill_loop

        # End
        end_loop:
        # Set return value to preserved destination pointer, which is $t2
        move    $v0, $t2           # return destination

        jr      $31
    

###############################################################################
# strcspn function
# Calculates the length of the initial segment of str1 which consists entirely of characters not in str2.
# Inputs: str1 in $a0; str2 in $a1
# Output: integer in $v0
###############################################################################
.globl strcspn
strcspn:

        # Initialize pointers for str1 and str2
        move    $t0, $a0          # $t0 will hold the start of str1 (pointer p in C)
        move    $t1, $a1          # $t1 will hold the start of str2 (pointer spanp in C)
        
        # Main loop to iterate over each character in str1
        main_loop:
        lb      $t2, 0($t0)       # Load the current character from str1 into $t2 (c = *p++)
        addi    $t0, $t0, 1       # Increment the str1 pointer (p++)

        # Nested loop to compare with each character in str2
        move    $t3, $t1          # preserve starting address of str2 by using a copy address $t3
        
        compare_loop:
        lb      $t4, 0($t3)       # Load the current character from str2 into $t4 (sc = *spanp++)
        addi    $t3, $t3, 1       # Increment the str2 pointer (spanp++)

        # Check if characters match
        beq     $t2, $t4, found_match # If sc == c, we found a match

        # Check if we reached the end of str2
        bne     $t4, $zero, compare_loop # If sc != '\0', continue comparing

        # If no match found and end of str2 reached, continue with next character of str1
        j       main_loop

        found_match:
        # Calculate the offset of the matching character from the start of str1
        subu    $v0, $t0, $a0     # Calculate (p - str1)
        subi    $v0, $v0, 1       # then minus 1 to make it (p - 1 - str1)
        
        jr      $31

###############################################################################
# strlen function
# Computes and return the length of a null-terminated string
# Parameters: address of string in $a0
# Return values: string length in $v0
###############################################################################
.globl strlen
strlen:
	li $t0, 0 				# initialize the count to zero
strlen_loop:
	lb $t1, 0($a0) 				# load the next character into t1
	beqz $t1, strlen_exit 			# check for the null character
	addi $a0, $a0, 1 			# increment the string pointer
	addi $t0, $t0, 1 			# increment the count
	j strlen_loop 				# return to the top of the loop
strlen_exit:
	move $v0, $t0				# copy return value to $v0
	jr $ra


###############################################################################
# strcpy function
# Copies the string pointed by source into the array pointed by destination 
# Parameters: destination string in $a0, source string in $a1
###############################################################################
.globl strcpy
strcpy:
	addi $sp, $sp, -4			# allocate 4 bytes on stack
	sw $s0, 0($sp) 				# store s0 at offset 0 on stack
	
	add $s0, $zero, $zero 			# set i to 0, i = 0;
	
	strcpy_while:
	   	add $t1, $a1, $s0 		# load address of y[i], and sets to a temporal register
	   	lbu $t2, ($t1) 			# load byte unsigned, puts the character into y[i] // $t2 = y[i]
	
	   	add $t3, $s0, $a0 		# load address of x[i], and sets to a temporal register
	   	sb $t2, ($t3) 			# store byte of y[i] to x[i] // x[i] = y[i]
	
	   	beq $t2, $zero, strcpy_out_while 	# if x[i] == '\0' end while
	   	addi $s0, $s0, 1 		# i++;
	   	j strcpy_while 			# jumps to while
	
	strcpy_out_while:
		lw $s0, 0($sp) 			# load contents of $s0 to its default value
		addi $sp, $sp, 4 		# pop 4 bytes off stack
		jr $ra  			# return with register address value to whoever called this


###############################################################################
# strchr function
# Returns a pointer to the first occurrence of the character c in the string
# Parameters: string in $a0, character in $a1
###############################################################################
.globl strchr
strchr:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        move    $2,$4
        sw      $5,12($fp)
$strchr_L4:
        lb      $3,0($2)
        nop
        move    $4,$3
        lw      $3,12($fp)
        nop
        bne     $3,$4,$strchr_L2
        nop

        b       $strchr_L3
        nop

$strchr_L2:
        move    $3,$2
        addiu   $2,$3,1
        lb      $3,0($3)
        nop
        bne     $3,$0,$strchr_L4
        nop

        move    $2,$0
$strchr_L3:
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        jr      $31
        nop


