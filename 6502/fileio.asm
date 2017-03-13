	processor 6502
	org $1000
	
	include "c64.asm"

Main SUBROUTINE
	
	lda #1
	ldx #9
	ldy #8
	jsr SETLFS
	
	lda #FileNameLen-FileName
	ldx #<FileName
	ldy #>FileName
	jsr SETNAM
	
	jsr OPEN
	ldx #1
	jsr CHKIN
	jsr CLOSE
	brk
FileName:
	dc.b "DISK/EXMON.DOC"
FileNameLen:
	