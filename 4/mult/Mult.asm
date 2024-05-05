// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

// n = R0
// f = R1
// prod = 0
// 
// LOOP:
// 		if i>n: goto stop
// 		prod = prod+f
//		goto LOOP
// 
// R2=prod
//
// STOP

@prod
M=0 //prod=0

@R0
D=M
@n
M=D //n=R0

@R1
D=M
@f
M=D //f=R1

@i
M=0  //i=0

@R2
M=0  //initialise res as 0 in case there are no; only necessary if prematurely stopped as in test script

(LOOP)
	@i
	D=M
	@n
	D=M-D
	@STOP
	D;JEQ	// if i>n goto STOP

	@f
	D=M
	@prod
	M=D+M  // prod=prod+f

	@i
	M=M+1  // i+=1

	@LOOP
	0;JMP  // otherwise go to beginning of LOOP


(STOP)
@prod
D=M
@R2
M=D  // R2=prod

(END)
	@END
	0;JMP

