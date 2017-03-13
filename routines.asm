; Wait for a key to be pressed.  Return
; the pressed key in ACCA.
; Destroys: A, X
inkey SUBROUTINE
	ldaa #$0		; initialize ACCA to 0
	ldx POLCAT		; load address of POLCAT
.1:
	jsr 0,x			; strobe the keyboard
	cmpa #$0		; check if no key pressed
	beq .1			; if no key, loop
	rts				; return

; Read string into buffer pointed to by
; r0r1.  Quits when the enter key is 
; pressed.
read_string SUBROUTINE
	ldx r0
.1:
	jsr inkey
	cmpa #$0d
	beq .done
	staa 0,x
	inx
	jmp .1
.done:
	rts
	
; Copy up to one page of memory from point A to
; point B.  Destroys X, A, B
; r0,r1 = source address
; r2,r3 = destination address
; r4	= number of bytes to copy
; When this subroutine returns, r0,r1 and r2,r3 will contain
; values that ready to copy another r4 bytes from src to dest,
; so this routine can be called repeatedly to keep copying 
; r4 bytes from src to dest (i.e. set r4 to FF and call 3 times
; to copy 3 pages).
memcpy SUBROUTINE  
	ldab #$0			;initialize counter to 0
.loop:	
	ldx r0				;load source address
	ldaa 0,x			;load byte at source
	inx					;increment source
	stx r0				;store source in r0
	ldx r2				;load destination in X
	staa 0,x			;store the byte in the destination
	inx					;increment the destination
	stx r2				;store the destination
	incb				;increment the counter
	cmpb r4				;compare to r4
	bne .loop			; < 4? Continure
	rts					; done
	
;Print the 0 terminated string pointed to in r0,r1.
;In: r0,r1 = pointer to string
;In: B = if > 0 add a CR at the end
;Destroys: A, B, X
print_string SUBROUTINE
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
	
;Store value in ACCA in memory
;starting at r0,r1 to r2,r3
;destroys: X
memset SUBROUTINE
	ldx r0
.1:
	staa 0,x
	inx
	cpx r2
	bne .1
	rts
	
; Sound subroutine from ROM that does not destroy current
; VDG mode.  
; Expects current video mode in r8
sound SUBROUTINE
	psha                          ; push pitch..
	pshb                          ; ..and duration onto stack
	ldaa r8
.LFFAE
	ldx       TIMER               ; get current CPU timer value
	ldab      TCSR                ; clear the Output Compare Flag
	stx       TOCR                ; store new Output Compare value
.LFFB4
	eora      #$80                ; toggle sound output state
	staa      vdgport             ; update hardware
	tsx                           ; point X to stacked parameters
	ldab      1,X                 ; ACCB = pitch counter
.LFFBC
	inx                           ; (3) delay
	inx                           ; (3) delay
	incb                          ; (2) increment pitch counter
	bne       .LFFBC               ; (3) loop until pitch counter = 0
	
	ldab      TCSR                ; read timer status register
	andb      #$40                ; test the Output Compare flag
	beq       .LFFB4               ; loop if timer hasn't fully cycled
	
	tsx                           ; point X to stacked parameters
	dec       ,X                  ; decrement duration counter
	bne       .LFFAE               ; loop if duration hasn't expired
	ldaa	  r8
	oraa #$0
	staa      vdgport              ; set sound hardware state
	pulx                          ; pop parameters off the stack
.LFFD1
	rts     