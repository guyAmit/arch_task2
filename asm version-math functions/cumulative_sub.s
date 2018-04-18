;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018

section .data
extern printf
global cumulative_sub

section .text
cumulative_sub:
	nop
	enter 0, 0		; prepare a frame

	finit			; initialize the x87 subsystem
  sub_real:
    fld qword [rdi]	; load [num1 real] into st(0)
    fst st1			; copy st(0) into st(1)
    fld qword[rsi] ; load [num1 real] into the st(0)
    fsub			; st(0) -= st(1)
    fstp qword [rdi]	; store st(0) into [num1 real]
  sub_img:
		fld qword [rdi+8]	; load [num1 real] into st(0)
		fst st1			; copy st(0) into st(1)
		fld qword[rsi+8] ; load [num1 real] into the st(0)
		fsub			; st(0) -= st(1)
		fstp qword [rdi+8]	; store st(0) into [num1 real]
	leave			; dump the top frame
	ret			; return from main
