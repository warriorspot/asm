	processor 6803
	org $4200
	
	INCLUDE "MC10.asm"

	; This example plays sound and decreases the pitch when a key is pressed.
	; After pressing a few keys the pitch resets.
	; It took me awhile to figure out that sound is produced as a function
	; of the frequency with which you toggle bit 7 of bfff on and off. The
	; more frequent the toggling, the higher the pitch.  The longer you toggle,
	; the longer the pitch plays.  See the ROM dump code for sound handling for
	; another example of this.
	;
	clra 				; Set initial counter to 0001
	staa r0				
	inca 				
	staa r1
	
	clra				; A = 0
.start:
	eora      #$80		; Toggle bit 7 of the VDG on or off
	staa vdgport		; Update the sound setting
	ldx r0				; Load the counter value
.loop:
	jsr get_key			; See if a key is pressed
	cmpb #$00			; If not, continue
	bne .change_pitch	; If yes, change the pitch
	dex					; decrement the counter
	bne .loop			; if > 0, continue the delay loop.
	jmp .start			; else, toggle sound state and start over
.change_pitch:
	inc r1				; increment the delay counter
	ldab r1				; Load into acc B
	cmpb #$20			; Check if its > #$20
	bhi .reset			; If so, reset it
	jmp .start			; Otherwise, toggle the sound on or off again.
.reset:	
	clrb				; B = 0
	stab r1				; Save pitch counter value
	jmp .start			; Start over
	
get_key SUBROUTINE
	pshx				; Save value of X and A
	psha
	ldx POLCAT			; OS keyboard scan routine
	jsr 0,x
	tab					; transfer key code to acc B
	pula				; restore A and X
	pulx
	rts