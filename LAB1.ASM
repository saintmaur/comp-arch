  JMP     100H 
  ORG	100H
  mov	r2,#04h
start:
  mov   a,p0
  mov	r0,a
  anl	a,#018h
  JZ 	decnchk
  cjne 	a,#018h,needxchg
  jmp	decnchk
needxchg:
  ;variant 1:
  ;mov r1,a
  mov a,r0
  ;anl a,#0e7h
  ;mov r0,a
  ;mov a,r1
  ;xrl a,#018h
  ;orl a,r0
  
  ;variant 2:
  cpl acc.3
  cpl acc.4
  mov p1,a
decnchk:
  djnz	r2,start
  JMP   $
;lab1 end
