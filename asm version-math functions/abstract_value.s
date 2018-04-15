section .data
extern printf
global abstract_value

section .text
abstract_value:
	nop
	enter 0, 0		; prepare a frame

	finit			; initialize the x87 subsystem
  L:
    fld qword [rdi]	; load [num real] into st(0)
    fst st1			; copy st(0) into st(1)
    fmul st1    ; st0 <- sqt0*st1 (real^2)
    fst st2    ; copy st(0) into st(2)
    fld qword [rdi+8]	; load [num imaginary] into st(0)
    fst st1			; copy st(0) into st(1)
    fmul st1    ; st0 <- st0*st1 (imaginary^2)
    fadd st2    ; st0 <- st0 + st2 (real^2 + imaginary^2)
    fsqrt       ; sqrt(st0)
    fst qword [rsi]	; store st(0) into [result]
    calc:
    nop
	leave			; dump the top frame
	ret			; return from main
