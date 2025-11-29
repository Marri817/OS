; task2_3.asm
; Task 2.3: Range sum
; Ask user to enter a range to sum, check validity, and display sum of that range
;

%include "asm_io.inc"

segment .data
    prompt_start    db "Enter start index (1-100): ", 0
    prompt_end      db "Enter end index (1-100): ", 0
    error_msg       db "Error: Invalid range! (must be 1 <= start <= end <= 100)", 0
    result_msg1     db "Sum of range [", 0
    result_msg2     db "-", 0
    result_msg3     db "]: ", 0

segment .bss
    array       resd 100    ; Reserve 100 doublewords
    start_idx   resd 1      ; Start index
    end_idx     resd 1      ; End index

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
    add     edi, 4      ; Move to next element
    inc     eax         ; Increment value
    loop    init_loop

    ; Get start index from user
    mov     eax, prompt_start
    call    print_string
    call    read_int
    mov     [start_idx], eax    ; Store start index
    mov     ebx, eax            ; EBX = start

    ; Get end index from user
    mov     eax, prompt_end
    call    print_string
    call    read_int
    mov     [end_idx], eax      ; Store end index
    mov     edx, eax            ; EDX = end

    ; Validate: check if start >= 1
    cmp     ebx, 1
    jl      print_error

    ; Validate: check if end <= 100
    cmp     edx, 100
    jg      print_error

    ; Validate: check if start <= end
    cmp     ebx, edx
    jg      print_error

    ; Calculate sum of range [start, end]
    ; Number of elements = end - start + 1
    mov     ecx, edx
    sub     ecx, ebx
    inc     ecx         ; ECX = count of elements

    ; Calculate starting position in array
    ; Offset = (start - 1) * 4 bytes
    mov     edi, array
    dec     ebx         ; Convert to 0-based index
    shl     ebx, 2      ; Multiply by 4 (shift left by 2)
    add     edi, ebx    ; EDI points to start of range

    ; Sum the range
    xor     eax, eax    ; Clear sum

sum_loop:
    add     eax, [edi]  ; Add current element to sum
    add     edi, 4      ; Move to next element
    loop    sum_loop

    ; Print result
    push    eax         ; Save sum

    mov     eax, result_msg1
    call    print_string
    
    mov     eax, [start_idx]
    call    print_int
    
    mov     eax, result_msg2
    call    print_string
    
    mov     eax, [end_idx]
    call    print_int
    
    mov     eax, result_msg3
    call    print_string
    
    pop     eax         ; Restore sum
    call    print_int
    call    print_nl

    jmp     done

print_error:
    mov     eax, error_msg
    call    print_string
    call    print_nl

done:
    popa                ; Restore all registers
    mov     eax, 0      ; Return 0
    leave
    ret
