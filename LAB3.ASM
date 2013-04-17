	maska 	equ 0aah
	max	equ 0a0ah
        ORG     00
        JMP     100H
; timer interrupt
	ORG   	0bH 
	JMP    	50h
	Org     50h    
	PUSH   	psw
	PUSH  	acc
	MOV  	psw,#08h
	mov		
	POP 	acc
	POP 	psw
	RETI
; serial port interrupts
	ORG   	23H    
	PUSH   	psw 
	PUSH  	acc
	MOV  	psw,# 10h
	;TODO
	POP 	acc
	POP 	psw
	RETI

; main program
	ORG 	100H
	mov     sp,#50h
	MOV     PSW,#00          
	MOV     r7,#20H  
	MOV     scon,#50H	
        MOV     TH1,#0d0H
        MOV     TL1,#0d0H
	MOV     TMOD,#02H
	SETB    TR1
	MOV    	ie,#8bH
	mov     08,#maska
	mov	08,#maska
Repeate:
	NOP              
	NOP              
	NOP
	jmp repeate
	
	MOV	p3,a
	DJNZ	r7,repeate
	JMP   	$