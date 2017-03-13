	processor 6803
	org $5000
	
	INCLUDE "MC10.asm"
	INCLUDE "routines.asm"
	
	ldaa #>buffer
	staa r0
	ldaa #<buffer
	staa r1
	jsr read_string
	ldaa #>message
	staa r0
	ldaa #<message
	staa r1
	jsr print_string
	jsr inkey
	jsr sound
	rts
	
sound SUBROUTINE
	ldab #$00
.1:
	ldaa #$80
	staa vdgport
	jsr delay
	anda #$00
	staa vdgport
	jsr delay
	incb
	cmpb #$00
	bne .1
	rts
	
delay SUBROUTINE
	psha
	pshb
	ldaa #$00
	ldab #$00
.1:
	nop
	inca
	cmpa #$55
	bne .1
	incb 
	cmpb #$06
	bne .1
	pulb
	pula
	rts
	
message:
	dc.b "PRESS A KEY TO START",$00
buffer:
	ds.b 255