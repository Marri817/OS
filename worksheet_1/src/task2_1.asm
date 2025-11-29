; task2_1.asm
; Task 2.1: Loop with name and validation
; Ask for user's name and number of times to print welcome message
; Validate that number is between 50 and 100
;

%include "asm_io.inc"

segment .data
    prompt_name     db "Enter your name: ", 0
    prompt_count    db "Enter number of times to print (50-100): ", 0
    error_msg       db "Error: Number must be between 50 and 100!", 0
    welcome_msg     db "Welcome, ", 0
    exclamation     db "!", 0

segment .bss
    name    resb 100    ; Reserve 100 bytes for name

segment .text
    global asm_main

asm_main:
    enter   0,0         ; Setup routine
    pusha               ; Save all registers

    ; Prompt for name
    mov     eax, prompt_name
    call    print_string
    
    ; Read name (character by character until newline)
    mov     edi, name   ; EDI points to name buffer
read_name_loop:
    call    read_char
    cmp     al, 10      ; Check if newline (ASCII 10)
    je      name_done
    mov     [edi], al   ; Store character
    inc     edi
    jmp     read_name_loop
name_done:
    mov     byte [edi], 0   ; Null terminate the string

    ; Prompt for count
    mov     eax, prompt_count
    call    print_string
    call    read_int
    mov     ebx, eax    ; Store count in EBX

    ; Validate: check if >= 50
    cmp     ebx, 50
    jl      print_error
    
    ; Validate: check if <= 100
    cmp     ebx, 100
    jg      print_error

    ; Valid range - print welcome messages
    mov     ecx, ebx    ; ECX = counter
print_loop:
    ; Print "Welcome, "
    mov     eax, welcome_msg
    call    print_string
    
    ; Print name
    mov     eax, name
    call    print_string
    
    ; Print "!"
    mov     eax, exclamation
    call    print_string
    call    print_nl
    
    ; Decrement counter and loop
    dec     ecx
    jnz     print_loop  ; Jump if not zero
    
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
