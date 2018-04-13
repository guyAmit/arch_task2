# flags
CC = gcc
ASM = nasm
ASM_FLAGS = -f elf64


# All Targets
all: task2

# link and build program
task2: bin/main.o
	@echo 'Building targets'
	$(CC) -o bin/task2 bin/main.o -lm
	@echo 'Finished building targets'
	@echo ' '

bin/main.o: main.c
	$(CC) -c main.c -o bin/main.o -lm

# Clean the build directory
clean:
	rm -f bin/*

# Run program
run:
	./bin/task2
