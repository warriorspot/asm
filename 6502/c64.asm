;C64 Kernal routines
ACPTR = $FFA5
CHKIN = $FFC6
CHKOUT = $FFC9
CHRIN = $FFCF
CHROUT = $FFD2
CIOUT = $FFA8
CINT = $FF81
CLALL = $FFE7
CLOSE = $FFC3
CLRCHN = $FFCC
GETIN = $FFE4
IOBASE = $FFF3
IOINIT = $FF84
LISTEN = $FFB1
LOAD = $FFD5
MEMBOT = $FF9C
MEMTOP = $FF99
OPEN = $FFC0
PLOT = $FFF0
RAMTAS = $FF87
RDTIM = $FFDE
READST = $FFB7
RESTOR = $FF8A
SAVE = $FFD8
SCNKEY = $FF9F
SCREEN = $FFED
SECOND = $FF93
SETLFS = $FFBA
SETMSG = $FF90
SETNAM = $FFBD
SETTIM = $FFDB
SETTMO = $FFA2
STOP = $FFE1
TALK = $FFB4
TKSA = $FF96
UDTIM = $FFEA
UNLSN = $FFAE
UNTLK = $FFAB
VECTOR = $FF8D

CR = $0D

; Safe zero page addresses
r0 = $FB
r1 = $FD
r0H = $FC
r0L = $FB
r1H = $FE
r1L = $FD

; Datasette related zero page addresses
; Assume noone is using a datasette and 
; use these as general purpose zero page registers
ds0 = $92
ds1 = $94
ds0L = $92
ds0H = $93
ds1L = $94
ds1H = $95
dsX = $96 ; "extra" byte of datasette related zero page.
