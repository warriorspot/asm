	processor 6803
	org $7500
	
	INCLUDE "MC10.asm"
	
MaxValue = 101

; FizzBuzz from 1 to 100.
; f = fizz count
; b = buzz count
; fb = fizzbuzz count
;
Main SUBROUTINE
	ldaa #1 		; init counter to 1
.loop:
	cmpa #MaxValue 	; for(i = 1 to MaxValue)
	beq .done 		; if > MaxValue, quit
	ldab #3 		; i MOD 3
	psha			; save A
	jsr Mod 		;
	staa three 		; store result
	ldab #5 		; i MOD 5
	pula			; restore original value of A
	psha			; save A again
	jsr Mod 		;
	staa five 		; store result
.fb: 				; if(i % 3 == 0 && i % 5 == 0)
	ldaa three 		; get result of i MOD 3
	beq .fb_1 		; if (i MOD 3 == 0) goto three_1
	jmp .five 		; else goto five
.fb_1:
	ldaa five 		; load result of i % 5
	beq .fizzbuzz 	; if five==0 goto fizzbuzz
	jmp .five 		; else goto five
.five:
	ldaa five 		; load result of i % 5
	beq .buzz 		; if(i%5 == 0) goto buzz
.three:
	ldaa three 		; load result of i % 3
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
	pula
	inca
	jmp .loop
.done:
	jsr WaitKey
	rts

; Modulus of 2 8-bit values
; A = value 1
; B = value 2
; mod = A % B, return modulo value in A
Mod SUBROUTINE
	stab r1			; B -> $00
	sec 			; prepare to subtract
	sbca r1 	    ; A - B
	bmi .minus 		; A is greater than B, return B
	stab r1 		; save Y
.loop:
	sec 			; prepare to subtract
	sbca r1 		; A = A - B
	cmpa r1 		; compare A to B
	bmi .done 		; if A < Y, we're done
	jmp .loop 		; else, loop and keep subtracting
.minus:
	tba
.done:
	rts

Fizz SUBROUTINE
	inc f
	ldaa #<FizzS
	staa r1
	ldaa #>FizzS
	staa r0
	ldab #0
	jsr PrintString
	rts

Buzz SUBROUTINE
	inc b
	ldaa #<BuzzS
	staa r1
	ldaa #>BuzzS
	staa r0
	ldab #0
	jsr PrintString
	rts

FizzBuzz SUBROUTINE
	inc fb
	ldaa #<FizzBuzzS
	staa r1
	ldaa #>FizzBuzzS
	staa r0
	ldab #0
	jsr PrintString
	rts

;Print the 0 terminated string pointed to in r0,r1.
;In: r0,r1 = pointer to string
;In: B = if > 0 add a CR at the end
;Destroys: A, B, X
PrintString SUBROUTINE
	ldx r0			;load pointer to string
.1:
	ldaa 0,x		;read one byte of string
	cmpa #$0		;see if done
	beq .2			;if 0, we're done
	pshx			;save index register
	ldx CHROUT		;load address of CHROUT routine
	jsr 0,x			;print the character in ACCA
	pulx			;restore string pointer
	inx				;increment index register to next character
	bra .1			;loop
.2:
	cmpb #$0
	beq .done
	ldaa #CR
	ldx CHROUT
	jsr 0,x
.done:
	rts
	
WaitKey SUBROUTINE
	psha
	ldx POLCAT
	jsr 0,x
	pula
	rts

; Variables
three:
	ds.b 1
five: 
	ds.b 1
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