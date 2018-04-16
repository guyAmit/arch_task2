# flags
CC = gcc
ASM = nasm
ASM_FLAGS = -f elf64


# All Targets
all: test

# link and build program
test: main.o cumulative_sum.o cumulative_mul.o cumulative_sub.o absulut_value.o	pow_complex.o div_complex.o
	@echo 'Building target'
	$(CC) -o test main.o cumulative_sum.o cumulative_mul.o cumulative_sub.o absulut_value.o pow_complex.o div_complex.o

# compile each file
cumulative_sum.o: cumulative_sum.s
	$(ASM) $(ASM_FLAGS)  cumulative_sum.s -o cumulative_sum.o

cumulative_mul.o: cumulative_mul.s
	$(ASM) $(ASM_FLAGS)  cumulative_mul.s -o cumulative_mul.o

cumulative_sub.o: cumulative_sub.s
	$(ASM) $(ASM_FLAGS)  cumulative_sub.s -o cumulative_sub.o

absulut_value.o: absulut_value.s
		$(ASM) $(ASM_FLAGS)  absulut_value.s -o absulut_value.o

pow_complex.o: pow_complex.s
		$(ASM) $(ASM_FLAGS)  pow_complex.s -o pow_complex.o

div_complex.o: div_complex.s
		$(ASM) $(ASM_FLAGS)  div_complex.s -o div_complex.o


main.o: test.c
	$(CC) -c test.c -o main.o -lm
# Clean the build directory
clean:
	rm -f *.o test

# Run program
run:
	./test
