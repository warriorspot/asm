	processor 6803
	org $4400
	
	INCLUDE "MC10.asm"

MAX_CHARS = 10

Main SUBROUTINE
	jsr Idiv_32
	
	ldaa #>msg_1		;Load pointer to message
	staa r0				;in r0, r1
	ldaa #<msg_1
	staa r1
	ldab #1				;force newline
	jsr PrintString		;print
.loop
	ldaa #>prompt
	staa r0
	ldaa #<prompt
	staa r1
	ldab #0
	jsr PrintString
	ldaa #>buffer
	staa r0
	ldaa #<buffer
	staa r1
	ldaa #MAX_CHARS
	jsr ReadString
.done
	rts

; Convert string in r0 to
; a 32 bit integer.
; Return integer in r2-r5
; A > 0 if overflow or other error.
Atoi SUBROUTINE
	ldx r0
.loop
	ldaa 0,x
	beq .done
	suba #$30
	
	dex
	bra .loop
.done
	rts

; Convert number pointed to in r0
; to ASCII.  Store the result in the string
; pointed to by r2.  Number of bytes to convert
; is passed in ACC B
Itoa SUBROUTINE
	ldx r0
	
	rts

Idiv_32	SUBROUTINE
	ldd #0
	std scratch
	std scratch + 2
.loop
	jsr Sub_32
	
	;32-bit increment by 1 inline
	clc
	ldx #scratch
	ldaa 3,x
	adca #1
	staa 3,x
	ldaa 2,x
	adca #0
	staa 2,x
	ldaa 1,x
	adca #0
	staa 1,x
	ldaa 0,x
	adca #0
	staa 0,x

	ldd res
	std num1
	ldd res+2
	std num1+2
	ldd #num1
	std r0
	ldd #num2
	std r2
	ldab #4
	jsr Compare
	bmi .done
	bra .loop
.done
	rts
	
;Modulus of two 32 bit values.
;num1 MOD num2 = res
Mod_32 SUBROUTINE
	ldd #0			;init result to 0
	std res
	std res+2
	;if num1 < num2 return num1
	ldd #num1		;store &num1 in r0
	std r0
	ldd #num2		;store &num2 in r2
	std r2
	ldab #4			;compare 4 bytes
	jsr Compare		
	bmi .less		;num1 < num2, return num1
	beq .done		;num1 = num1, rts (res = 0 already)
	;while((num1 = num1-num2) >= num2){}; return;
.loop
	jsr Sub_32		;res = num1 - num2
	;num1 = res
	ldd res			;load high word of result
	std num1		;copy to num1
	ldd res+2		;load low word of result
	std num1+2		;copy to num1
	ldd #num1		;load &num1
	std r0			;store in r0
	ldd #num2		;load &num2
	std r2			;store in r2
	ldab #4			;compare 4 bytes
	jsr Compare		;Compare
	bcs .done		;if (num1 < num2), done
	bra .loop	
.less	; return num1
	ldd num1		
	std res
	ldd num1+2
	std res+2
	bra .done
.done
	rts

;Compare memory pointed to in r0
;with memory pointed to in r2.
;Number of bytes to compare in B
;Bytes are compared LSB-first, and walked
;down towards the MSB for a numerical compare
;Return result in A.
;A = 1, *r0 > *r2
;A = -1 *r0 < *r2
;A = 0  *r0 == *r2
Compare SUBROUTINE
	ldaa #0			;set A to 0
	cmpb #0			;If B = 0, we're done
	beq .done
.loop
	ldx r0			;Load pointer to num1
	pshb			;Save the byte counter
	ldaa 0,x		;Get byte of num1
	inx			;Increment num1 pointer
	stx r0			;Save it
	ldx r2			;Load pointer to num2
	ldab 0,x		;Get byte of num2
	inx			;Increment num2 pointer
	stx r2			;Save it
 	cba			;Compare B to A (A - B)
	beq .cont		;If B = A, continue to next byte
	blo .less		;If A < B, exit
	bra .more		;Here, A > B, ext
.cont
	pulb			;Restore byte counter
	decb			;Decrement it
	beq .done		;If B = 0, we're done
	bra .loop		;Loop to next byte
.less
	pulb
	ldaa #$ff
	rts
.more
	pulb
	ldaa #1
	rts
.done
	clra
	rts

; Subtract two 32 bit numbers in num1, num2.
; Store result in res.
Sub_32 SUBROUTINE
	clc
	ldx #num1
	ldaa 3,x
	sbca num2 + 3
	staa res + 3
	ldaa 2,x
	sbca num2 + 2
	staa res + 2
	ldaa 1,x
	sbca num2 + 1
	staa res + 1
	ldaa 0,x
	sbca num2
	staa res
	rts

; Add two 32 bit numbers in num1, num2.
; Store result in res.
Add_32 SUBROUTINE
	clc
	ldx #num1
	ldaa 3,x
	adca num2 + 3
	staa res + 3
	ldaa 2,x
	adca num2 + 2
	staa res + 2
	ldaa 1,x
	adca num2 + 1
	staa res + 1
	ldaa 0,x
	adca num2
	staa res
	rts
	
Sum SUBROUTINE
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

; Read string into buffer pointed to by
; r0r1. 
; Max chars to read in A. 
ReadString SUBROUTINE
	ldx r0			;load address of buffer
	ldab #0			; use B as a counter, set it to 0
	staa r2			; store count in r2
.1:
	pshx
	jsr Inkey
	pulx	
	cmpa #$0d
	beq .done
	staa 0,x
	inx
	incb
	cmpb r2
	beq .done
	jmp .1
.done:
	rts
	
; Wait for a key to be pressed.  Return
; the pressed key in ACCA.
; Destroys: A, X
Inkey SUBROUTINE
	ldaa #$0		; initialize ACCA to 0
	ldx POLCAT		; load address of POLCAT
.1:
	jsr 0,x			; strobe the keyboard
	cmpa #$0		; check if no key pressed
	beq .1			; if no key, loop
	rts				; return
	
; Variables
prompt:
	dc.b ">",0
msg_1:
	dc.b "ENTER UP TO 100 NUMBERS",0
buffer:				;input buffer for numbers
	ds.b 8			
count:				;number of numbers entered
	ds.b 1
index:				;index into number_array
	ds.b 1
sum:				;sum of number_array
	ds.l 1
number_array:
	ds.l 100
num1:				; 32 bit add num1
	dc.l $FFFFFFFF	
num2:				; 32 bit add num2
	dc.l $00000003
res:				; 32 bit add result
	ds.l 1
atoi_res:
	ds.l 1
scratch:
	dc.l 1