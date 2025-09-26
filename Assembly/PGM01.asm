;Write a program for entering a character and printing it in binary
.model small
.stack 100h
.data
    msg1 db 'Enter a character: $'
    msg2 db 0Dh,0Ah,'Binary: $'
.code
main proc
    mov ax, @data
    mov ds, ax 
    
    lea dx, msg1  ; Show prompt
    mov ah, 09h
    int 21h
    
    mov ah, 01h   ; Read a single character
    int 21h   
    mov bl, al    ; Store input character in BL 
    
    lea dx, msg2  ; Show "Binary: "
    mov ah, 09h
    int 21h    
    
    mov cx, 8            ; We'll check 8 bits 
    
print_bits:
    shl bl, 1            ; Shift left into carry
    jc print_one         ; CF = 1
    mov dl, '0'          ; Print '0'
    jmp print_char

print_one:
    mov dl, '1'          ; Print '1'

print_char:
    mov ah, 02h
    int 21h
    dec cx
    jnz print_bits

    mov ax, 4C00h
    int 21h
end main