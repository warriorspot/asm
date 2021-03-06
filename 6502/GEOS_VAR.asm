;GEOS variable memory locations sorted by address
;reassembled by Maciej 'YTM/Alliance' Witkowiak
;4-2-99
 
zpage equ $0000
;
CPU_DDR equ $00
CPU_DATA equ $01
;
r0 equ $02
r0L equ $02
r0H equ $03
r1 equ $04
r1L equ $04
r1H equ $05
r2 equ $06
r2L equ $06
r2H equ $07
r3 equ $08
r3L equ $08
r3H equ $09
r4 equ $0a
r4L equ $0a
r4H equ $0b
r5 equ $0c
r5L equ $0c
r5H equ $0d
r6 equ $0e
r6L equ $0e
r6H equ $0f
r7 equ $10
r7L equ $10
r7H equ $11
r8 equ $12
r8L equ $12
r8H equ $13
r9 equ $14
r9L equ $14
r9H equ $15
r10 equ $16
r10L equ $16
r10H equ $17
r11 equ $18
r11L equ $18
r11H equ $19
r12 equ $1a
r12L equ $1a
r12H equ $1b
r13 equ $1c
r13L equ $1c
r13H equ $1d
r14 equ $1e
r14L equ $1e
r14H equ $1f
r15 equ $20
r15L equ $20
r15H equ $21
;
a0 equ $fb
a0L equ $fb
a0H equ $fc
a1 equ $fd
a1L equ $fd
a1H equ $fe
a2 equ $70
a2L equ $70
a2H equ $71
a3 equ $72
a3L equ $72
a3H equ $73
a4 equ $74
a4L equ $74
a4H equ $75
a5 equ $76
a5L equ $76
a5H equ $77
a6 equ $78
a6L equ $78
a6H equ $79
a7 equ $7a
a7L equ $7a
a7H equ $7b
a8 equ $7c
a8L equ $7c
a8H equ $7d
a9 equ $7e
a9L equ $7e
a9H equ $7f
 
;
 
