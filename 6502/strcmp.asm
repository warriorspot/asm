	processor 6502
	org $3000
 	
r0 equ $fb
r1 equ $fd
	
 	lda array
 	sta r0
 	lda array + 1
 	sta r0+1
 	lda array + 2
 	sta r1
 	lda array + 3
 	sta r1 + 1
 	jsr strcmp
 	
 	lda array + 4
 	sta r1
 	lda array + 5
 	sta r1 + 1
 	jsr strcmp
 	
 	brk
	 	
strcmp SUBROUTINE
	ldy #$00		;init counter to 0
.1 
	lda (r0),y		; A = *a
	beq .5		    ; if A = 0, a < b, done
	lda (r1),y		; A = *b
	beq .2			; if A = 0, return 1
	jmp .3			; else goto .3
.2
	lda #$01		; return 1
	rts
.3  
    lda (r0),y		; A = *a
    cmp (r1),y		; A = *a - *b
    bmi .5			; a < b, return -1
    beq .4			; a = b
    lda #$01		; a > b
    rts
.4
	iny				; inc counter
	jmp .1			; and keep looping
.5
	lda #$ff		; return -1
.done
	rts

string1: 
	dc.b "Brennan", 0
string2:
	dc.b "Joe",0
string3:
	dc.b "Brennan1",0

array:
	dc.w string1
	dc.w string2
	dc.w string3