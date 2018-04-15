;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018


section .bss
result_pointer:
  resq 1
num1_pointer:
  resq 1
num2_pointer:
  resq 1
num2_mul_add:
  resq 1
num1_dot_product:
  resq 1

section .data

extern printf
extern malloc
extern cumulative_mul

global div_complex

section .text
div_complex:
	nop
	enter 0, 0		; prepare a frame
	finit			; initialize the x87 subsystem
  test1:
  mov [num1_pointer] , rdi
  mov [num2_pointer],rsi

  mov rdi,16
  call malloc
  mov [result_pointer],rax
  de_ref:
    mov r9 , qword[num1_pointer]
    mov r8 , qword[result_pointer]
    mov r10, qword[num2_pointer]
  num1_dot_product_num2:
    fld qword[r9]
    fld qword[r10]
    fmul
    fld qword[r9+8]
    fld qword[r10+8]
    fmul
    fadd
    fst qword[num1_dot_product]
  num2_ops:
    fld qword[r10]
    fld qword[r10]
    fmul
    fld qword[r10+8]
    fld qword[r10+8]
    fmul
    fadd
    fst qword[num2_mul_add]
  insert_real:
    fld qword[num1_dot_product]
    fld qword[num2_mul_add]
    fdiv
    fst qword[r8]
  cross_porudact_num1_num2:
    fld qword[r9+8]
    fld qword[r10]
    fmul
    fld qword[r9]
    fld qword[r10+8]
    fmul
    fsub
  insert_img:
    fld qword[num2_mul_add]
    fdiv
    fst qword[r8+8]
    mov rax, qword[result_pointer]

	leave			; dump the top frame
	ret			; return from main
