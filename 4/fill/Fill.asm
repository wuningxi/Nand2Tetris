// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// part 1: detect key press
// prev = 0
// while True:
//		if keyboard!=0:
//			pressed=-1
//		else:
//			pressed=0
// 		if pressed!=prev:
//			paint(colour=pressed)
//			
//// part 2: paint screen
// def paint(colour):
// 		for i in range(screen,KBD-1):
//			RAM[i]=colour


@white
M=0

@black
M=-1

@prevkey
M=0


// keyboard monitoring part

(KBDLOOP)
	@KBD //24578
	D=M

	@pressedkey // store currently pressed key
	M=D

	@SETWHITE
	D; JEQ // if no key pressed, set colour=white 

	@SETBLACK
	0; JMP // otherwise set colour=black

	(CONTINUE)
	@prev
	D=M
	@colour
	D=D-M 
	@change
	M=D // change = prev==colour

	@colour
	D=M
	@prev
	M=D // prev = colour

	@change
	D=M

	@RESET
	D; JNE // go to paint loop if colour has changed

	@KBDLOOP // go to start of loop
	0; JMP


// screen painting part

(SETWHITE)
	@colour
	M=0
	@CONTINUE
	0; JMP

(SETBLACK)
	@colour
	M=-1
	@CONTINUE
	0; JMP


(RESET)
	@SCREEN //16384
	D=A

	@cur
	M=D //cur=SCREEN


(PAINTLOOP)
	@KBD //24578
	D=A

	@cur
	D=D-M

	@KBDLOOP
	D; JEQ // stop if reached end of screen (cur-KBD==0)

	@colour
	D=M

	@cur
	A=M 
	M=D // RAM[cur]=colour (0 or -1)

	@cur
	D=M+1
	M=D // cur+=1

	@PAINTLOOP
	0; JMP // go to start of loop



(END)
	@END
	0; JMP