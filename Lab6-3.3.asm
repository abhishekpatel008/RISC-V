# This program generates random 100 integers between 1 - 100 and calculates their average:
# ** I Used "subtraction of divisor from the total" method to calculate average because we avoid using "mult" or "div" in this course **

.globl main
.data 
buffer: .space 400 # set aside space for 100 integers              
# declare variables
i: .word 0
sum: .word 0
avg: .word 0       
.text
main:
    	la a5, buffer # base address of array                
    	la a2, i # address of i                 
    	la a3, sum # address of "sum" var                  
    	la a4, avg # address of "average" var              

    	li t1, 100 # load max elememnts number                    
   	# initialize all variables to zero
   	sw x0, 0(a2)                  
    	sw x0, 0(a3)                  
    	sw x0, 0(a4)		
    	lw t2, 0(a2) # load i                 

random:
    	li a7, 42 # system call to generate random number                     
    	# generate radom numbers from 1 - 100
    	li a0, 1                      
    	li a1, 100                    
    	ecall                         
    
    	lw t3, 0(a2) # load i                 
    	slli t3, t3, 2 # offset calculation               
    	add a6, a5, t3 # address of "ith" element in array              
    	sw a0, 0(a6) # store random number in array                 
    	addi t2, t2, 1  # increment i = i + 1             
    	sw t2, 0(a2) # store updated value of i                
   	beq t2, t1, accumulate # when i == 100, calculate sum              
   	j random # otherwise continue loop
accumulate:
	sw x0, 0(a2) # restore i = 0
	lw t2, 0(a2) # load i
loop1:
	lw t3, 0(a2) # load i for offset calculation                 
    	slli t3, t3, 2 # offset calculation		     
	add a6, a5, t3 # address of "ith" element in array
	lw t4, 0(a6) # load element of array		
	lw t5, 0(a3) # load sum
	add t5, t5, t4 # sum = sum + buffer[i]
	sw t5, 0(a3) # store updated value of sum
	addi t2, t2, 1 # increment i = i + 1
	sw t2, 0(a2) # store updated i
	beq t2, t1, average # if i == 100 end the loop and calculate average
	j loop1 # otherwise continue to accumulate
average:
	lw t5, 0(a3) # load sum
	li t6, 0 # temporary average counter initialize to zero
loop2:
	blt t5, t1, store # if sum < 100 end the loop to store value of average
	sub t5, t5, t1 # subtract sum by 100
	addi t6, t6, 1 # increment counter by 1
	# final number of the increment counter shows how many times 100 was subtracted from sum
	j loop2 # continue to loop until sum < 100
store:
	sw t6, 0(a4) # store value of average counter at "avg"
			
	li a7 1 # system call to print average
	lw a0, 0(a4) # load average to a0
	ecall
	
	li a7 10 # system call to exit
	ecall