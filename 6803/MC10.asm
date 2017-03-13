
MEM_START 		equ $4200		;Start of RAM
MEM_START_BASIC equ $4346		;Start of BASIC RAM (free memory)
MEM_END 		equ $4FFF		;End of RAM (unexpanded)
MEM_END_EXP		equ $BFFF		;End of RAM (expanded)
	
MEM_ROM_START 	equ $E000		;start of ROM

;6803 internals
TCSR	equ $08			;Timer Status and Control register
TIMER   equ $09			;Timer (2 bytes)
TOCR    equ $0B			;Timer output compare flag

;6803 interrupt vectors
SCIVEC 	equ $4200		; SCI
TOFVEC	equ $4203       ; Timer Overflow
OCFVEC	equ $4206       ; Output Compare
ICFVEC	equ $4209       ; Input Capture
IRQVEC	equ $420C       ; IRQ1
SWIVEC	equ $420F       ; SWI
NMIVEC	equ $4212       ; NMI

; Extension hooks
RVEC1   equ $4285   	; extension hook for CONSOLE IN
RVEC2   equ $4288		; extension hook for CONSOLE OUT
RVEC3  	equ $428B		; extension hook to install Tab and Line settings for output device
RVEC4  	equ $428E		; extension hook for program initialization (NEW,RUN,CLEAR)
RVEC5   equ $4291		; extension hook for line input
RVEC6   equ $4294		; extension hook for expression terminal evaluator
RVEC7   equ $4297		; extension hook for implementing ON ERR GOTO
RVEC8   equ $429A		; extension hook for additional error messages
RVEC9   equ $429D		; extension hook for ASCII to FP number conversion
RVEC10  equ $42A0		; extension hook for command dispatcher
RVEC11  equ $42A3		; extension hook for crunching keywords
RVEC12  equ $42A6		; extension hook for uncrunching a token
RVEC13  equ $42A9		; extension hook for polling the keyboard
RVEC14	equ	$42AC   	; Control key handling extension

; ROM routine vectors
POLCAT	equ	$FFDC		; Read the keyboard
CHROUT	equ	$FFDE		; Output a character to the current device
RDCLDR	equ	$FFE0		; Read cassette leader	
BLKIN	equ	$FFE2		; Read a block of data to the cassette	
BLKOUT	equ	$FFE4		; Write a block of data from the cassette
SNDOUT	equ	$FFE6		; Sound Output	
WRTLDR	equ	$FFE8		; Write Leader	
GIVABF	equ	$FFEA		; Convert 2 bytes to Basic	
INTCNV	equ	$FFEC		; Convert BASIC to 2 bytes

; ROM entry points
WARMSTART equ $F7C3		; CPU warm start

; System variables
CTRLKY	equ	$423A		;Control key state ($FF = down)
CRSPTR  equ $4280       ; cursor Position
CRSCLR  equ $4282		; cursor color

; Screen and video
screen  equ	$4000		; address of MC-10 screen memory
vdgport equ	$BFFF		; I/O address to set the VDG mode	
SG4 	equ	%00000000	; SG4 semigraphics 4 mode bits	
SG6 	equ	%00000100	; SG6 semigraphics 6 mode bits
CG1		equ %00100000	; CG1 graphics mode bits
RG1		equ %00110000	; RG1 graphics mode bits
CG2		equ %00101000	; CG2 graphics mode bits
RG2		equ %00111000	; RG2 graphics mode bits
CG3		equ %00100100	; CG3 graphics mode bits6000
RG3		equ %00110100	; RG3 graphics mode bits
CG6		equ %00101100	; CG6 graphics mode bits
RG6		equ %00111100	; RG6 graphics mode bits
CSS		equ %01000000	; color set select bit

; Cassette I/O
BLKPTR	equ $4278		;pointer to cassette block load storage space
BLKTYP  equ $4275		;block type of most recently read block
BLKLEN  equ $4276 		;block length of most recently read block
CSFNBLOCK equ 15		;cassette filename block size
CASPOL    equ		$427e	;cassette polarity, set by RDCLDR

;Helpful defines
BS        equ       $08                 ; backspace
CR        equ       $0D                 ; carriage return (ENTER)
PAUSE     equ       $13                 ; PAUSE control code (Shift-@)
SPACE     equ       $20                 ; space


; define unused zero page addresses as pseudo registers
r0 equ $f9
r1 equ $fa
r2 equ $fb
r3 equ $fc
r4 equ $fd
r5 equ $fe
r6 equ $ff
r7 equ $e0
r8 equ $e1