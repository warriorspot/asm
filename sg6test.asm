	processor 6803
	org $7500
	
	INCLUDE "MC10.asm"
	
	ldaa #$00
	ldab #$00
	staa r0
	staa r2
	
	ldaa #SG6
	staa vdgport

	jsr clear_screen
.loop:
	inc r2
	ldaa #$00
	cmpa r2
	beq .done
	ldaa r2
	staa r0
	jsr clear_screen

	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	jsr wait
	
	bra .loop
	stab r0
	jsr clear_screen

.done:
	ldaa #SG4
	staa vdgport
	
wait SUBROUTINE
	psha
	pshb
	ldaa #$0
	ldab #$0
.loop:
	inca
	nop
	nop
	nop
	cmpa #$00
	bne .loop
.loop2
	incb
	nop
	nop
	nop
	cmpb #$00
	bne .loop2
	
	pulb
	pula
	rts
	
inkey SUBROUTINE
.wait_key:
	ldx POLCAT
	jsr 0,x
	cmpa #0				;no key pressed
	beq .wait_key
	rts

; Fill screen memory with the value stored
; in r0. Destroys r0,r1
clear_screen SUBROUTINE
	psha
	pshx
	ldaa r0
	sts r0
	lds #screen + $01ff
.1:
	psha
	tsx
	cpx #$4000
	bne .1
	lds r0
	pulx
	pula
	rts