	jmp	100H
	org	100H		;
	db	0f8H
	mov	dptr,#0100H
	mov	psw,#00H	;
	mov	r0,#00H
	mov	r2,#078H	;; constant to compare with
	mov	r3,#0aH		;; counter for RAM reading
	mov	r4,#0aH		;; counter for XRAM reading
	mov	r7,#0bH		;; XRAM address pointer for write operations
	movc   	a,@a+DPTR
	call	chknwr
ramreadrepeat:
	mov	a,@r1
	call	chknwr
	inc	r1
	djnz	r3,ramreadrepeat
xramreadrepeat:
	mov	a,@r0
	call	chknwr
	inc	r0
	djnz	r4,xramreadrepeat

	;; check and write procedure
chknwr:
	cjne	a,02,goon
	jmp	goodbuy
goon:
	jnz	write
	jmp	goodbuy
write:
	;; 	movx	@r7,a
	inc	r7
goodbuy:
	reti
exit:
	jmp	$

