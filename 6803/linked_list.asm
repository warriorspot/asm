	processor 6502
	org $400

	; Make a linked list of 8 bit values.

r0 equ $0000
r1 equ $0002
b1 equ $0004
b2 equ $0005
b3 equ $0006

; Values to use as offsets into a node struture
node_data equ 0		;offset 0 is the data
node_next equ 1 	;offset 1 is the pointer to the next node
node_size equ 3			;size of a node (1 byte data, 1 word next pointer)

list_head equ 0
list_tail equ 2
list_count equ  4

	; for each non-zero value in data_table, add a new
	; node to the linked list.
	ldx #$00
.loop
	lda data_table,x
	beq .done
	sta b1
	stx b2
	jsr NewNode
	stx r0
	sta r0 + 1
 	lda b1
	ldy #$00
	sta (r0), y
				
.done
	brk

; Return number of items in the list in A		
Count SUBROUTINE
	lda linked_list + list_count		
	rts

; Return address of new node.  Low byte
; in X, high byte in A
; Destroys X, A, r0
NewNode SUBROUTINE
	lda #<nodes
	sta $00
	lda #>nodes
	sta $01
	clc
	ldx linked_list + list_count;
	beq .done	
	lda #node_size	
.1
	adc $00
	dex
	bne .1
		
.done
	ldx $00
	lda $01
	rts

Add SUBROUTINE
	rts

AddAtHead SUBROUTINE
	rts

AddAtTail SUBROUTINE
	rts

Remove SUBROUTINE
	rts

	;Create a linked list at $1000
	org $1000
linked_list:
	ds.w 1				;head pointer
	ds.w 1				;tail pointer
	ds.b 1				;number of nodes

data_table:
	dc.b $ae, $11, $33, $1, $00 ; some data

	; reserve space at $2000 for up to 100 nodes
	org $2000
nodes:
	ds.b (node_size * 100), 0
