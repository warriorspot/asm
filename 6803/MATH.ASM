   processor 6803
   org $100

   INCLUDE "MC10.ASM"


   ldaa #$9
   staa r0
   ldaa #$1
   staa r1
   jsr Add8
   ldaa #$10
   staa r0
   ldaa #$FF
   staa r1
   ldaa #$32
   staa r2
   ldaa #$01
   staa r3
   jsr Add16
   nop
   nop

; Add two 8 bit numbers in r0, r1
; Answer returned in r0
; Carry flag set on overflow
Add8 SUBROUTINE
    clc
    ldaa r0
    adca r1
    staa r0
    rts

; Add 2 16 bit numbers in r0-r1, r2-r3.
; Answer returned in r0-r1
Add16 SUBROUTINE
    clc
    ldaa r1
    adca r3
    staa r1
    ldaa r0
    adca r2
    staa r0
    rts

; Add 2 32 bit integers in r0-3, r4-7
; Store result in r0-3
Add32 SUBROUTINE
   clc
   ldaa r3
   adca r7
   staa r3
   ldaa r2
   adca r6
   staa r2
   ldaa r1
   adca r5
   staa r1
   ldaa r0
   adca r3
   staa r0
   rts
