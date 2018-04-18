;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018

section .data

temp_real: dq 0.0
temp: dq 0.0

extern printf
global cumulative_mul

section .text
cumulative_mul:
	nop
	enter 0, 0		; prepare a frame

	finit			; initialize the x87 subsystem
  init_func:
    fld qword[rdi]
    fst qword[temp_real]

  mul_real:
    fld qword[rsi+8]  ; load [num2_img] into st(0)
    fst st1           ; copy [num2_img] into st(1)
    fld qword[rdi+8]  ; load [num1_img] into st(0)
    fmul              ;st(0)=num1_img*num2_img
    fstp qword [temp]	; store num1_real*num2_real into [temp]

    fld qword [rsi]	; load [num2 real] into st(0)
    fst st1			      ; copy st(0) into st(1)
    fld qword[temp_real] ; load [num1 real] into the st(0)
    fmul			        ; st(0) *= st(1) st(0)=[num1_real]*[num2_real]
    fst st1           ; copy st(0) into st(1)
    fld qword[temp]   ; load num1_real*num2_real into st(0)
    fsub              ;st(0) = num1_real*num2_real-num1_img*num2_img
    fstp qword[rdi]    ;move result back into the struct
  mul_img:
    fld qword [rsi+8]	; load [num2_img] into st(0)
    fst st1			      ; copy st(0) into st(1)
    fld qword[temp_real] ; load [num1 real] into the st(0)
    fmul			        ; st(0) *= st(1)
    fstp qword [temp]	; store num1_real*num2_img into [temp]
    fld qword[rsi]  ; load [num2_real] into st(0)
    fst st1           ; copy [num2_real] into st(1)
    fld qword[rdi+8]  ; load [num1_img] into st(0)
    fmul              ;st(0)=num1_img*num2_img
    fst st1           ; copy st(0) into st(1)
    fld qword[temp]   ; load num1_real*num2_real into st(0)
    fadd              ;st(0) = num1_real*num2_img+num1_img*num2_real
    fstp qword[rdi+8]  ;move result back into the struct

	leave			          ; dump the top frame
	ret			; return from main
