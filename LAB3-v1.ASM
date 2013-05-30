	jmp	100h
	org   	0bH
	jmp	timer

	ORG   	23H
	PUSH   	psw
	PUSH  	acc
	MOV  	psw,#10h
	mov	sbuf,r0
	mov	a,r0
	cjne	a,#0ffH,goinc
	mov	r0,#00h
	jmp	exit
goinc:
	inc	r0
exit:
	POP 	acc
	POP 	psw
	RETI
goon:
	mov	r1,p3
	POP 	acc
	POP 	psw
	RETI
start:
	ORG 	100H
	mov     sp,#50h
;;; prepare data for sbuf int handling
	mov	psw,#10h
	mov	r0,#00h
;;; prepare data for timer int handling
	mov	psw,#08h
	mov	r0,#80h		;pause duration
	mov	r1,#90h		;impulse duration
	MOV     TH0,#0ffH
        MOV     TL0,r1
;;; main preparations
	MOV     PSW,#00
	MOV     TMOD,#00000100b
	setb	p3.0
	MOV    	ie,#10010010b
	SETB    TR0

repeat:
	mov	a,sbuf
	jnb	acc.0,repeat

timer: 	PUSH   	psw
	PUSH  	acc
	mov	psw,#08h
	CPL 	P3.0
	MOV 	A,#0FFH
	JB 	P3.0,TIME1
	SUBB 	A,R0
	JMP 	TIME2
TIME1:
	SUBB 	A,R1
TIME2:
	MOV 	TH0,#0FFH
	MOV 	TL0,A
	pop	acc
	pop	psw
	reti

serial:	PUSH   	psw
	PUSH  	acc
	mov	psw,#10h
	mov	sbuf,r0
	inc	r0
	pop	acc
	pop	psw
	reti
