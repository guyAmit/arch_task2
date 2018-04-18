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
epsilon:   resq 1
order:     resq 1
idx:			 resq 1
real:			 resq 1
imaginary: resq 1
initial:   resq 2
coeff:	   resq 1
deriv:		 resq 1

section .data
	get_epsilon_order:
		db "epsilon = %lf",10,"order = %d\n",0
	get_coeff:
		db 10,"coeff %d = %lf %lf\n",0
	get_initial:
		db 10,"initial = %lf %lf\n",0
	print_epsilon_order:
		db "epsilon: %.15e",10, "order: %d", 10, 0
	print_coeff:
		db "coeff %d: %lf %lf", 10, 0
	print_initial:
		db "initial: %lf %lf", 10, 0

section .text
main:
	nop
	enter 0, 0		; prepare a frame
	finit			; initialize the x87 subsystem

	lea rdi, [get_epsilon_order]	; move the format string into rdi
	lea rsi, [epsilon]
	lea rdx, [order]
	mov rax, 2
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
		lea rdi, [get_coeff]
		lea rsi, [idx]
		lea rdx, [real]
		lea rcx, [imaginary]
		mov rax, 2
		call scanf

		mov rax, [idx]
	  mov rbx, 16
		mul rbx
		fld qword [imaginary]
		fld qword [real]
		fstp qword [coeff + rax]
		add rax, 8
		fstp qword [coeff + rax]
		dec r12
		cmp r12, 0
		jnz scan_coeff

	lea rdi, [get_initial]
	lea rsi, [initial]
	lea rdx, [initial+8]
	mov rax, 2
	call scanf

	; print_input:
	; nop
	; lea rdi, [print_epsilon_order]	; print epsilon and order
	; movsd xmm0, [epsilon]
	; lea rsi, [order]
	; mov rsi, [rsi]
	; mov rax, 2
	; call printf
	;
	; mov r12, [order]
	; Lcoeff:          ; print coeff
	; mov rax, r12
	; mov rbx, 16
	; mul rbx
	;
	; lea rdi, [print_coeff]
	; mov rsi, r12
	; movsd xmm0, [coeff + rax]
	; movsd xmm1, [coeff + rax+8]
	; mov rax, 2
	; call printf
	; dec r12
	; cmp r12, -1
	; jnz Lcoeff
	;
	; lea rdi, [print_initial]	; print initial
	; movsd xmm0, [initial]
	; movsd xmm1, [initial+8]
	; mov rax, 2
	; call printf

	the_algorithm:

	lea rdi, [coeff]
	lea rsi, [order]
	call deriv_coeff
	mov rax, [deriv]  ; get the derived polynom

	L:
	mov r12, [order]
	Lcoeff:          ; print coeff
	mov rax, r12
	mov rbx, 16
	mul rbx

	lea rdi, [print_coeff]
	mov rsi, r12
	movsd xmm0, [coeff + rax]
	movsd xmm1, [coeff + rax+8]
	mov rax, 2
	call printf
	dec r12
	cmp r12, -1
	jnz Lcoeff




	end_of_program:
	xor rax, rax
	leave		; dump the top frame
	ret			; return from main
