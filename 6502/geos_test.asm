	processor 6502
	org $400

	include "GEOS_DEF.asm"
	include "GEOS_VAR.asm"
	include "GEOS_FUNC.asm"
	
	lda #(ST_WR_FORE | ST_WR_BACK)
	sta dispBufferOn
	lda <#ClearScreen
	sta r0
	lda >#ClearScreen
	sta r0+1
	jsr GraphicsString
	
	lda <#MyMenu
	sta r0
	lda >#MyMenu
	sta r0+1
	lda #0
	jsr DoMenu
	
	lda <#MyIcons
	sta r0
	lda >#MyIcons
	sta r0+1
	jsr DoIcons
	rts
	
ClearScreen:
	dc.b NEWPATTERN,2
	dc.b MOVEPENTO
	dc.w 0
	dc.b 0
	dc.b RECTANGLETO
	dc.w 319
	dc.b 199
	dc.b NULL
	
DoMyIcon:
	rts
DoAbout:
	jsr GotoFirstMenu
	rts
DoClose:
	jsr GotoFirstMenu
	rts
DoQuit:
	jsr GotoFirstMenu
	jmp EnterDeskTop
	rts
	
MyMenu: 
	dc.b 0, 14
	dc.w 0,49
	dc.b 2 | HORIZONTAL
	
	dc.w GeosText
	dc.b VERTICAL
	dc.w GeosSubMenu
	
	dc.w FileText
	dc.b VERTICAL
	dc.w FileSubMenu

GeosSubMenu:
	dc.b 15,30
	dc.w 0,79
	dc.b 1 | VERTICAL
	
	dc.w AboutText
	dc.b MENU_ACTION
	dc.w DoAbout

FileSubMenu:
	dc.b 15,44
	dc.w 29,64
	dc.b 2 | VERTICAL
	
	dc.w CloseText
	dc.b MENU_ACTION
	dc.w DoClose
	
	dc.w QuitText
	dc.b MENU_ACTION
	dc.w DoQuit
	
MyIcons:
	dc.b 1 		;number of icons
	dc.w 0
	dc.b 0
	
	dc.w IconData
	dc.b $10	
	dc.b $10
	dc.b $2
	dc.b $16
	dc.w DoMyIcon
	
IconData:
	ds.b 64,#$aa 
; Strings for icons and menus
GeosText:
	dc.b "geos",0
FileText:
	dc.b "file",0
AboutText:
	dc.b "Brennan info",0
CloseText:
	dc.b "close",0
QuitText:
	dc.b "quit",0