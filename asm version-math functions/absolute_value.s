;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018

section .data
temp:
  dq 0.0

extern printf
global absolute_value

section .text
absolute_value:
	nop
	enter 0, 0		; prepare a frame
	finit			; initialize the x87 subsystem
  fld qword [rdi]   ;get real part of number
  fst st1           ;copy real part to st(1)
  fmul              ;st(0)=real^2
  fst qword [temp]  ;store real^2 into temp
  fld qword [rdi+8] ;get img part of number
  fst st1           ;copy img part of number into st(1)
  fmul              ; st(0) = img^2
  fld qword [temp]  ;st(1)=img^2 st(0)=real^2
  fadd              ;st(0)=img^2 + real^2
  fsqrt             ;st(0)=absolute_value as requierd
  fst qword[temp]   ;move result into [temp]
  push qword[temp]  ;move result to stack
  movsd xmm0, qword[rbp-8*1] ;get result from the stack, xmm0 is the returned value
	leave			; dump the top frame
	ret			; return from main