curPattern equ $22
string equ $24
baselineOffset equ $26
curSetWidth equ $27
curHeight equ $29
curIndexTable equ $2a
cardDataPntr equ $2c
currentMode equ $2e
dispBufferOn equ $2f
mouseOn equ $30
RAM_64K equ $30
msePicPtr equ $31
windowTop equ $33
windowBottom equ $34
leftMargin equ $35
IO_IN equ $35
KRNL_IO_IN equ $36
rightMargin equ $37
KRNL_BAS_IO_IN equ $37
pressFlag equ $39
mouseXPos equ $3a
mouseYPos equ $3c
returnAddress equ $3d
graphMode equ $3f
TURBO_DD00 equ $8e ; from 1541 turbo
TURBO_DD00_CPY equ $8f ; from 1541 turbo
STATUS equ $90
curDevice equ $ba
;
irqvec equ $0314
bkvec equ $0316
nmivec equ $0318
;
APP_RAM equ $0400
BACK_SCR_BASE equ $6000
PRINTBASE equ $7900
OS_VARS equ $8000
;
diskBlkBuf equ $8000
fileHeader equ $8100
curDirHead equ $8200
fileTrScTab equ $8300
dirEntryBuf equ $8400
DrACurDkNm equ $841e
DrBCurDkNm equ $8430
dataFileName equ $8442
dataDiskName equ $8453
PrntFilename equ $8465
PrntDiskName equ $8476
curDrive equ $8489
diskOpenFlg equ $848a
isGEOS equ $848b
interleave equ $848c
NUMDRV equ $848d
driveType equ $848e
_driveType equ driveType-8
turboFlags equ $8492
_turboFlags equ turboFlags-8
curRecord equ $8496
usedRecords equ $8497
fileWritten equ $8498
fileSize equ $8499
appMain equ $849b
intTopVector equ $849d
intBotVector equ $849f
mouseVector equ $84a1
keyVector equ $84a3
inputVector equ $84a5
mouseFaultVec equ $84a7
otherPressVec equ $84a9
StringFaultVec equ $84ab
alarmTmtVector equ $84ad
BRKVector equ $84af
RecoverVector equ $84b1
selectionFlash equ $84b3
alphaFlag equ $84b4
iconSelFlg equ $84b5
faultData equ $84b6
menuNumber equ $84b7
mouseTop equ $84b8
mouseBottom equ $84b9
mouseLeft equ $84ba
mouseRight equ $84bc
stringX equ $84be
stringY equ $84c0
mousePicData equ $84c1
maxMouseSpeed equ $8501
minMouseSpeed equ $8502
mouseAccel equ $8503
keyData equ $8504
mouseData equ $8505
inputData equ $8506
mouseSpeed equ $8507
random equ $850a
saveFontTab equ $850c
dblClickCount equ $8515
year equ $8516
month equ $8517
day equ $8518
hour equ $8519
minutes equ $851a
seconds equ $851b
alarmSetFlag equ $851c
sysDBData equ $851d
screencolors equ $851e
dlgBoxRamBuf equ $851f ; to $8697
;
;$8698 - $8877 - various system data (keyboard queue, VLIR t&s, DBox, Menu, timers)
;
savedmoby2 equ $88bb
scr80polar equ $88bc
scr80colors equ $88bd
vdcClrMode equ $88be
driveData equ $88bf
ramExpSize equ $88c3
sysRAMFlg equ $88c4
firstBoot equ $88c5
curType equ $88c6
ramBase equ $88c7
inputDevName equ $88cb
memBase equ $88cf ;???
DrCCurDkNm equ $88dc
DrDCurDkNm equ $88ee
dir2Head equ $8900
;
SPRITE_PICS equ $8a00
spr0pic equ $8a00
spr1pic equ $8a40
spr2pic equ $8a80
spr3pic equ $8ac0
spr4pic equ $8b00
spr5pic equ $8b40
spr6pic equ $8b80
spr7pic equ $8bc0
COLOR_MATRIX equ $8c00
;
obj0Pointer equ $8ff8
obj1Pointer equ $8ff9
obj2Pointer equ $8ffa
obj3Pointer equ $8ffb
obj4Pointer equ $8ffc
obj5Pointer equ $8ffd
obj6Pointer equ $8ffe
obj7Pointer equ $8fff
;
DISK_BASE equ $9000
SCREEN_BASE equ $a000
OS_ROM equ $c000
OS_JUMPTAB equ $c100
RAMC_BASE equ $de00
RAMC_WINDOW equ $df00
EXP_BASE equ $df00
MOUSE_BASE_128 equ $fd00
MOUSE_JMP_128 equ $fd00
END_MOUSE_128 equ $fe80
MOUSE_BASE equ $fe80
MOUSE_JMP equ $fe80
config equ $ff00
END_MOUSE equ $fffa
NMI_VECTOR equ $fffa
RESET_VECTOR equ $fffc
IRQ_VECTOR equ $fffe
;
vicbase equ $d000
sidbase equ $d400
mmu equ $d500
VDC equ $d600
ctab equ $d800
cia1base equ $dc00
cia2base equ $dd00
;
mob0xpos equ $d000
mob0ypos equ $d001
mob1xpos equ $d002
mob1ypos equ $d003
mob2xpos equ $d004
mob2ypos equ $d005
mob3xpos equ $d006
mob3ypos equ $d007
mob4xpos equ $d008
mob4ypos equ $d009
mob5xpos equ $d00a
mob5ypos equ $d00b
mob6xpos equ $d00c
mob6ypos equ $d00d
mob7xpos equ $d00e
mob7ypos equ $d00f
msbxpos equ $d010
grcntrl1 equ $d011
rasreg equ $d012
lpxpos equ $d013
lpypos equ $d014
mobenble equ $d015
grcntrl2 equ $d016
grmemptr equ $d018
grirq equ $d019
grirqen equ $d01a
moby2 equ $d017
mobprior equ $d01b
mobmcm equ $d01c
mobx2 equ $d01d
mobmobcol equ $d01e
mobbakcol equ $d01f
extclr equ $d020
bakclr0 equ $d021
bakclr1 equ $d022
bakclr2 equ $d023
bakclr3 equ $d024
mcmclr0 equ $d025
mcmclr1 equ $d026
mob0clr equ $d027
mob1clr equ $d028
mob2clr equ $d029
mob3clr equ $d02a
mob4clr equ $d02b
mob5clr equ $d02c
mob6clr equ $d02d
mob7clr equ $d02e
keyreg equ $d02f
clkreg equ $d030
 
;
vdcreg equ $d600
vdcdata equ $d601
;
 
bootName    equ    $c006
version     equ    $c00f
nationality    equ    $c010
sysFlgCopy    equ    $c012
c128Flag    equ    $c013
dateCopy        equ       $c018