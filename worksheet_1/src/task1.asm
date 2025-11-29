; task1.asm
; Task 1.1: Basic addition program (Slide 18)
; Adds two integers stored in global memory and outputs the result
;

%include "asm_io.inc"

segment .data
    ; Define two integers to add
    num1    dd  10      ; First number (32-bit doubleword)
    num2    dd  25      ; Second number (32-bit doubleword)

segment .bss
    ; No uninitialized data needed

segment .text
    global asm_main

asm_main:
    enter   0,0         ; Setup routine
    pusha               ; Save all registers

    ; Load first number into EAX
    mov     eax, [num1]
    
    ; Add second number to EAX
    add     eax, [num2]
    
    ; Print the result (value in EAX)
    call    print_int
    call    print_nl    ; Print newline

    popa                ; Restore all registers
    mov     eax, 0      ; Return 0
    leave
    ret
