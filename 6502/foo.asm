	processor 6502
	org $1000
	
	INCLUDE "c64.asm"
	
	lda #<s1
	sta r0L
	lda #>s1
	sta r0H
	jsr PrintString
	lda #<buffer
	sta r0L
	lda #>buffer
	sta r0H
	ldx #10
	jsr ReadString
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
	
; x = max number of chars to read
; r0 ptr to destination buffer
; Y = bytes read
ReadString SUBROUTINE
	ldy #0
.loop
	jsr CHRIN
	cmp #CR
	beq .cr
	sta (r0),y
	iny
	dex
	beq .done
	jmp .loop
.cr
	lda #0
	sta (r0),y
.done
	rts
	
buffer:
	ds.b 10
output:
	ds.b 22
s1:
	dc.b "S1:",0
s2:
	dc.b "S2:",0