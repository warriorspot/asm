	processor 6803
	org $4500
	
	include "MC10.asm"
	
	jmp main
	
main SUBROUTINE
	ldaa #SG6
	staa r8
	staa vdgport
	ldaa #129
	ldab #$ff
	stab r1
.loop
	staa r0
	ldaa r1
	inca
	staa r1
	ldab #$1
	jsr sound
	jsr clear_screen
	ldaa r0
	inca
	inca
	bne .loop
	ldaa #129
	jmp .loop
	ldaa #SG4
	staa vdgport
	rts
	
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
	rts                           ; return
	
; Fill screen memory with the value stored
; in r0. Destroys r2,r3
clear_screen SUBROUTINE
	psha
	pshx
	ldaa r0
	sts r2
	lds #screen + $01ff
.1:
	psha
	tsx
	cpx #$4000
	bne .1
	lds r2
	pulx
	pula
	rts