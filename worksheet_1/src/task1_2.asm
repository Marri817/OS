; task1_2.asm
; Task 1.2: Extended example (based on slide 22)
; Demonstrates more complex operations with input and output
;

%include "asm_io.inc"

segment .data
    prompt1 db "Enter a number: ", 0
    prompt2 db "Enter another number: ", 0
    outmsg1 db "You entered ", 0
    outmsg2 db " and ", 0
    outmsg3 db ", the sum is ", 0

segment .bss

segment .text
    global asm_main

asm_main:
    enter   0,0         ; Setup routine
    pusha               ; Save all registers

    ; Prompt for first number
    mov     eax, prompt1
    call    print_string
    call    read_int
    mov     ebx, eax    ; Store first number in EBX

    ; Prompt for second number
    mov     eax, prompt2
    call    print_string
    call    read_int
    mov     ecx, eax    ; Store second number in ECX

    ; Display output message
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
    
    ; Calculate and display sum
    mov     eax, ebx
    add     eax, ecx
    call    print_int
    call    print_nl

    popa                ; Restore all registers
    mov     eax, 0      ; Return 0
    leave
    ret
