	jmp	100h
	;; timer interrupts
	;; r0 - max value
	;; r1 - current value
	org   	0bH 
	PUSH   	psw
	PUSH  	acc
	MOV  	psw,#08h
init:	
	mov	p3,r1
	mov	a,p3	
	cjne	a,08,goon
	mov	r1,#00h
	jmp	init
	; serial port interrupts
	ORG   	23H    
	PUSH   	psw 
	PUSH  	acc
	MOV  	psw,#10h
	mov	sbuf,tl0
	POP 	acc
	POP 	psw
	RETI

goon:
	inc	p3
	mov	r1,p3
	POP 	acc
	POP 	psw
	RETI
	
start:	; main program
	ORG 	100H
	mov     sp,#50h		; stack pointer set
	MOV     PSW,#00		; bank select (0)
	MOV     r7,#20H  	; cycle counter
	MOV     scon,#50H	; serial port preparation (not considered in current modeller)
        MOV     TH0,#0d0H
        MOV     TL0,#0d0H
	MOV     TMOD,#22H	; prepare timer
	SETB    TR0
	MOV    	ie,#8bH
	mov     08,#03h      	; for use in timer interrupt handler
	mov     09,#001h      	; for use in timer interrupt handler
Repeate:
	NOP              	; idle commands 
	NOP              	; for background work 
	NOP			; imitation
	jmp 	repeate

	DJNZ	r7,repeate
	JMP   	$