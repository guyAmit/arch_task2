extern printf
extern scanf
extern malloc
extern free
extern cumulative_sub
extern absolute_value
extern div_complex
extern deriv_coeff
extern eval_f
global main

section .bss
epsilon:   				resq 1
order:     				resq 1
idx:			 				resq 1
real:			 				resq 1
imaginary: 				resq 1
initial:   				resq 1
coeff:	   				resq 1
deriv:		 				resq 1
div_result:   		resq 1
initial_in_f: 		resq 1
initial_in_deriv: resq 1
abs_value:				resq 1

section .data
	get_epsilon_order:
		db "epsilon = %lf",10,"order = %d",0
	get_coeff:
		db 10,"coeff %d = %lf %lf",0
	get_initial:
		db 10,"initial = %lf %lf",0
	print_root:
		db "root = %.15e %.15e", 10, 0
	minus1: db -1

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
		mov r11,qword [coeff]
		fstp qword [r11+rax]
		fld qword [imaginary]
		fstp qword [r11+rax+8]
		dec r12
		cmp r12, 0
		jnz scan_coeff


	mov rdi, 16
	call malloc
	mov [initial], rax
	mov rdi, get_initial
	mov rsi, real
	mov rdx, imaginary
	mov rax, 0
	call scanf
	mov rax, qword [initial]
	fld qword [real]
	fstp qword [rax]
	fld qword [imaginary]
	fstp qword [rax+8]

	cmp qword [order], 1
	je if_order_1

	mov rdi, qword [coeff]
	mov rsi, qword [order]
	call deriv_coeff
	mov [deriv], rax  ; get f'(x)


	mov rdi, qword [coeff]
	mov rsi, qword [order]
	mov rdx, qword [initial]
	call eval_f
	mov [initial_in_f], rax  ; get f(initial)

	main_loop:

	mov rdi, qword [deriv]
	mov rsi, qword [order]
	dec rsi
	mov rdx, qword [initial]
	call eval_f
  mov [initial_in_deriv], rax  ; get f'(initial)

	mov rdi, qword [initial_in_f]
	mov rsi, qword [initial_in_deriv]
	call div_complex
  mov [div_result], rax  ; div_result =  f(initial) / f'(initial)


	mov rdi, qword [initial]
	mov rsi, qword [div_result]
	call cumulative_sub    ; initial = initial - div_result

	mov rdi,qword[div_result]
	call free
	mov rdi,qword[initial_in_f]
	call free
	mov rdi,qword[initial_in_deriv]
	call free

	mov rdi, qword [coeff]
	mov rsi, qword [order]
	mov rdx, qword [initial]
	call eval_f
	mov [initial_in_f], rax  ; get f(initial) with new initial

	calc_abs_value:
	mov rdi, qword [initial_in_f]
	call absolute_value
	movsd [abs_value], xmm0

	fld qword[epsilon]   ; while(abs(initial_in_f) > epsilon) keep looping
	fld qword[abs_value]
	fcompp
	fstsw ax
	fwait
	sahf
	ja main_loop

	mov r9, qword [initial]
	lea rdi, [print_root]	; print final answer
	movsd xmm0, qword [r9]
	movsd xmm1, qword [r9+8]
  mov rax, 2
	call printf

	mov rdi,qword[initial_in_f]
	call free
	mov rdi,qword[initial]
	call free
	mov rdi,qword[coeff]
	call free
	mov rdi,qword[deriv]
	call free
	jmp end_of_program


	if_order_1:
	nop
		mov rax, [coeff]
		mov r9, qword [initial]
		fldz
		fld qword [rax+16]
		fsub
		fstp qword [r9]

		fldz
		fld qword [rax+24]
		fsub
		fstp qword [r9+8]

		mov r9, [coeff]
		mov rdi, 16
		call malloc
		mov [deriv], rax
		mov rax, qword [deriv]
		fld qword [r9]
		fstp qword [rax]
		fld qword [r9+8]
		fstp qword [rax+8]

		mov rdi, qword [deriv]
		mov rsi, qword [initial]
		call div_complex
	  mov [div_result], rax

		mov r9, qword [div_result]
		lea rdi, [print_root]	; print final answer
		movsd xmm0, qword [r9]
		movsd xmm1, qword [r9+8]
	  mov rax, 2
		call printf

		mov rdi,qword[initial]
		call free
		mov rdi,qword[coeff]
		call free
		mov rdi,qword[deriv]
		call free

	end_of_program:
	xor rax, rax
	leave		; dump the top frame
	ret			; return from main
