# flags
CC = gcc
ASM = nasm
ASM_FLAGS = -f elf64


# All Targets
all: task0

# link and build program
<<<<<<< 0aa35faafb2ca6d4a84a2c57f46b5a50fb51086e
task0: main.o cumulative_sum.o cumulative_mul.o cumulative_sub.o absolute_value.o	pow_complex.o div_complex.o deriv_coeff.o eval_f.o
	@echo 'Building target'
	$(CC) -o task0 main.o cumulative_sum.o cumulative_mul.o cumulative_sub.o absolute_value.o pow_complex.o div_complex.o deriv_coeff.o eval_f.o
	@echo 'Done'
=======
test: main.o cumulative_sum.o cumulative_mul.o cumulative_sub.o absulut_value.o	pow_complex.o div_complex.o deriv_coeff.o eval_f.o
	@echo 'Building target'
	$(CC) -o test main.o cumulative_sum.o cumulative_mul.o cumulative_sub.o absulut_value.o pow_complex.o div_complex.o deriv_coeff.o eval_f.o

>>>>>>> changes in all asm files
# compile each file
cumulative_sum.o: cumulative_sum.s
	$(ASM) $(ASM_FLAGS)  cumulative_sum.s -o cumulative_sum.o

cumulative_mul.o: cumulative_mul.s
	$(ASM) $(ASM_FLAGS)  cumulative_mul.s -o cumulative_mul.o

cumulative_sub.o: cumulative_sub.s
	$(ASM) $(ASM_FLAGS)  cumulative_sub.s -o cumulative_sub.o

absolute_value.o: absolute_value.s
		$(ASM) $(ASM_FLAGS)  absolute_value.s -o absolute_value.o

pow_complex.o: pow_complex.s
		$(ASM) $(ASM_FLAGS)  pow_complex.s -o pow_complex.o

div_complex.o: div_complex.s
		$(ASM) $(ASM_FLAGS)  div_complex.s -o div_complex.o

deriv_coeff.o: deriv_coeff.s
		$(ASM) $(ASM_FLAGS)  deriv_coeff.s -o deriv_coeff.o

eval_f.o: eval_f.s
		$(ASM) $(ASM_FLAGS)  eval_f.s -o eval_f.o
<<<<<<< 0aa35faafb2ca6d4a84a2c57f46b5a50fb51086e

main.o: main.s
	$(ASM) $(ASM_FLAGS) main.s -o main.o
=======
>>>>>>> changes in all asm files

# Clean the build directory
clean:
	rm -f *.o task0

# Run program
run:
	./task0
