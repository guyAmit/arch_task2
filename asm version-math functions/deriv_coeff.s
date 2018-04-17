;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018



section .bss

coeff_pointer_pointer: resq 1
order: resq 1
deriv_pointer_pointer: resq 1

section .data
global deriv_coeff
extern malloc

section .text
deriv_coeff:
	nop
	enter 0, 0		; prepare a frame

	finit			; initialize the x87 subsystem
  init_func:
    mov [coeff_pointer_pointer],rdi
    mov [order], rsi
    cmp qword[order],0
    je order_0
    jg greter_than_or_equal_order_1

    order_0:
      mov rdi,16
      call malloc
      mov [deriv_pointer_pointer],rax
      mov r8, qword[deriv_pointer_pointer]
      fldz
      fst qword[r8]
      fst qword[r8+8]
      xor r8,r8
      mov rax,qword[deriv_pointer_pointer]
      jmp end

    greter_than_or_equal_order_1:
      cmp qword[order], 1
      je order_1
      jge order_k

      order_1:
        mov rdi,16
        call malloc
        mov [deriv_pointer_pointer],rax
        mov r8, qword[deriv_pointer_pointer]
        mov r9, qword[coeff_pointer_pointer]
        fld qword[r9+16]
        fst qword[r8]
        fld qword[r9+24]
        fst qword[r8+8]
        mov rax, qword[deriv_pointer_pointer]
				xor r8,r8
        jmp end

      order_k:
        mov r8,qword[order]
        mov rax,r8
        mov rbx,16
        mul rbx
        mov r8,rax
        mov rdi, rax
        call malloc
        mov [deriv_pointer_pointer],rax
				mov r10, r8													;offset coeff array
				sub r8, 16													;offset deriv array
				mov r11,qword[coeff_pointer_pointer]
				mov r9, qword[deriv_pointer_pointer]
				loop_start:

						fld qword[r11+r10]
						fild qword[order]
						fmul
						fst qword[r9+r8]

						fld qword[r11+r10+8]
						fild qword[order]
						fmul
						fst qword[r9+r8+8]

						sub r8,16
						sub r10,16
						mov r12,qword[order]
						dec r12
						mov [order], r12

						cmp r12,0
						je end_loop
						jmp loop_start

						end_loop:
						mov rax,qword[deriv_pointer_pointer]
						jmp end
    end:


	leave			          ; dump the top frame
	ret			; return from main
