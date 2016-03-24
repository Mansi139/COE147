#University of Pittsburgh
#COE-147 Project Euler 150
#Instructor: Kartik Mohanram
#Teaching Assistants: Poovaiah Palangappa $ Shivam Swami
#-------------------------------------------------------



#Submitted by: Manasi Thakkar    *Fill this section with your name*


#------BEGIN--------
#---Uncomment for running the actual problem (Euler 150)---
#.include "euler150_test.asm"
#--------------------------------------------------


.data
#Uncomment ONLY ONE testcase (test and sol) at a time.
#--------------------TEST CASE SUITE---------------------begin
#TEST-1 
#test: .word 4, 0, -3, -4, 1, 7, 2, 3, 5, 6, 7
#sol: .word -7

#TEST-2 
#test: .word 10, 273519, -153582, 450905, 5108, 288723, -97242, 394845, -488152, 83831, 341882, 301473, 466844, -200869, 366094, -237787, 180048, -408705, 439266, 88809, 499780, -104477, 451830, 381165, -313736, -409465, -17078, -113359, 13804, 455019, -388898, 359349, -355680, 89743, 127922, 30841, 229524, -480269, -345658, 163709, -166968, 310679, 194330, 70849, -516036, -411781, -491602, 523333, 293360, -262753, -235646, -181751, -477980, 275459, 459414, 332301
#sol: .word -1495491

#TEST-3 
#test: .word 7, 273519, -153582, 450905, 5108, 288723, -97242, 394845, -488152, 83831, 341882, 301473, 466844, -200869, 366094, -237787, 180048, -408705, 439266, 88809, 499780, -104477, 451830, 381165, -313736, -409465, -17078, -113359, 13804 
#sol: .word -488152

#TEST-4 
#------Test case for the example given in www.ProjectEuler.net 150
test: .word 6, 15, -14, -7, 20, -13, -5, -3, 8, 23, -26, 1, -4, -5, -18, 5, -16, 31, 2, 9, 28, 3
sol: .word -42
#--------------------TEST CASE SUITE---------------------end


M: .word 0:100000
SUM: .word 0:100000 #min
newline: .asciiz "\n"
check: .asciiz "new min: "
final: .asciiz "Final ans: "
same: .asciiz "same: "
t8: .asciiz "t8"
s6: .asciiz "s6"
t4: .asciiz "t4"
rowcolumn: .asciiz "rowcolumns: "
getrow: .asciiz "getrow: "
linesum: .asciiz "linesum: "
dcolumn: .asciiz "dcolumn: "

.text
#-------------Your code goes below this line-----------
# 1) The first word pointed by the 'test' variable is the depth of the triangle
# 2) The words following the 'depth' are the elements of the triangle
# 3) The array carries depth*(depth+1)*0.5 number of elements
# Please direct your questions to pmp30@pitt.edu or shs173@pitt.edu
# Good Luck!

addi $sp,$sp,-32  
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $s4,16($sp)
sw $s5,20($sp)
sw $s6,24($sp)
sw $s7,28($sp)
sw $ra,32($sp)

li $t1,4
				#col2-1
addi $t5,$zero,0
addi $t3,$zero,0
li $t0,2

la $t9,SUM 			#base address = t9 SAVE

mult $t0,$t3			#t3 = col1
mflo $s4			#t5 = col2
add $s4,$s4,$t5
mul  $s4,$s4,4
mflo $s5
add $s4,$s5,$t9 		#effective addree of SUM
		 		#sw take address and stores it into reg
		 		#need to lw = whatever value + linesum ?
		 		#that value to store word into newSum[col1][col2] ?
sw $s0,($s4)
lw $s0,($s4)
				#rows for loop1
li $t0,2 			#rows = $t0

la $s3,M			#declaring array of size row*row=4*4 = 16
				#base address = s3 SAVE

lw $t1,test + 0


MAIN:		

bgt $t0,$t1,EXIT   	         # when 2 > 4 branch!	LOOP1
				#row*col*numofelements
				#int[][] newSum = new int[row][row];

li $t3,0   			#col1 = t3
				#sum = newSum;

LOOP2:
bge $t3,$t0,IN			#LOOP2
li $t4,0			#linesum = $t4
add $t5,$zero,$t3		#col2 = col1 = t5


LOOP3:
bge $t5,$t0,INCREMENT		#LOOP3

				#get(row,col2) function
subi $t6,$t0,1 			#temp save in $t6
mult $t0,$t6
mflo $s7			#s0 = reslt of mult
li $t7,2
div $s7,$t7
mflo $s1			#quotient in s1
add $t7,$s1,$t5
addi $t7,$t7,1			#rslt of get() = $t7

sll $t7,$t7,2
lw $s2,test($t7)

