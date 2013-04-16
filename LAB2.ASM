	jmp start  

	org	03h    
	push	psw 
	push	acc
	mov 	psw,#01h 
	cjne	r0,#00h,proceed
	mov	r0,#0ffh
proceed:
	mov 	a,r0
	cpl 	acc.2
	cpl 	acc.5
	mov	r0,a
	mov 	p2,a
	pop 	acc
	pop 	psw
	reti
start:
	org 	100h
	mov     PSW,#00
	mov 	r2,#0ah
	MOV     IE,#8bH
repeat:
	mov	a,p0
	mov	c,acc.7
	jnc	repeat
	call 	subr
	mov	p1,a
	djnz	r2,repeat
	jmp	$

subr:
	mov	r0,a
	anl	a,#018h
	JZ 	decnchk
	cjne 	a,#018h,needxchg
	jmp	decnchk
needxchg:
	mov a,r0
	cpl acc.3
	cpl acc.4
decnchk:
	ret