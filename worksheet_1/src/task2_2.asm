; task2_2.asm
; Task 2.2: Array sum
; Define an array of 100 elements, initialize to 1-100, sum and output result
;

%include "asm_io.inc"

segment .data
    result_msg  db "Sum of array (1-100): ", 0

segment .bss
    array   resd 100    ; Reserve 100 doublewords (32-bit integers)

segment .text
    global asm_main

asm_main:
    enter   0,0         ; Setup routine
    pusha               ; Save all registers

    ; Initialize array with values 1 to 100
    mov     ecx, 100    ; Counter for loop
    mov     edi, array  ; EDI points to start of array
    mov     eax, 1      ; Starting value

init_loop:
    mov     [edi], eax  ; Store current value in array
    add     edi, 4      ; Move to next element (4 bytes per doubleword)
    inc     eax         ; Increment value
    loop    init_loop   ; Decrements ECX and jumps if not zero

    ; Sum the array
    mov     ecx, 100    ; Counter for loop
    mov     edi, array  ; Reset pointer to start of array
    xor     eax, eax    ; Clear EAX (sum = 0)

sum_loop:
    add     eax, [edi]  ; Add current element to sum
    add     edi, 4      ; Move to next element
    loop    sum_loop    ; Decrements ECX and jumps if not zero

    ; Print result message
    push    eax         ; Save sum
    mov     eax, result_msg
    call    print_string
    pop     eax         ; Restore sum

    ; Print the sum
    call    print_int
    call    print_nl

    popa                ; Restore all registers
    mov     eax, 0      ; Return 0
    leave
    ret
