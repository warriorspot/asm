	processor 6803
	org $5000

; This is a relatively straightforward example of using the timer overflow
; interrupt to implement a simple round-robin thread scheduler, with
; one main thread, and two secondary threads.  The main thread is the
; the normal BASIC operation, which gets many more timeslices than the secondary
; threads.  This is adjustable via the main_thread_priority value.  The
; threads each get 64 bytes of local stack space.  The main thread does not
; use this space, since it uses the normal system stack space.
;
; The thread context and bookkeeping info is stored in a structure like so:
;struct thread {
;	char thread_num 0
;	short PC        1
;	short X 		3
;	char A 			5
;	char B 			6
;	char CC 		7
;   char stack[64]  8
;}
;
; This code could probably be much faster or smaller...
;
main_thread_priority equ 8	;the higher the number, the greater the priority
thread_size equ 74 ;10 bytes for bookkeeping, 64 bytes of stack space 
max_threads equ 4 ;Space is allocated for 4 threads

	INCLUDE "MC10.asm"
	
	ldaa #$03				;Number of threads being used including main thread
	staa thread_count		;Store this value
	ldaa #main_thread_priority	;Load and store the main thread priority
	staa main_thread_ctr
	
	;Thread 0 is the "main" thread (BASIC + keyboard polling)
	;It doesn't use any local stack space
	ldx #threads		;Load address of stack structure array
	ldaa #$00
	staa 0,x			;store thread number
	ldd #WARMSTART		;initial PC value
	std 1,x				;store that
	bsr .init_regs
	sts 8,x
	
	ldx #threads + (1 * thread_size) ;Point to next thread struct
	ldaa #$01			;thread #1
	staa 0,x			;store thread number
	ldd #THREAD1		;Entry PC of THREAD1
	std 1,x				;store it
	bsr .init_regs		;init regs
	stx r0				;Store X in r0 (see MC10.asm)
	ldd r0				;So I can pull it back into D
	addd #thread_size - 1 ;And calculate the initial local stack pointer value
	std 8,x				;And store that in our struct
	
	; Repeat steps from thread 1 for thread 2
	ldx #threads + (2 * thread_size)
	ldaa #$02			
	staa 0,x			
	ldd #THREAD2		
	std 1,x				
	bsr .init_regs		
	stx r0
	ldd r0
	addd #thread_size - 1
	std 8,x
	
	jmp .init_interrupt	;initialize the interrupt handler
	
.init_regs
	clra				;A = 0
	clrb 				;B = 0 (D = 0)
	std  3,x			;store X
	staa 5,x			;store A
	staa 6,x			;store B
	staa 7,x			;store CC
	rts

; a simple interrupt driven routine
; tied to the 6803 timer output compare
.init_interrupt
	sei				;disable interrupts
	ldaa #$7e		;load jmp opcode
	staa OCFVEC		;store it in the low byte of the vector
	ldx #ENTRY		;load the address of the handler
	stx OCFVEC+1	;store it in the next 2 bytes
	ldx #$1000
	stx TOCR
	ldaa TCSR		;load the timer status
	oraa #$08		;turn on overflow interrupt bit
	staa TCSR		;save the timer status
	cli				;enable interupts
	jmp WARMSTART   ;warm start BASIC and off we go
	
; Thread 1 entry point.
; Write characters to first byte of screen RAM,
; then wait awhile
THREAD1 SUBROUTINE
	ldx #screen
.loop
	staa 0,x
	inca
	jsr WAIT
	jmp .loop

; Thread 2 entry point.	
; Write characters to the top right corner of the
; screen as fast as possible.
THREAD2 SUBROUTINE
	ldx #screen
.loop
	staa 31,x
	inca
	jmp .loop
	
; Waste a bunch of time.
WAIT SUBROUTINE
	pshx
	ldx #$2000
.loop
	dex
	cpx #$00
	bne .loop
	pulx
	rts

;This is the thread scheduler.  In order to give the
; main thread enough time to run to be useful, I give
; it more priority by skipping "main_thread_counter" interrupts
; while thread 0 is running.  In other words, thread 0 stays the active
; thread through "main_thread_counter" timer overflow interrupts.
;	
;When the interrupt occurs, the current threads
;states is on the stack in the following ascending order:
;CC -> B -> A -> X -> PC.  The state of the current thread is
;pulled from the stack and stored in the threads array.  The 
; state of the next thread to run is pushed onto the thread local
; stack, and rti is called.
ENTRY SUBROUTINE
	ldaa current_thread_index	;get the current thread index
	bne .switch_thread			;if not main thread, switch threads
	dec main_thread_ctr			;main_thread_ctr--
	ldab main_thread_ctr		;grab it
	beq .reset_main_thread		;if == 0, reset counter and allow thread switch.
	jmp .exit					;if > 0 then exit the interrupt handler with no switch.
.reset_main_thread
	ldab #main_thread_priority	;load and store main_thread_ctr
	stab main_thread_ctr
.switch_thread
	ldx #threads				;start of thread storage
	ldab #thread_size			;calculate offset
	mul							;A * B -> D
	abx							;and add it to X
	pula						;CC
	staa 7,x			
	pula						;B
	staa 6,x
	pula 						;A
	staa 5,x
	pula						;> X
	pulb						;< X
	std 3,x
	pula						;> PC
	pulb						;< PC
	std 1,x
	sts 8,x						;SP
	
	; get next thread
	ldaa current_thread_index	;get current thread index
	inca						;increment it
	cmpa thread_count			;compare to thread_count
	blo .next_thread			;if < thread_count, continue
	clra 						;otherwise, set back to 0
.next_thread				
	staa current_thread_index	;and store it
	ldx #threads				;pointer to thread structs
	ldab #thread_size			;calculate offset for new index
	mul							;A * B = D
	abx							;X points to thread struct
	lds 8,x						;SP
	ldd 1,x						;PC
	pshb
	psha
	ldd 3,x						;X
	pshb
	psha
	ldaa 5,x					;A
	psha
	ldaa 6,x					;B
	psha 
	ldaa 7,x					;CC
	psha
	
.exit
	ldaa TCSR		;clear the output compare flag
	ldd #$3000 		;by reading the TCSR, then writing to TOCR
	std TOCR
	ldd #$00
	std TIMER  		;reset the timer
	rti
	
;counter for main thread to get more time slices than
;the other two threads
main_thread_ctr: ds.b 1
;number of threads, including main
thread_count: ds.b 1
;index into the thread table of the current thread
current_thread_index: ds.b 1
; stack data array
threads: ds.b thread_size * max_threads
 

	
