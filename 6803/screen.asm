	processor 6803
	org $5801
	
	INCLUDE "MC10.asm"

screenwidth equ 128
screenheight equ 64
bytes_per_row equ 16
screenbytes equ screenheight * bytes_per_row
	
	ldaa #RG1
	staa vdgport
	ldaa #$00
	jsr clearscreen
	ldaa #$11
	staa r0
	ldaa #$0
	staa r1
	ldaa #$0
	staa r2
.1
	ldaa r1
	cmpa #$ee
	beq .2
	inca
	staa r1
	jsr drawpoint
	jmp .1
	ldaa #RG1
.2:
	eora #$40
	staa vdgport	
	jmp .2
	
drawsquare SUBROUTINE
	ldx #$4210
	ldaa #$ff
.loop:
	staa 0,x
	inx
	cpx #$4220
	bne .loop
	rts

;toggle a bit on or off
;r0 = x, r1 = y r2 = on or off (0 is off, non 0 is on)
;row_base = screen + (y * bytes_per_row)
;byte = 
;for(i = 0; i < 16; i++)
;	if(x-i < 8) break

drawpoint SUBROUTINE
	ldaa #bytes_per_row	;load bytes per row
	ldab r1				;load Y position
	mul 				;a * b
	addd #screen		;add screen offset to get base address of byte
	std r7			    ;store value
	clrb				;init b to 0
	ldaa #$-1			;start byte counter at -1
	psha				;save it on the stack
.1	; loop until byte offset < 0 
	pula				;pull byte counter into A
	inca				;increment
	psha				;save it
	addb #$8			;increment byte offset by 8
	tba					;transer B to A
	suba r0				;subtract A from X position
	blt .1				;if its negative, repeat

	ldab #$01		;00000001
.2					;get bit mask
	rorb			;rotate right (start at 1000 0000)
	deca			;decrement offset
	bpl .2			;branch if >= 0
	
	pula			;load byte offset
	pshb			;save bit mask on the stack
	tab				;transer A to B
	ldx r7		    ;load base address of byte
	abx				;add byte offset to base
	pulb			;load bit mask
	ldaa 0,x		;load current byte at address
	staa r7	        ;store it
	orab r7	        ;OR B with bit mask in "r7"
	stab 0,x		;store the byte, turning on the bit
	rts				;done
	
;clear screen using byte value
;in acca
clearscreen SUBROUTINE
	ldx #screen
.loop:
	staa 0,x
	inx
	cpx #(screen + screenbytes)
	beq done
	jmp .loop
done:
	rts