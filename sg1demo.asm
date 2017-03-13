	processor 6803
	org $4E00
	
	INCLUDE "MC10.asm"
	
	ldd #$0000
	ldx #screen
.loop:
	std 0,X
	inx
	inx
	cpx #$4400
	bne .loop
	ldaa #$30
	staa vdgport
	jmp WARMSTART
	
setpoint SUBROUTINE
	
	rts
	
; Wait for a key to be pressed.  Return
; the pressed key in ACCA.
; Destroys: A, B, X
inkey SUBROUTINE
	ldaa #$0		; initialize ACCA to 0
	ldx POLCAT		; load address of POLCAT
	ldab #$3		; skip calling extension hook
	abx
.1:
	jsr 0,x			; strobe the keyboard
	cmpa #$0		; check if no key pressed
	beq .1			; if no key, loop
	rts				; return