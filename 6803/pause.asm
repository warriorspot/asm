	processor 6803
	org $7fd8
	
	INCLUDE "MC10.asm"
	
; This program blanks the screen until a key is pressed.
; It copies the 512 byte text screen to a buffer, switches
; to RG6 mode, then clears the screen and waits for a keypress.
; When a key is pressed, the mode is switched back to RG4, then
; the saved screen buffer is copied back.

; Install ctrl key extension hook to detect Ctrl-Enter
	ldaa #$7e			;JMP opcode
	staa RVEC14
	ldx #.main
	stx RVEC14 + 1
	rts 
	
.main:
	psha
	tpa
	psha
	pshb
	pshx
	
	ldaa CTRLKY			;Check if CTRL is pressed
	cmpa #$FF
	bne	.done			;If not, exit
	
	;wait for a key to be pressed
	;
.wait_key:
	ldx POLCAT
	jsr 0,x
	cmpa #0				;no key pressed
	beq .wait_key
	
.done:
	pulx
	pulb
	pula
	tap
	pula
	rts
