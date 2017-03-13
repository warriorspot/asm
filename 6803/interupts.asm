	processor 6803
	org $7500
	
	INCLUDE "MC10.asm"

; a simple interrupt driven routine
; tied to the 6803 timer overflow interrupt
	ldaa #$0
	staa r7
	staa r8
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
	
entry:
	sei				;disable interrupts
	psha
	pshb
	pshx
	inc r7
	inc r8
	ldaa r7
	ldab r8
	ldx #screen
	abx
	staa 0,x
	ldaa TCSR		;clear the overflow flag
	ldaa TIMER 		;by reading the TCSR, then the TIMER (see 6803 datasheet)
	cli				;enable interrutps
	pulx
	pulb
	pula
	rti				;return