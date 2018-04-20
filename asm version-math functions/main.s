extern printf
extern scanf
extern malloc
extern cumulative_sum
extern cumulative_mul
extern cumulative_sub
extern absolute_value
extern pow_complex
extern div_complex
extern deriv_coeff
extern eval_f
global main

section .bss
epsilon:   		resq 1
order:     		resq 1
idx:			 		resq 1
real:			 		resq 1
imaginary: 		resq 1
initial:   		resq 2
coeff:	   		resq 1
deriv:		 		resq 1
div_result:   resq 2
initial_in_f: resq 2
initial_in_deriv: resq 2

section .data
	get_epsilon_order:
		db "epsilon = %lf",10,"order = %d",0
	get_coeff:
		db 10,"coeff %d = %lf %lf",0
	get_initial:
		db 10,"initial = %lf %lf",0
	print_epsilon_order:
		db "epsilon: %.15e",10, "order: %d", 10, 0
	print_coeff:
		db "coeff %d: %lf %lf", 10, 0
	print_initial:
		db "initial: %lf %lf", 10, 0
	print_result:
			db "result: %lf %lf", 10, 0
section .text
main:
	nop
	enter 0, 0		; prepare a frame
	finit			; initialize the x87 subsystem

	mov rdi, get_epsilon_order	; move the format string into rdi
	mov rsi, epsilon
	mov rdx, order
	mov rax, 0
	call scanf


	mov rax, [order]
	inc rax
  mov rbx, 16
	mul rbx
	mov rdi, rax      ; sizeof coeff = 16*(order+1)
  call malloc
  mov [coeff],rax

	mov r12, [order] ; set loop counter to order+1
	inc r12
	scan_coeff:
		mov rdi, get_coeff
		mov rsi, idx
		mov rdx, real
		mov rcx, imaginary
		mov rax, 0
		call scanf

		mov rax, [idx]
	  mov rbx, 16
		mul rbx
		fld qword [real]
		mov r11,qword[coeff]
		fstp qword [r11+rax]
		fld qword [imaginary]
		fstp qword[r11+rax+8]
		dec r12
		cmp r12, 0
		jnz scan_coeff

	mov rdi, get_initial
	mov rsi, initial
	mov rdx, initial+8
	mov rax, 0
	call scanf



	;  lea rdi, [print_initial]	; print initial
	;  movsd xmm0, [initial]
	;  movsd xmm1, [initial+8]
	; mov rax, 2
	;  call printf


	; mov r12, [order]
	; Lderiv:          ; print deriv
	; mov rax, r12
	; mov rbx, 16
	; mul rbx
	; lea rdi, [print_coeff]
	; mov rsi, r12
	; mov r9, qword[coeff]
	; movsd xmm0, [r9 + rax]
	; movsd xmm1, [r9 + rax+8]
	; mov rax, 2
	; call printf
	; dec r12
	; cmp r12, -1
	; jnz Lderiv

	the_algorithm:
	mov rdi, qword[coeff]
	mov rsi, qword[order]
	call deriv_coeff
	mov [deriv], rax  ; get f'(x)

	mov rdi, qword[coeff]
	mov rsi, qword[order]
	mov rdx, initial
	call eval_f
  mov [initial_in_f], rax  ; get f(initial)

	mov rdi, qword[deriv]
	mov rsi, qword[order]
	mov rdx, initial
	call eval_f
  mov [initial_in_deriv], rax  ; get f'(initial)

	; print_f:
	; mov r9,qword[initial_in_f]
	; lea rdi, [print_result]	; print initial
	; movsd xmm0, qword[r9]
	; movsd xmm1, qword[r9+8]
  ; mov rax, 2
	; call printf



	; mov r12, [order]
	; Linitial_in_f:          ; print initial_in_f
	; mov rax, r12
	; mov rbx, 16
	; mul rbx
	; lea rdi, [print_coeff]
	; mov rsi, r12
	; movsd xmm0, [initial_in_f + rax]
	; movsd xmm1, [initial_in_f + rax+8]
	; mov rax, 2
	; call printf
	; dec r12
	; cmp r12, -1
	; jnz Linitial_in_f


	end_of_program:
	xor rax, rax
	leave		; dump the top frame
	ret			; return from main
