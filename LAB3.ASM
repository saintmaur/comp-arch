	jmp	100h
	;; timer interrupts
	;; r0 - max value
	;; r1 - current value
	org   	0bH
	PUSH   	psw
	PUSH  	acc
	MOV  	psw,#08h
	jmp	init
	;; serial port interrupts
	ORG   	23H
	PUSH   	psw
	PUSH  	acc
	clr	ri
	mov	sbuf,tl0
	POP 	acc
	POP 	psw
	RETI

init:
	mov	p3,r1
	mov	a,p3
	cjne	a,08,goon
	mov	r1,#00h
	jmp	init
goon:
	inc	p3
	mov	r1,p3
	POP 	acc
	POP 	psw
	RETI

start:	; main program
	ORG 	100H
	mov     sp,#50h   ; stack location
	MOV     PSW,#00		; bank select (0)
	MOV     scon,#50H	; serial port preparation (not considered in current emulator)
        MOV     TH0,#0d0H
        MOV     TL0,#0d0H
	MOV     TMOD,#22H	; prepare timer
	SETB    TR0
	MOV    	ie,#10010010b
	mov     08,#03h      	; for use in timer interrupt handler
	mov     09,#00h      	; for use in timer interrupt handler
Repeate:
	nop
	nop
	nop
	nop
	nop
	jmp 	repeate