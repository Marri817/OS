# UFCFWK-15-2 Operating Systems - Worksheet 1
## An Echo of Assembler

**Student:** ALI ALMARRI
**Date:** December 4, 2025  
**GitHub Repository:** https://github.com/Marri817/OS

---

## Overview

This worksheet explores x86 assembly programming fundamentals, covering:
- Basic assembly syntax and structure
- Calling C functions from assembly
- Implementing loops and conditionals
- Array manipulation and summation
- Building with Make

All programs are written in NASM (Netwide Assembler) syntax targeting 32-bit x86 architecture.

---

## Project Structure

```
worksheet_1/
├── README.md           # This documentation
├── Makefile           # Build automation
├── asm_io.asm         # Assembly I/O library
├── asm_io.inc         # I/O function declarations and macros
└── src/
    ├── driver.c       # C driver program
    ├── task1.asm      # Task 1: Basic addition (slide 18)
    ├── task1_2.asm    # Task 1: Interactive program (slide 22)
    ├── task2_1.asm    # Task 2: Name loop with validation
    ├── task2_2.asm    # Task 2: Array sum (1-100)
    └── task2_3.asm    # Task 2: Range sum
```

---

## Building and Running

### Prerequisites
- WSL (Windows Subsystem for Linux) or Linux environment
- NASM assembler: `sudo apt-get install nasm`
- GCC compiler with 32-bit support: `sudo apt-get install gcc-multilib`

### Build All Programs
```bash
make all
```

### Build Individual Programs
```bash
make task1      # Build Task 1 - Basic addition
make task1_2    # Build Task 1 - Interactive addition
make task2_1    # Build Task 2.1 - Name loop
make task2_2    # Build Task 2.2 - Array sum
make task2_3    # Build Task 2.3 - Range sum
```

### Clean Build Artifacts
```bash
make clean
```

### Run Programs
```bash
./task1
./task1_2
./task2_1
./task2_2
./task2_3
```

---

## Task 1: Basic Assembly Programming (20%)

### Task 1.1: Simple Addition (Slide 18)

**Objective:** Implement an assembly program with `asm_main` function that adds two integers stored in global memory and prints the result.

**File:** `task1.asm`

**Implementation:**

```nasm
%include "asm_io.inc"

segment .data
    num1    dd  10      ; First number
    num2    dd  25      ; Second number

segment .text
    global asm_main

asm_main:
    enter   0,0         ; Setup stack frame
    pusha               ; Save all registers

    mov     eax, [num1] ; Load first number into EAX
    add     eax, [num2] ; Add second number to EAX
    
    call    print_int   ; Print result
    call    print_nl    ; Newline

    popa                ; Restore registers
    mov     eax, 0      ; Return 0
    leave
    ret
```

**How It Works:**
1. **Data Section:** Defines two 32-bit integers (`dd` = doubleword)
2. **Stack Frame:** `enter 0,0` sets up the stack frame for the function
3. **Register Preservation:** `pusha` saves all general-purpose registers
4. **Arithmetic:** Loads first number into EAX, adds second number
5. **Output:** Calls `print_int` from asm_io library to display result
6. **Cleanup:** Restores registers, returns 0 to c
---

### Task 1.2: Interactive Addition (Slide 22)

**Objective:** Create a program that prompts for two numbers, reads user input, and displays both inputs and their sum.

**File:** `task1_2.asm`

**Implementation:**

```nasm
%include "asm_io.inc"

segment .data
    prompt1 db "Enter a number: ", 0
    prompt2 db "Enter another number: ", 0
    outmsg1 db "You entered ", 0
    outmsg2 db " and ", 0
    outmsg3 db ", the sum is ", 0

segment .text
    global asm_main

asm_main:
    enter   0,0
    pusha

    ; Get first number
    mov     eax, prompt1
    call    print_string
    call    read_int
    mov     ebx, eax        ; Store in EBX

    ; Get second number
    mov     eax, prompt2
    call    print_string
    call    read_int
    mov     ecx, eax        ; Store in ECX

    ; Display results
    mov     eax, outmsg1
    call    print_string
    mov     eax, ebx
    call    print_int
    
    mov     eax, outmsg2
    call    print_string
    mov     eax, ecx
    call    print_int
    
    mov     eax, outmsg3
    call    print_string
    
    ; Calculate and print sum
    mov     eax, ebx
    add     eax, ecx
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret
```

**How It Works:**
1. **String Prompts:** Uses null-terminated strings for user prompts
2. **Input:** `read_int` function reads integers from stdin
3. **Register Usage:** EBX stores first number, ECX stores second
4. **Formatted Output:** Prints descriptive message with both inputs and sum


## Task 2: Loops and Conditionals (20%)

### Task 2.1: Name Loop with Validation

**Objective:** Ask user for their name and a number (50-100), then print a welcome message that many times.

