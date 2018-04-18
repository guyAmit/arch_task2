;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018

section .data
extern printf
global cumulative_sum

section .text
cumulative_sum:
	nop
	enter 0, 0		; prepare a frame

	finit			; initialize the x87 subsystem
  sum_real:
    fld qword [rsi]	; load [num2 real] into st(0)
    fst st1			; copy st(0) into st(1)
    fld qword[rdi] ; load [num1 real] into the st(0)
    fadd			; st(0) += st(1)
    fstp qword [rdi]	; store st(0) into [num1 real]
  sum_img:
    fld qword[rsi+8] ; load [num2 img] into st(0)
    fst st1             ; copy [num2_img] into st(1)
    fld qword[rdi+8] ; load [num1_img] into st(0)
    fadd                ; st(0)+=st(1)
    fstp qword[rdi+8] ; store st(0) into [num1_img]
	leave			; dump the top frame
	ret			; return from main
