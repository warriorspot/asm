NULL equ 0
FALSE equ NULL
TRUE equ $ff
 
MOUSE_SPRNUM equ 0
 
DISK_DRV_LGH equ $0d80
 
;
;filetypes
;    GEOS
NOT_GEOS equ 0
BASIC     equ 1
ASSEMBLY equ 2
DATA     equ 3
SYSTEM     equ 4
DESK_ACC equ 5
APPLICATION equ 6
APPL_DATA equ 7
FONT     equ 8
PRINTER  equ 9
INPUT_DEVICE equ 10
DISK_DEVICE equ 11
SYSTEM_BOOT equ 12
TEMPORARY equ 13
AUTO_EXEC equ 14
INPUT_128 equ 15
NUMFILETYPES equ 16
;    structure
SEQUENTIAL equ 0
VLIR     equ 1
;    DOS
DEL     equ 0
SEQ     equ 1
PRG     equ 2
USR     equ 3
REL     equ 4
CBM     equ 5
 
;drivetypes
DRV_NULL equ 0
DRV_1541 equ 1
DRV_1571 equ 2
DRV_1581 equ 3
DRV_NETWORK equ 15
 
;various disk
REL_FILE_NUM equ 9
CMND_FILE_NUM equ 15
MAX_CMND_STR equ 32
DIR_1581_TRACK equ 40
DIR_ACC_CHAN equ 13
DIR_TRACK equ 18
N_TRACKS equ 35
DK_NM_ID_LEN equ 18
TRACK     equ 9
SECTOR     equ 12
TOTAL_BLOCKS equ 664
 
;colours
BLACK     equ 0
WHITE     equ 1
RED     equ 2
CYAN     equ 3
PURPLE     equ 4
GREEN     equ 5
BLUE     equ 6
YELLOW     equ 7
ORANGE     equ 8
BROWN     equ 9
LTRED     equ 10
DKGREY     equ 11
GREY     equ 12
MEDGREY  equ 12
LTGREEN  equ 13
LTBLUE     equ 14
LTGREY     equ 15
 
;vic memory banks
GRBANK0  equ %11
GRBANK1  equ %10
GRBANK2  equ %01
GRBANK3  equ %00
 
;screen
VIC_X_POS_OFF equ 24
VIC_Y_POS_OFF equ 50
SC_BYTE_WIDTH equ 40
SC_PIX_HEIGHT equ 200
SC_PIX_WIDTH equ 320
SC_SIZE  equ 8000
;128 screen size constants
SCREENBYTEWIDTH     equ    80
SCREENPIXELWIDTH    equ    640
 
 
;control characters
EOF     equ 0
BACKSPACE equ 8
FORWARDSPACE equ 9
TAB     equ 9
LF     equ 10
HOME     equ 11
PAGE_BREAK equ 12
UPLINE     equ 12
CR     equ 13
ULINEON  equ 14
ULINEOFF equ 15
ESC_GRAPHICS equ 16
ESC_RULER equ 17
REV_ON     equ 18
REV_OFF  equ 19
GOTOX     equ 20
GOTOY     equ 21
GOTOXY     equ 22
NEWCARDSET equ 23
BOLDON     equ 24
ITALICON equ 25
OUTLINEON equ 26
PLAINTEXT equ 27
 
;keyboard
KEY_F1     equ 1
KEY_F2     equ 2
KEY_F3     equ 3
KEY_F4     equ 4
KEY_F5     equ 5
KEY_F6     equ 6
KEY_NOSCRL equ 7
KEY_ENTER equ 11
KEY_F7     equ 14
KEY_F8     equ 15
KEY_UP     equ 16
KEY_DOWN equ 17
KEY_HOME equ 18
KEY_CLEAR equ 19
KEY_LARROW equ 20
KEY_UPARROR equ 21
KEY_STOP equ 22
KEY_RUN  equ 23
KEY_BPS  equ 24
KEY_HELP equ 25
KEY_ALT  equ 26
KEY_ESC  equ 27
KEY_INSERT equ 28
KEY_DELETE equ 29
KEY_RIGHT equ 30
KEY_INVALID equ 31
KEY_LEFT equ BACKSPACE
 