**File:** `task2_1.asm`

**Implementation Highlights:**

```nasm
; Validation logic
    cmp     ebx, 50         ; Compare with lower bound
    jl      print_error     ; Jump if less than
    
    cmp     ebx, 100        ; Compare with upper bound
    jg      print_error     ; Jump if greater than

; Loop implementation
print_loop:
    mov     eax, welcome_msg
    call    print_string
    mov     eax, name
    call    print_string
    mov     eax, exclamation
    call    print_string
    call    print_nl
    
    dec     ecx             ; Decrement counter
    jnz     print_loop      ; Jump if not zero
```

**Key Concepts:**
- **Conditional Jumps:** `jl` (jump if less), `jg` (jump if greater)
- **Loop Counter:** Uses ECX register, decrements with `dec`
- **String Input:** Reads characters until newline, null-terminates
- **Validation:** Checks bounds before executing loop


### Task 2.2: Array Sum (1-100)

**Objective:** Define array of 100 elements, initialize to numbers 1-100, sum the array, and output result.

**File:** `task2_2.asm`

**Implementation:**

```nasm
segment .bss
    array   resd 100        ; Reserve 100 doublewords

segment .text
    global asm_main

asm_main:
    enter   0,0
    pusha

    ; Initialize array with values 1-100
    mov     ecx, 100        ; Counter
    mov     edi, array      ; EDI points to array
    mov     eax, 1          ; Starting value

init_loop:
    mov     [edi], eax      ; Store value in array
    add     edi, 4          ; Move to next element (4 bytes)
    inc     eax             ; Increment value
    loop    init_loop       ; Decrements ECX and jumps if not zero

    ; Sum the array
    mov     ecx, 100        ; Counter
    mov     edi, array      ; Reset pointer
    xor     eax, eax        ; Clear EAX (sum = 0)

sum_loop:
    add     eax, [edi]      ; Add current element to sum
    add     edi, 4          ; Move to next element
    loop    sum_loop

    ; Print result
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret
```

**How It Works:**
1. **Array Declaration:** `resd 100` reserves 100 doublewords (4 bytes each)
2. **Initialization Loop:** 
   - EDI points to current array position
   - Stores values 1-100 sequentially
   - Increments pointer by 4 bytes per iteration
3. **Summation Loop:**
   - XOR clears EAX to 0 (efficient way to zero a register)
   - Accumulates each array element into EAX
   - Loop instruction decrements ECX and jumps if not zero
4. **Result:** Sum of 1+2+...+100 = 5050

### Task 2.3: Range Sum

**Objective:** Extend task2_2 to ask user for a range (start and end), validate it, and sum that range.

**File:** `task2_3.asm`

**Implementation Highlights:**

```nasm
; Get range from user
    call    read_int
    mov     ebx, eax        ; Start index (EBX)
    
    call    read_int
    mov     edx, eax        ; End index (EDX)

; Validation
    cmp     ebx, 1          ; Check start >= 1
    jl      error
    cmp     edx, 100        ; Check end <= 100
    jg      error
    cmp     ebx, edx        ; Check start <= end
    jg      error

; Calculate sum of range
    mov     ecx, edx
    sub     ecx, ebx
    inc     ecx             ; Count = end - start + 1
    
    mov     edi, array
    dec     ebx
    shl     ebx, 2          ; Multiply start by 4 (byte offset)
    add     edi, ebx        ; Point to start of range

sum_loop:
    add     eax, [edi]
    add     edi, 4
    loop    sum_loop
```

**Key Concepts:**
- **Range Validation:** Ensures 1 ≤ start ≤ end ≤ 100
- **Pointer Arithmetic:** Calculates byte offset using shift left (×4)
- **Partial Sum:** Only sums elements in specified range
- **Error Handling:** Displays error message for invalid input


## Task 3: Makefile (20%)

**Objective:** Create a Makefile to automate the build process for all programs.

**File:** `Makefile`

**Implementation:**

