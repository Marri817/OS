# Makefile for Operating Systems Worksheet 1
# UFCFWK-15-2
# Builds all assembly tasks with C driver

# Compiler and assembler settings
NASM = nasm
CC = gcc
NASM_FLAGS = -f elf
CC_FLAGS = -m32

# Common object files
COMMON_OBJS = asm_io.o driver.o

# All executable targets
TARGETS = task1 task1_2 task2_1 task2_2 task2_3

# Default target - builds all executables
all: $(TARGETS)

# Task 1.1: Basic addition (slide 18)
task1: src/task1.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task1.o asm_io.o -o task1

src/task1.o: src/task1.asm asm_io.inc
	$(NASM) $(NASM_FLAGS) src/task1.asm -o src/task1.o

# Task 1.2: Interactive addition (slide 22)
task1_2: src/task1_2.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task1_2.o asm_io.o -o task1_2

src/task1_2.o: src/task1_2.asm asm_io.inc
	$(NASM) $(NASM_FLAGS) src/task1_2.asm -o src/task1_2.o

# Task 2.1: Name loop with validation
task2_1: src/task2_1.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task2_1.o asm_io.o -o task2_1

src/task2_1.o: src/task2_1.asm asm_io.inc
	$(NASM) $(NASM_FLAGS) src/task2_1.asm -o src/task2_1.o

# Task 2.2: Array sum (1-100)
task2_2: src/task2_2.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task2_2.o asm_io.o -o task2_2

src/task2_2.o: src/task2_2.asm asm_io.inc
	$(NASM) $(NASM_FLAGS) src/task2_2.asm -o src/task2_2.o

# Task 2.3: Range sum with validation
task2_3: src/task2_3.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task2_3.o asm_io.o -o task2_3

src/task2_3.o: src/task2_3.asm asm_io.inc
	$(NASM) $(NASM_FLAGS) src/task2_3.asm -o src/task2_3.o

# Common object files
asm_io.o: asm_io.asm asm_io.inc
	$(NASM) $(NASM_FLAGS) asm_io.asm -o asm_io.o

driver.o: src/driver.c
	$(CC) $(CC_FLAGS) -c src/driver.c -o driver.o

# Clean target - removes all generated files
clean:
	rm -f *.o src/*.o $(TARGETS)

# Phony targets (not actual files)
.PHONY: all clean