addu $t4,$t4,$s2 		#linesum += get(row,col2), linsum total in t4
	
mult $t0,$t3			 #t3 = col1
mflo $s4			 #t5 = col2
add $s4,$s4,$t5
mul  $s4,$s4,4
mflo $s5
add $s4,$s5,$s3 		 #effective addree of M
		 		 #sw take address and stores it into reg
		 
bne $t3,$t5,ELSE

addi $sp,$sp,-12  		 #s0-$s7 = 8 * 4 = 32?
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $ra,12($sp)
add $s0,$s5,$t9			#so now we have in s0 effective address
				#of SUM

				#newSum[col1][col2] = lineSum;
				#a =col1 = t3, b= col2 = t5
	
sw $t4,($s4)		#sw = TO register FROM memory, array M
lw $s6,($s4)


addi $sp,$sp,12 	#s0-$s7 = 8 * 4 = 32?
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $ra,12($sp)

j CHECK

ELSE:
addi $sp,$sp,-12 	 #s0-$s7 = 8 * 4 = 32?
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $ra,12($sp)

			#need to save actual s4 effective address of M
			#move $s2,$s4	#whatever s4 had saved in s2 SAVE
			#newSum[col1][col2] = lineSum + sum[col1][col2-1];
		 	#sum[col1][col2-1] a =col1 = t3, b= col2 = t5

subi $t5,$t5,1     	 #col2-1

subi $t0,$t0,1           #saving it when row = 2


mult $t0,$t3		  #t3 = col1
mflo $s1		  #t5 = col2
add $s1,$s1,$t5
mul  $s1,$s1,4
mflo $s5
add $s1,$s5,$t9 	 #effective addree of SUM
		 	 #sw take address and stores it into reg
		 	 #need to lw = whatever value + linesum ?
		 	 #that value to store word into newSum[col1][col2] ?
lw $s0,($s1)
add $s5,$t4,$s0

sw $s5,($s4)
lw $s6,($s4)

addi $sp,$sp,12 	 #s0-$s7 = 8 * 4 = 32?
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $ra,12($sp)
addi $t5,$t5,1
addi $t0,$t0,1

			#should always come here if or else
			# if(newSum[col1][col2] < min) {
			#min = newSum[col1][col2];
CHECK:

bge $s6,$t8,ADD
add $t8,$zero,$s6  	#min = newSum[col1][col2];


ADD:
addi $t5,$t5,1 		#increment col2 first = t5
j LOOP3

INCREMENT:
addi $t3,$t3,1		#increment col1 = t3
J LOOP2

			#sum = newSum;
IN:

addi $sp,$sp,-12 	 #s0-$s7 = 8 * 4 = 32?
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $ra,12($sp)

addi $t3,$zero,0
addi $t5,$zero,0

ILoop1:
bge $t3,$t0,adding
			#col2 = col1 = t5
add $t5,$zero,0

ILoop2:
bge $t5,$t0,Incre


mult $t0,$t3		#t3 = col1
mflo $s4		#t5 = col2
add $s4,$s4,$t5
mul  $s4,$s4,4
mflo $s5
add $s4,$s5,$s3  	#effective addree of M
		 	#sw take address and stores it into reg

lw $s0,($s4)

mult $t0,$t3		 #t3 = col1
mflo $s4		 #t5 = col2
add $s4,$s4,$t5
mul  $s4,$s4,4
mflo $s5
add $s4,$s5,$t9  	#effective addree of SUM
		 	#sw take address and stores it into reg
		 	#need to lw = whatever value + linesum ?
		 	#that value to store word into newSum[col1][col2] ?
sw $s0,($s4)     	#COPY
lw $s0,($s4)

addi $t5,$t5,1
j ILoop2

Incre:
addi $t3,$t3,1		#increment col1 = t3
J ILoop1

addi $sp,$sp,12  	#s0-$s7 = 8 * 4 = 32?
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $ra,12($sp)

adding:
			#add $s0,$zero,$s6	#sum = newSum;
addi $t0,$t0,1		#increment rows = t0
J MAIN

EXIT:
la $a0,final
li $v0,4
syscall

move $a0,$t8
li $v0,1
syscall

lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $s5,20($sp)
lw $s6,24($sp)
lw $s7,28($sp)
lw $ra,32($sp)
addi $sp,$sp,32  

#Save your final answer in the register $a0
#---------Do NOT modify anything below this line---------------
lw $s0, sol
beq $a0, $s0 pass
fail:
la $a0, fail_msg
li $v0, 4
syscall
j end
pass:
la $a0, pass_msg
li $v0, 4
syscall
end:

.data
pass_msg: .asciiz " PASS"
fail_msg: .asciiz " FAIL"
#-----END------
