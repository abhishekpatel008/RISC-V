# This program accumulates the sum of integers 1 - 100:

.globl main
.data
i: .word 1 # Initialize i with 1 (to get numbers from 1 - 100)
sum: .word 0 # initialize sum with 0
.text
main: # this is where program starts
	la a5, i # load address of i
	la a6, sum # load address of sum

	lw t1, 0(a5)# load the value of i
	lw t2, 0(a6)# load the value of sum
	li t3, 100 # load the limit of 100
for: # label for the loop
	add t2, t2, t1 # calculate the sum (sum = sum + i)
	sw t2, 0(a6) # store updated value of the sum to its address
	beq t1,t3 exit # check if i == 100. When i == 100 exit the loop
	addi t1, t1, 1 # iterate i = i + 1
	sw t1, 0(a5) # store the updated value of i to its address
	beq x0, x0, for # jump back to the start of the loop
exit:
	li a7, 1 # execute print to the console
	lw a0, 0(a6)# load value of sum to a0 for output
	ecall

	li a7, 10 # exit call
	ecall