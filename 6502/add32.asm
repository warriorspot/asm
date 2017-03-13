	processor 6502
	org $1000
	
	lda #<num1
	sta $00
	lda #>num1
	sta $01
	lda #<num2
	sta $02
	lda #>num2
	sta $03
	lda #<res
	sta $04
	lda #>res
	sta $05

	
Mul32 SUBROUTINE
	
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

num1:
	dc.w 30
	dc.w 00
num2:
	dc.w $FF
	dc.w $00
res:
	ds.w 2