;;; 64bit-fp01.x86-64
;;;
;;; Programmer: guy amit, 2018


%macro mul_cmplex_by_int 3

%endmacro

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
      mov rax,deriv_pointer_pointer
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
        mov r9, qword[r9+8]
        fld qword[r9]
        fst qword[r8]
        fld qword[r9+8]
        fst qword[r8+8]
        mov rax, deriv_pointer_pointer
        jmp end
        xor r8,r8

      order_k:
        mov r8,qword[order]
        mov rax,r8
        mov rbx,8
        mul rbx
        mov r8,rax
        mov rdi, rax
        call malloc
        mov [deriv_pointer_pointer],rax
        mov r12,r8                        ;r12 is the place in the array of coeff
        sub r8,8                          ;r8 is is the lat place in the array of deriv
        loop_start:
            mov r10,qword[coeff_pointer_pointer]      ;get pointer memory block of coeff
            mov r11,qword[deriv_pointer_pointer]      ;get pointer memory block of deriv

            mov rdi,16                                ;allocate new complex_num
            call malloc

            get_pointers:
            mov r11,qword[r11+r8]                     ;get pointer to complex_num
            mov r11,rax                               ;move pointer into direv_array
            mov r10,qword[r10+r12]                    ;get pointer to complex_num in coeff

            fld qword[r10]                            ;st(0)=num_real
            fild qword[order]                                   ;st(0)=power
            fmul                                      ;st(0)=num_real*power
            fst qword[r11]                            ;store in real part of complex_number in deriv

            fld qword[r10+8]                          ;same for img part
            fild qword[order]
            fmul
            fst qword[r11+8]

            sub r12, 8
            sub r8, 8
            mov r9, qword[order]
            dec r9
            mov [order],r9

            cmp r9,0
            je end_loop
            jmp loop_start

            end_loop:
              mov rax,deriv_pointer_pointer
    end:


	leave			          ; dump the top frame
	ret			; return from main
