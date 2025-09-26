.model small
.stack 100h

.data
max_size    equ 100                   ; Maximum array size
prompt      db '? $'                  ; Prompt symbol to ask for input
sortedmsg   db 0dh,0ah,'sorted array: $' ; Message before printing sorted array
space       db ' $'                   ; Space separator for printing
array       db max_size dup(?)        ; Array to store characters
count       db 0                      ; Number of characters stored

.code
main proc
    ;-------------------------------------------------------
    ; Setup data segment
    ;-------------------------------------------------------
    mov ax, @data
    mov ds, ax

read_loop:
    ;-------------------------------------------------------
    ; Print prompt '?'
    ;-------------------------------------------------------
    lea dx, prompt
    mov ah, 09h        ; DOS function 09h = print string
    int 21h

    ;-------------------------------------------------------
    ; Read a single character
    ;-------------------------------------------------------
    mov ah, 01h        ; DOS function 01h = read char (echo)
    int 21h            ; Result in AL

    cmp al, '.'        ; If input is '.', stop input
    je print_final     ; Jump to final printing

    ;-------------------------------------------------------
    ; Check for duplicate characters
    ;-------------------------------------------------------
    mov cl, [count]    ; CL = number of elements in array
    xor ch, ch
    xor si, si         ; SI = index 0

chk_dup:
    cmp cl, 0          ; If count = 0, no duplicates possible
    je not_dup

    mov dl, [array+si] ; Load array[SI]
    cmp dl, al         ; Compare with input char
    je skip_insert     ; If equal → duplicate found → skip

    inc si             ; Move to next element
    dec cl             ; Decrease counter
    jnz chk_dup        ; Repeat until all checked

not_dup:
    ;-------------------------------------------------------
    ; Find correct position to insert (keep array sorted)
    ;-------------------------------------------------------
    mov cl, [count]
    xor ch, ch
    xor si, si         ; Reset SI = 0

find_pos:
    cmp si, cx         ; If SI >= count → reached end
    jae insert_here

    mov dl, [array+si] ; Load array[SI]
    cmp al, dl         ; If new char < array[SI]
    jl insert_here     ; → found insert position

    inc si             ; Else check next element
    jmp find_pos

insert_here:
    ;-------------------------------------------------------
    ; Shift array elements to the right to make space
    ;-------------------------------------------------------
    mov cl, [count]
    xor ch, ch
    mov di, cx
    dec di             ; Start from last element

shift_loop:
    cmp di, si
    jl place_char      ; Stop if reached insert position

    mov dl, [array+di] ; Shift element right
    mov [array+di+1], dl
    dec di
    jmp shift_loop

place_char:
    ;-------------------------------------------------------
    ; Place new character at the correct position
    ;-------------------------------------------------------
    mov [array+si], al
    inc byte ptr [count]   ; Increase array count
    jmp read_loop          ; Continue reading input

skip_insert:
    ;-------------------------------------------------------
    ; Skip if duplicate, go back to reading input
    ;-------------------------------------------------------
    jmp read_loop

;-----------------------------------------------------------
; Print final sorted array
;-----------------------------------------------------------
print_final:
    lea dx, sortedmsg
    mov ah, 09h
    int 21h

    mov cl, [count]        ; CL = number of elements
    xor ch, ch
    xor si, si

pr_loop:
    cmp si, cx             ; If SI >= count → done
    jae done

    mov dl, [array+si]     ; Load array[SI]
    mov ah, 02h            ; DOS function 02h = print char
    int 21h

    lea dx, space          ; Print a space after char
    mov ah, 09h
    int 21h

    inc si                 ; Next element
    jmp pr_loop

done:
    ;-------------------------------------------------------
    ; Exit program
    ;-------------------------------------------------------
    mov ah, 4Ch
    int 21h
main endp
end main
