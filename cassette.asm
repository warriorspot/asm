	processor 6803
	org $5000
	
	INCLUDE "MC10.asm"

;print a message and wait for keypress
	ldaa #>foo
	staa r0
	ldaa #<foo
	staa r1
	ldab #1
	jsr print_string
	jsr inkey

; Store filename pointer in BLKPTR system variable
	ldaa #>block
	staa BLKPTR
	ldaa #<block
	staa BLKPTR+1

; Start
	bra main
	
main SUBROUTINE
; read cassette leader.  This will block
; until bytes start coming in.
.loop:
	ldaa #$ff
	staa CASPOL			;clear cassette polarity
	ldx RDCLDR			;read the leader to set polarity
	jsr 0,x				; returns polarity in A
	cmpa #$ff			; if not read, loop
	beq .loop
	
; read a filename block from casssette
; A = size limit
; B = if > 0, dont store block at BLKPTR
; Store destination address in BLKPTR
	ldaa #CSFNBLOCK
	ldab #0
	ldx BLKIN
	jsr 0,x

	ldaa BLKPTR			; print the filename we just read
	staa r0				; using the print_string routine
	ldaa BLKPTR+1
	staa r1
	ldab #1				;print a CR at the end of the string
	jsr print_string	;print the string
	
;look for Break key here
	ldx POLCAT
	jsr 0,x
	cmpa #0				;no key pressed
	beq .loop

; print another message and quit
	ldaa #>foo2
	staa r0
	ldaa #<foo2
	staa r1
	jsr print_string
	jsr inkey
	jmp WARMSTART
	
	INCLUDE "routines.asm"

foo:
	dc.b "PRESS enter THEN play...",$00
foo2:
	dc.b "PRESS ANY KEY TO FINISH", $00
block:
	ds.b CSFNBLOCK,0 	;reserve CSFNBLOCK bytes for reading the 
						;filename block