```makefile
# Makefile for Operating Systems Worksheet 1

# Tools
NASM = nasm
CC = gcc
NASM_FLAGS = -f elf
CC_FLAGS = -m32

# Common object files
COMMON_OBJS = asm_io.o driver.o

# All targets
TARGETS = task1 task1_2 task2_1 task2_2 task2_3

# Default target
all: $(TARGETS)

# Task 1 targets
task1: src/task1.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task1.o asm_io.o -o task1

src/task1.o: src/task1.asm
	$(NASM) $(NASM_FLAGS) src/task1.asm -o src/task1.o

task1_2: src/task1_2.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task1_2.o asm_io.o -o task1_2

src/task1_2.o: src/task1_2.asm
	$(NASM) $(NASM_FLAGS) src/task1_2.asm -o src/task1_2.o

# Task 2 targets
task2_1: src/task2_1.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task2_1.o asm_io.o -o task2_1

src/task2_1.o: src/task2_1.asm
	$(NASM) $(NASM_FLAGS) src/task2_1.asm -o src/task2_1.o

task2_2: src/task2_2.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task2_2.o asm_io.o -o task2_2

src/task2_2.o: src/task2_2.asm
	$(NASM) $(NASM_FLAGS) src/task2_2.asm -o src/task2_2.o

task2_3: src/task2_3.o $(COMMON_OBJS)
	$(CC) $(CC_FLAGS) driver.o src/task2_3.o asm_io.o -o task2_3

src/task2_3.o: src/task2_3.asm
	$(NASM) $(NASM_FLAGS) src/task2_3.asm -o src/task2_3.o

# Common object files
asm_io.o: asm_io.asm asm_io.inc
	$(NASM) $(NASM_FLAGS) asm_io.asm -o asm_io.o

driver.o: src/driver.c
	$(CC) $(CC_FLAGS) -c src/driver.c -o driver.o

# Clean target
clean:
	rm -f *.o src/*.o $(TARGETS)

.PHONY: all clean
```

**How It Works:**

1. **Variables:**
   - `NASM = nasm`: Assembler command
   - `CC = gcc`: C compiler
   - `NASM_FLAGS = -f elf`: Generate ELF object format
   - `CC_FLAGS = -m32`: Compile for 32-bit architecture

2. **Rules Structure:**
   - **Target:** The file to be created (e.g., `task1`)
   - **Prerequisites:** Files needed to build target (e.g., `task1.o`, `driver.o`)
   - **Recipe:** Commands to execute (indented with tab)

3. **Common Objects:**
   - `asm_io.o`: I/O library used by all programs
   - `driver.o`: C main function that calls `asm_main`

4. **Pattern:**
   - Each task has two rules: one to assemble .asm → .o, one to link .o → executable
   - Linking combines task-specific object with common objects

5. **Phony Targets:**
   - `all`: Builds all executables (default target)
   - `clean`: Removes all generated files

**Usage:**

```bash
# Build everything
make all

# Build specific task
make task1

# Rebuild after changes
make clean
make all

# Just remove binaries
make clean
```

**Benefits:**
- **Automation:** Build all programs with single command
- **Dependency Tracking:** Only rebuilds changed files
- **Maintainability:** Easy to add new tasks
- **Consistency:** Same build process for all developers

---

## Task 4:

### Understanding Gained

Through this worksheet, I developed understanding of:

#### 1. Assembly Language Fundamentals
- **Registers:** General purpose (EAX, EBX, ECX, EDX), index (ESI, EDI), stack (ESP, EBP)
- **Addressing Modes:** Direct `[num1]`, indirect `[edi]`, immediate `mov eax, 10`
- **Segments:** `.data` (initialized), `.bss` (uninitialized), `.text` (code)

#### 2. Function Call Convention
- **Stack Frame:** `enter`/`leave` manage base pointer
- **Register Preservation:** `pusha`/`popa` save/restore all registers
- **Return Value:** EAX contains return value to C

#### 3. Control Flow
- **Jumps:** Unconditional `jmp`, conditional `jl`, `jg`, `je`, `jnz`
- **Loops:** `loop` instruction (decrements ECX), manual `dec`/`jnz` pattern
- **Comparisons:** `cmp` sets flags, subsequent jump uses flags

#### 4. Memory Management
- **Array Access:** Pointer arithmetic with 4-byte offsets
- **String Handling:** Null-terminated strings, character-by-character reading
- **Data Types:** `db` (byte), `dd` (doubleword), `resd` (reserve doublewords)

#### 5. Build Process
- **Assembly:** NASM converts .asm → .o (object file)
- **Compilation:** GCC converts .c → .o
- **Linking:** GCC combines objects → executable
- **Automation:** Make manages dependencies and build steps

### Challenges Encountered

1. **Register Management:** Initially confused about which registers to use; learned EAX is primary accumulator, ECX for loops
2. **String Termination:** Forgot null terminators, causing print_string to read past buffer
3. **Pointer Arithmetic:** Off-by-one errors when calculating array offsets (forgot to multiply by 4)
4. **Makefile Tabs:** Accidentally used spaces instead of tabs in recipes, causing make errors

### Key Takeaways

- Assembly provides low-level control but requires careful register and memory management
- Understanding calling conventions is crucial for interfacing with C
- Make significantly improves build process efficiency and maintainability
- Debugging assembly requires systematic approach: check registers, memory, and control flow
---

## References

- PC Assembly Language by Paul A. Carter
- NASM Documentation: https://www.nasm.us/doc/
- x86 Assembly Guide: https://www.cs.virginia.edu/~evans/cs216/guides/x86.html
- GNU Make Manual: https://www.gnu.org/software/make/manual/