;DialogBox
;    icons
OK     equ 1
CANCEL     equ 2
YES     equ 3
NO     equ 4
OPEN     equ 5
DISK     equ 6
;    commands
DBTXTSTR equ 11
DBVARSTR equ 12
DBGETSTRING equ 13
DBSYSOPV equ 14
DBGRPHSTR equ 15
DBGETFILES equ 16
DBOPVEC  equ 17
DBUSRICON equ 18
DB_USR_ROUT equ 19
;    tabulation in standard window
DBI_X_0  equ 1
DBI_X_1  equ 9
DBI_X_2  equ 17
DBI_Y_0  equ 8
DBI_Y_1  equ 40
DBI_Y_2  equ 72
;    standard window
SET_DB_POS equ 0
DEF_DB_POS equ $80
DEF_DB_TOP equ 32
DEF_DB_BOT equ 127
DEF_DB_LEFT equ 64
DEF_DB_RIGHT equ 255
;    text tabulation
TXT_LN_1_Y equ 16
TXT_LN_2_Y equ 32
TXT_LN_3_Y equ 48
TXT_LN_4_Y equ 64
TXT_LN_5_Y equ 80
TXT_LN_X equ 16
;    ???
SYSDBI_HEIGHT equ 16
SYSDBI_WIDTH equ 6
 
;GraphicsString - commands
MOVEPENTO equ 1
LINETO     equ 2
RECTANGLETO equ 3
NEWPATTERN equ 5
ESC_PUTSTRING equ 6
FRAME_RECTO equ 7
PEN_X_DELTA equ 8
PEN_Y_DELTA equ 9
PEN_XY_DELTA equ 10
 
 
;DoMenu - menutypes
MENU_ACTION equ $00
DYN_SUB_MENU equ $40
SUB_MENU equ $80
HORIZONTAL equ %00000000
VERTICAL equ %10000000
 
;Errors
ANY_FAULT equ %11110000
NO_BLOCKS equ 1
INV_TRACK equ 2
INSUFF_SPACE equ 3
FULL_DIRECTORY equ 4
FILE_NOT_FOUND equ 5
BAD_BAM  equ 6
UNOPENED_VLIR equ 7
INV_RECORD equ 8
OUT_OF_RECORDS equ 9
STRUCT_MISMAT equ 10
BFR_OVERFLOW equ 11
CANCEL_ERR equ 12
DEV_NOT_FOUND equ 13
INCOMPATIBLE equ 14
HDR_NOT_THERE equ $20
NO_SYNC  equ $21
DBLK_NOT_THERE equ $22
DAT_CHKSUM_ERR equ $23
WR_VER_ERR equ $25
WR_PR_ON equ $26
HDR_CHKSUM_ERR equ $27
DSK_ID_MISMAT equ $29
BYTE_DEC_ERR equ $2e
DOS_MISMATCH equ $73
 
;Offsets
;    ???
OFF_INDEX_PTR equ 1
;    icons
OFF_NM_ICNS equ 0
OFF_IC_XMOUSE equ 1
OFF_IC_YMOUSE equ 3
OFF_PIC_ICON equ 0
OFF_X_ICON_POS equ 2
OFF_Y_ICON_POS equ 3
OFF_WDTH_ICON equ 4
OFF_HEIGHT_ICON     equ    5
OFF_SRV_RT_ICON     equ    6
OFF_NX_ICON equ 8
;    menu
OFF_MY_TOP equ 0
OFF_MY_BOT equ 1
OFF_MX_LEFT equ 2
OFF_MX_RIGHT equ 4
OFF_NUM_M_ITEMS     equ    6
OFF_1ST_M_ITEM equ 7
;    dialog box
OFF_DB_FORM equ 0
OFF_DB_TOP equ 1
OFF_DB_BOT equ 2
OFF_DB_LEFT equ 3
OFF_DB_RIGHT equ 5
OFF_DB_1STCMD equ 7
;    directory
;        disk header
OFF_TO_BAM equ 4
OFF_DISK_NAME equ 144
OFF_GS_DTYPE equ 189
OFF_OP_TR_SC equ 171
OFF_GS_ID equ 173
;        dir entry
FRST_FILE_ENTRY     equ    2
OFF_CFILE_TYPE equ 0
OFF_DE_TR_SC equ 1
OFF_FNAME equ 3
OFF_GHDR_PTR equ 19
OFF_GSTRUC_TYPE     equ    21
OFF_GFILE_TYPE equ 22
OFF_YEAR equ 23
OFF_SIZE equ 28
OFF_NXT_FILE equ 32
;        file header
O_GHIC_WIDTH equ 2
O_GHIC_HEIGHT equ 3
O_GHIC_PIC equ 4
O_GHCMDR_TYPE equ 68
O_GHGEOS_TYPE equ 69
O_GHSTR_TYPE equ 70
O_GHST_ADDR equ 71
O_GHEND_ADDR equ 73
O_GHST_VEC equ 75
O_GHFNAME equ 77
O_128_FLAGS equ 96
O_GH_AUTHOR equ 97
O_GHP_DISK equ 97
O_GHP_FNAME equ 117
O_GHINFO_TXT equ $a0
 
