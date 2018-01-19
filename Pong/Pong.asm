# Important: do not put any other data before the frameBuffer
# Also: the Bitmap Display tool must be connected to MARS and set to
#   unit width in pixels: 8
#   unit height in pixels: 8
#   display width in pixels: 256
#   display height in pixels: 256
#   base address for display: 0x10010000 (static data)
.data
frameBuffer:

.text
# Example of drawing a Column; x-coordinate is set by $a0, 
# the pattern is set by the 32 bits in $a1
	
#initialize
	addi $s0 $s0 -1 	#xdelta
	addi $s1 $s1 0 		#xold
	addi $s2 $s2 0  	#yold
	addi $s3 $s3 29 	#x
	addi $s4 $s4 15 	#y
	addi $s5 $s5 0		#yacc
	addi $s6 $s6 1		#ydelta
	addi $s7 $s7 2		#ythre
	addi $k0 $k0 0		#score
	addi $k1 $k1 15		#paddley
	
#iteration

	add $s1 $s3 0
	add $s2 $s4 0
	add $s3 $s3 $s0
	addi $s5 $s5 1
	blt $s6 $s5 jump
	jump:
		li $s5 0
		add $s4 $s4 $s6

	
	



SetColumn:
  # $a0 is x (must be within the display)
  # $a1 is column encoding
	add $t7, $a1, 0
	li $t0, -1
	li $t6,  0
	la $t1, frameBuffer
	li $t2, 0
   SetColumn_forloop:
	add $t3, $t2,$t2
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t1
	add $t4, $a0, $a0
	add $t4, $t4, $t4
	add $t4, $t4, $t3
	andi $t8, $t7, 2147483648
	bne $t8, $zero, SetColumn_elsecase
	sw $t6,($t4)
	j SetColumn_skip_else
      SetColumn_elsecase:
	sw $t0,($t4)
      SetColumn_skip_else:
	addu $t7, $t7, $t7
	addi $t2, $t2, 1
	blt $t2, 33, SetColumn_forloop
	jr $ra

