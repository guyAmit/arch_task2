;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018



section .bss

coeff_pointer_pointer: resq 1
order: resq 1
result: resq 1
initial_copy:resq 1
temp: resq 1
initial: resq 1

section .data
global eval_f
extern malloc
extern cumulative_mul
extern cumulative_sum
extern free

section .text
eval_f:
	nop
	enter 0, 0		; prepare a frame

	finit			; initialize the x87 subsystem
  init_func:
    mov [coeff_pointer_pointer],rdi
    mov [order], rsi
    mov [initial], rdx

		init_result:
	    mov rdi,16
	    call malloc
	    mov [result],rax
	    fldz
	    fst qword[rax]
	    fst qword[rax+8]

    cmp qword[order],0
    je order_0
    jmp order_k

    order_0:
      jmp end

    order_k:
      mov rdi, 16                               ;create copy of initial
      call malloc
      mov [initial_copy],rax
      mov r13,qword[initial_copy]
      fld1
      fst qword[r13]
      fldz
      fst qword[r13+8]

      mov rdi,qword[result]														; sum first coeff into result
      mov rsi,qword[coeff_pointer_pointer]
      call cumulative_sum

			mov rdi,16																			; allocte temp
			call malloc
			mov [temp],rax

			mov r9,qword[coeff_pointer_pointer]							;set r9 to point to start of array
			mov rcx,qword[order]

			eval_loop:

				mul_initail_with_copy:
				mov rdi,qword[initial_copy]
				mov rsi,qword[initial]
				call cumulative_mul                       			;initial_copy<--initial_copy*initial_copy

				inc_address:																		;init temp with current coeff
					add r9,16
					fld qword[r9]
					mov r10,qword[temp]
					fst qword[r10]
					fld qword[r9+8]
					fst qword[r10+8]

				mul_temp_with_inital_copy:													;temp <--initial_copy *temp
					mov rdi,qword[temp]
					mov rsi,qword[initial_copy]
					call cumulative_mul

				sum_temp_into_result:																;result<--result+temp
					mov rdi,qword[result]
		      mov rsi,qword[temp]
		      call cumulative_sum

				get_ready_for_next_round:
				loop eval_loop

				end:
				mov rdi,qword[initial_copy]
				call free
				mov rdi,qword[temp]
				call free
				mov rax,qword[result]

	leave			          ; dump the top frame
	ret			; return from main
