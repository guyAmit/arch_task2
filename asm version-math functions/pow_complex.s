;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018


section .bss
power:
  resq 1
result_pointer:
  resq 1
num_pointer:
  resq 1

section .data
extern malloc
extern cumulative_mul

global pow_complex

section .text
pow_complex:
	nop
	enter 0, 0		; prepare a frame
	finit			; initialize the x87 subsystem
  test1:
  mov [num_pointer] , rdi
  mov [power],rsi
  mov rdi,16
  call malloc
  mov [result_pointer],rax
  copy:
    mov r9 , qword[num_pointer]
    mov r8 , qword[result_pointer]
    fld qword[r9]
    fst qword [r8]
    fld qword[r9+8]
    fst qword[r8+8]
    mov rcx,[power]
    dec rcx
  loop_s:
    mov rdi,r8
    mov rsi,r9
    call cumulative_mul
    loop loop_s

  mov rax, [result_pointer]
	leave			; dump the top frame
	ret			; return from main
