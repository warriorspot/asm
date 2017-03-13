	processor 6803
	org $5000
	
	INCLUDE "MC10.asm"
	
	ldaa #>message
	staa r0
	ldaa #<message
	staa r1
	jsr print_string
	rts
	
;Print the 0 terminated string pointed to in r0,r1.
;In: r0,r1 = pointer to string
;In: B = if > 0 add a CR at the end
;Destroys: A, B, X
print_string SUBROUTINE
	ldx r0			;load pointer to string
.1:
	ldaa 0,x		;read one byte of string
	cmpa #$0		;see if done
	beq .2			;if 0, we're done
	pshx			;save index register
	ldx CHROUT		;load address of CHROUT routine
	jsr 0,x			;print the character in ACCA
	pulx			;restore string pointer
	inx				;increment index register to next character
	bra .1			;loop
.2:
	cmpb #$0
	beq .done
	ldaa #CR
	ldx CHROUT
	jsr 0,x
.done:
	rts
	
message:
	dc.b "PRESS A KEY TO START",$00