	processor 6502
	org $1000

MaxValue = 100
three = $FB
five = $FC

	INCLUDE "c64.asm"

; FizzBuzz from 1 to 100.
; f = fizz count
; b = buzz count
; fb = fizzbuzz count
;
Main SUBROUTINE
	ldx #1 			; init counter to 1
.loop:
	cpx #MaxValue 	; for(i = 1 to MaxValue)
	beq .done 		; if > MaxValue, quit
	ldy #3 			; i MOD 3
	jsr Mod 		;
	sta three 		; store result
	ldy #5 			; i MOD 5
	jsr Mod 		;
	sta five 		; store result
.fb: 				; if(i % 3 == 0 && i % 5 == 0)
	lda three 		; get result of i MOD 3
	beq .fb_1 		; if (i MOD 3 == 0) goto three_1
	jmp .five 		; else goto five
.fb_1:
	lda five 		; load result of i % 5
	beq .fizzbuzz 	; if five==0 goto fizzbuzz
	jmp .five 		; else goto five
.five:
	lda five 		; load result of i % 5
	beq .buzz 		; if(i%5 == 0) goto buzz
.three:
	lda three 		; load result of i % 3
	bne .cont 		; if != 0, loop, else fizz
.fizz:
	jsr Fizz
	jmp .cont
.buzz:
	jsr Buzz
	jmp .cont
.fizzbuzz:
	jsr FizzBuzz
.cont:
	inx
	jmp .loop
.done:
	jsr WaitKey
	rts

; Modulus of 2 8-bit values
; X = value 1
; Y = value 2
; mod = X % Y, return modulo value in A
Mod SUBROUTINE
	txa        		; X -> A
	sty r1L			; Y -> $00
	sec 			; prepare to subtract
	sbc r1L 	    ; A - $00
	bmi .minus 		; Y is greater than X, return X
	stx r1L 		; else, save X
	sty r1H 		; save Y
	txa 			; A = X
.loop:
	sec 			; prepare to subtract
	sbc r1H 		; A = A - Y
	cmp r1H 		; compare A to Y
	bmi .done 		; if A < Y, we're done
	jmp .loop 		; else, loop and keep subtracting
.minus:
	txa 			; A = X
	rts 			; return
.done:
	rts

Fizz SUBROUTINE
	inc f
	lda #<FizzS
	sta r1L
	lda #>FizzS
	sta r1H
	jsr PrintString
	rts

Buzz SUBROUTINE
	inc b
	lda #<BuzzS
	sta r1L
	lda #>BuzzS
	sta r1H
	jsr PrintString
	rts

FizzBuzz SUBROUTINE
	inc fb
	lda #<FizzBuzzS
	sta r1L
	lda #>FizzBuzzS
	sta r1H
	jsr PrintString
	rts

; r1 = pointer to string
PrintString SUBROUTINE
	pha
	tya
	pha
	ldy #$0
.loop
	lda (r1),Y
	beq .done
	jsr CHROUT
	iny
	jmp .loop
.done
	pla
	tay
	pla
	rts
	
WaitKey SUBROUTINE
	pha
	jsr CHRIN
	pla
	rts
	
f:
	ds.b 1
b: 
	ds.b 1
fb:
	ds.b 1
FizzS:
	dc.b "FIZZ", $D, $0
BuzzS:
	dc.b "BUZZ", $D, $0
FizzBuzzS:
	dc.b "FIZZBUZZ", $D, $0