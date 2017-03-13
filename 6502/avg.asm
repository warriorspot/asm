	processor 6502
	org $1000

	INCLUDE "c64.asm"
	
	jsr Main
	
	
	nop
	
Main SUBROUTINE
	lda #<message
	sta r0L
	lda #>message
	sta r0H
	jsr PrintString
	
	jsr GetNumbers
	rts

GetNumbers SUBROUTINE

.loop
	lda #<prompt
	sta r0L
	lda #>prompt
	sta r0H
	jsr PrintString
	lda #<buff
	sta r0L
	lda #>buff
	sta r0H
	jsr ReadString
	lda #<out
	sta r1L
	lda #>out
	sta r1H
	jsr AtoI32
	rts
	
; IN: r0 points to string
; IN: r1 points to memory for return value
AtoI32 SUBROUTINE
	ldy #0
	lda #0
	sta (r1),Y		;Init return value to 0
	iny 
	sta (r1),Y
	iny 
	sta (r1),Y
	iny 
	sta (r1),Y
	ldy #0
.loop
	tya
	pha
	ldy #0
.asl3				; r1 = r1 << 3
	lda (r1),Y
	clc
	asl
	sta (r1),Y
	iny
	cpy #3
	bne .asl3
	
	
	lda (r0),Y
	beq .done
	sec
	sbc #$30		;subtract ASCII 0x30 to get value
	
	pha
	
.done
	rts
	
; r0 = pointer to string
PrintString SUBROUTINE
	ldy #$0
.loop
	lda (r0),Y
	beq .done
	jsr CHROUT
	iny
	jmp .loop
.done
	rts

; IN: r0 = pointer to storage
; OUT: Y = number of bytes read
ReadString SUBROUTINE
	ldy #0
.loop
	jsr CHRIN
	cmp #CR
	beq .done
	sta (r0),Y
	iny
	jmp .loop
.done
	rts
	
prompt:
	dc.b ">",0
message:
	dc.b "ENTER A BUNCH OF NUMBERS",0
; String input buffer
buff:
	ds.b 16
; AtoI output buffer
out:
	ds.b 4
numbers:
	ds.b 32 * 100
	