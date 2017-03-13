
Add32 SUBROUTINE
	ldy #0
	clc
.loop
	lda ($00),Y
	adc ($02),Y
	sta ($04),Y
	iny
	php
	cpy #4
	beq .done
	plp
	jmp .loop
.done
	plp
	rts
	
; x = max number of chars to read
; r0 ptr to destination buffer
; Y returns number of bytes read
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
	
WaitKey SUBROUTINE
	pha
	jsr CHRIN
	pla
	rts