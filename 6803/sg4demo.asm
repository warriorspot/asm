	processor 6803
	org $7500
	
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

	ldaa #SG6			; Set video mode to SG6
	cmpa screen_mode	; Check if already in SG6
	beq .done 			; If so, quit
	
	; Call memcpy to buffer the screen
	;
.toSG6
	staa vdgport		; Switch mode
	staa screen_mode	; Save current screen mode
	ldx #screen			;Store address of screen in r0,r1
	stx r0
	ldx #screen_buffer 	;Store address of buffer area r2,r3
	stx r2
	ldaa #$ff			;Number of bytes in r4
	staa r4
	jsr memcpy			;copy first 256 bytes
	jsr memcpy			;copy second 256 bytes
	
	; Call clear_screen
	;
	ldaa #$00
	staa r0
	jsr clear_screen	; and clear the screen
	
	;wait for a key to be pressed
	;
.wait_key:
	ldx POLCAT
	jsr 0,x
	cmpa #0				;no key pressed
	beq .wait_key
	
	; Switch back to SG4 and copy buffer
	;
.toSG4:
	ldaa #SG4
	staa vdgport
	staa screen_mode	;save current screen mode
	ldx #screen_buffer
	stx r0
	ldx #screen
	stx r2
	ldaa #$ff
	staa r4
	jsr memcpy
	jsr memcpy
	
.done:
	pulx
	pulb
	pula
	tap
	pula
	rts
	
; Copy up to one page of memory from point A to
; point B.  Destroys X, A, B
; r0,r1 = source address
; r2,r3 = destination address
; r4	= number of bytes to copy
; When this subroutine returns, r0,r1 and r2,r3 will contain
; values that ready to copy another r4 bytes from src to dest,
; so this routine can be called repeatedly to keep copying 
; r4 bytes from src to dest (i.e. set r4 to FF and call 3 times
; to copy 3 pages).
memcpy SUBROUTINE  
	ldab #$0			;initialize counter to 0
.loop:	
	ldx r0				;load source address
	ldaa 0,x			;load byte at source
	inx					;increment source
	stx r0				;store source in r0
	ldx r2				;load destination in X
	staa 0,x			;store the byte in the destination
	inx					;increment the destination
	stx r2				;store the destination
	incb				;increment the counter
	cmpb r4				;compare to r4
	bne .loop			; < 4? Continure
	rts					; done
	
; Fill screen memory with the value stored
; in r0
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
	
screen_buffer:
	ds.b 512
screen_mode:
	HEX 00