;values for config - C128 mmu
CIOIN     equ $7E    ;60K RAM, 4K I/O space in
CRAM64K  equ $7F    ;64K RAM
CKRNLBASIOIN equ $40    ;kernal, I/O and basic ROM's mapped into memory
CKRNLIOIN equ $4E    ;Kernal ROM and I/O space mapped in
 
;values of faultData - pointer position vs. mouseTop/Bottom/Left/Right
;    bit numbers
OFFTOP_BIT equ 7
OFFBOTTOM_BIT equ 6
OFFLEFT_BIT equ 5
OFFRIGHT_BIT equ 4
OFFMENU_BIT equ 3
;    masks
SET_OFFTOP equ %10000000
SET_OFFBOTTOM equ %01000000
SET_OFFLEFT equ %00100000
SET_OFFRIGHT equ %00010000
SET_OFFMENU equ %00001000
 
;values of currentMode
;    bit numbers
UNDERLINE_BIT equ 7
BOLD_BIT equ 6
REVERSE_BIT equ 5
ITALIC_BIT equ 4
OUTLINE_BIT equ 3
SUPERSCRIPT_BIT     equ    2
SUBSCRIPT_BIT equ 1
;    masks
SET_UNDERLINE equ %10000000
SET_BOLD equ %01000000
SET_REVERSE equ %00100000
SET_ITALIC equ %00010000
SET_OUTLINE equ %00001000
SET_SUPERSCRIPT     equ    %00000100
SET_SUBSCRIPT equ %00000010
SET_PLAINTEXT equ %00000000
 
;Process control variable
;    bit numbers
RUNABLE_BIT equ 7
BLOCKED_BIT equ 6
FROZEN_BIT equ 5
NOTIMER_BIT equ 4
;    masks
SET_RUNABLE equ %10000000
SET_BLOCKED equ %01000000
SET_FROZEN equ %00100000
SET_NOTIMER equ %00010000
 
;mouseOn
;    bit numbers
MOUSEON_BIT equ 7
MENUON_BIT equ 6
ICONSON_BIT equ 5
;    masks
SET_MSE_ON equ %10000000
SET_MENUON equ %01000000
SET_ICONSON equ %00100000
 
;pressFlag
;    bit numbers
KEYPRESS_BIT equ 7
INPUT_BIT equ 6
MOUSE_BIT equ 5
;    masks
SET_KEYPRESS equ %10000000
SET_INPUTCHG equ %01000000
SET_MOUSE equ %00100000
 
;dispBufferOn
ST_WRGS_FORE equ $20
ST_WR_BACK equ $40
ST_WR_FORE equ $80
 
;alarmSetFlag
ALARMMASK equ %00000100
 
;bit number ???
SET_NOSURPRESS equ %00000000
SET_SURPRESS equ %01000000
 
;GeoWrite ???
SET_RIGHTJUST equ %00000000
SET_LEFTJUST equ %10000000
 
;icons, menus status flags
ST_FLASH equ $80
ST_INVERT equ $40
ST_LD_AT_ADDR equ $01
ST_LD_DATA equ $80
ST_PR_DATA equ $40
ST_WR_PR equ $40
 
;???
ADD1_W     equ $2000
DOUBLE_B equ $80
DOUBLE_W equ $8000
 
CLR_SAVE equ %01000000
CONSTRAINED equ %01000000
UN_CONSTRAINED equ %00000000
FG_SAVE  equ %10000000
 
FUTURE1  equ 7
FUTURE2  equ 8
FUTURE3  equ 9
FUTURE4  equ 10
USELAST  equ 127
SHORTCUT equ 128