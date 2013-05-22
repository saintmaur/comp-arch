        jmp	100H
	org	100H		;
	    ;; data in program memory
	db	0f8H
	mov	dptr,#0100H
	mov	psw,#00H	;
        mov	r0,#00H
        mov	r1,#020H
	mov	r2,#078H	;; constant to compare with
	mov	r3,#0aH		;; counter for RAM reading
        ;;         mov	r4,#030H
        mov 	010h,#030h ;; address pointer for write operation start
        mov 	r5,#0ah       ;counter for internal data fill
	movc   	a,@a+DPTR
	call	chknwr

        ;;init internal data

init:
        mov a,r1
        mov b,a
        mul ab
        mov @r1,a
        inc r1
        djnz    r5,init
        mov	r1,#020H
ramreadrepeat:
        ;; ram
	mov	a,@r1
	call	chknwr
	inc	r1
        ;; xram
        movx	a,@r0
	call 	chknwr
	inc	r0
	djnz	r3,ramreadrepeat

        jmp exit
	    ;; check and write procedure
chknwr:
	cjne	a,02,goon
	jmp	goodbuy
goon:
	jnc	write
	jmp	goodbuy
write:
        push    psw
        push    acc
        mov 	psw,#10H
	mov	@r0,a
	inc	r0
        pop 	acc
        pop 	psw
goodbuy:
	ret
exit:
	jmp	$

