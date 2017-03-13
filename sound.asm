	processor 6803
	org $5000
	
	INCLUDE "MC10.asm"
	
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
	jmp WARMSTART
	
	
entry SUBROUTINE
	psha
	pshb
	pshx
	ldaa #$00
	ldab #$40
	ldx #$10
.loop
	eora #$80
	staa vdgport
.wait
	decb
	cmpb #$00
	bne .wait
	dex
	cpx #$00
	bne .loop
	ldaa TCSR		;clear the overflow flag
	ldaa TIMER 		;by reading the TCSR, then the TIMER (see 6803 datasheet)
	pulx
	pulb
	pula
	rti