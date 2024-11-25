# This program generates random 100 integers between 1 - 100 and finds the maximum value:
 
.globl main
.data 
buffer: .space 400               
i: .word 0
max: .word 0
.text
main:
	la a5, buffer # address of array               
    	la a2, i # address of i                 
	la a3, max # address of maximum variable
	
	li t1, 100 # load loop limit
	sw x0, 0(a2) # initialize i = 0
	lw t2, 0(a2) # load i = 0
	
random:

	li a7, 42 # system call to generate random numbers                    
    	# Generate random numbers between 1 to 100
    	li a0, 1 # start at 1                      
    	li a1, 100 # end at 100                   
    	ecall  # call to generate numbers                       
    
    	lw t3, 0(a2) # load i to t3                  
    	slli t3, t3, 2 # offset calculation                
    	add a6, a5, t3 # address of ith element in array              
    	sw a0, 0(a6) # store generated random number in array                  
    	addi t2, t2, 1 # iterate i = i + 1              
    	sw t2, 0(a2) # store updated value of i                
   	beq t2, t1, maximum # when i == 100, calculate maximum               
   	j random # otherwise continue to generate numbers
maximum:  	
	lw t4, 0(a5) # load 1st element from array
	sw x0, 0(a2) # reset i = 0
loop:
	lw t2, 0(a2) # load i
	slli t3, t2, 2 # offset calculation
	add a6, a5, t3 # address of ith element in array
	lw t5, 0(a6) # load value from array
	bge t4, t5, end # if 1st element is >= ith element; we have found the maximum
	add t4, t5, x0 # otherwise continue to loop
end:
	addi t2, t2, 1 # iterate i = i + 1
	sw t2, 0(a2) # store updated value of i
	bge t2, t1, done # when i >= 100 end the loop
	j loop # otherwise continue searching for max
done:
	sw t4, 0(a3) # store the value at the address of "max" 
		
	li a7, 1 # system call to print
	lw a0, 0(a3) # load maximum to a0
	ecall # call to print in the console
	
	li a7 10 # syscall for exit
	ecall