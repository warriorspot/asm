	processor 6803
	org $7500
	
	INCLUDE "MC10.asm"

mode_count equ $0B

	ldaa #$00
	staa r0
	staa r1
	
; a simple interrupt driven routine
; tied to the 6803 timer overflow interrupt
	sei				;disable interrupts
	ldaa #$7e		;load jmp opcode
	staa TOFVEC		;store it in the low byte of the vector
	ldx #entry		;load the address of the handler
	stx TOFVEC+1	;store it in the next 2 bytes
	ldaa TCSR		;load the timer status
	oraa #$04		;turn on overflow interrupt bit
	staa TCSR		;save the timer status
	cli				;enable interupts
	jmp WARMSTART	;jump to CPU warm start (BASIC)
	
entry SUBROUTINE
	psha
	pshb
	pshx
	inc r1
	ldaa r1
	cmpa #$00
	bne .exit
	ldab r0
	cmpb #mode_count
	bne .1
	ldab #$00
	stab r0
.1:
	ldx #modes
	abx
	ldaa 0,x
	staa vdgport
	inc r0
	ldaa TCSR		;clear the overflow flag
	ldaa TIMER 		;by reading the TCSR, then the TIMER (see 6803 datasheet)
.exit:
	pulx
	pulb
	pula
	rti
	
modes: 
	hex 00 04 20 30 28 38 24 34 2C 3C 40