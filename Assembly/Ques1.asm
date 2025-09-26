.model small           ; Small memory model (1 code segment + 1 data segment, each ≤ 64KB)
.stack 100h            ; Allocate 256 bytes for stack

.data
    msg1 db 'Enter time in seconds: $'           ; Prompt message for input
    msg2 db 0dh,0ah,'Time (hh:mm:ss) = $'        ; Output label (with newline before)

    input db 6,?,6 dup(?)   ; Input buffer for INT 21h/AH=0Ah
                            ; 1st byte = max chars allowed (6)
                            ; 2nd byte = actual length entered
                            ; rest = chars typed by user

    number dw ?             ; Stores total seconds entered (converted from ASCII)

    hour   dw ?             ; Stores calculated hours
    minute dw ?             ; Stores calculated minutes
    second dw ?             ; Stores calculated seconds

.code
main proc
    ;----------------------------------------------------------
    ; Load data segment
    ;----------------------------------------------------------
    mov ax, @data
    mov ds, ax

    ;----------------------------------------------------------
    ; Print input prompt: "Enter time in seconds: "
    ;----------------------------------------------------------
    mov ah, 9               ; DOS function: print string
    lea dx, msg1            ; DX = address of string
    int 21h

    ;----------------------------------------------------------
    ; Take input from user (buffered input method)
    ;----------------------------------------------------------
    mov ah, 0Ah             ; DOS function: buffered input
    lea dx, input           ; DX points to input buffer
    int 21h                 ; User types number and presses Enter

    ;----------------------------------------------------------
    ; Convert ASCII string in input buffer into number (AX)
    ;----------------------------------------------------------
    mov cl, [input+1]       ; CL = number of characters typed
    mov si, offset input+2  ; SI = points to first character
    xor ax, ax              ; AX = 0, will accumulate final number

convert_loop:
    cmp cl, 0               ; Check if all digits processed
    je done_convert         ; If no characters left → done
    mov bl, [si]            ; Load ASCII character
    sub bl, '0'             ; Convert ASCII → digit (e.g. '3' → 3)
    xor bh, bh              ; Clear BH → BX = digit
    mov dx, ax              ; Save old result
    mov ax, 10
    mul dx                  ; AX = old_result * 10
    add ax, bx              ; AX = (old_result * 10) + digit
    inc si                  ; Move to next character
    dec cl                  ; Decrement count
    jmp convert_loop        ; Repeat

done_convert:
    mov number, ax          ; Store final decimal number (seconds)

    ;----------------------------------------------------------
    ; Convert seconds into hours
    ;----------------------------------------------------------
    mov ax, number          ; AX = total seconds
    xor dx, dx              ; Clear DX for division
    mov bx, 3600            ; 3600 seconds in 1 hour
    div bx                  ; AX = quotient (hours), DX = remainder
    mov hour, ax            ; Save hours
    mov number, dx          ; Save remainder seconds

    ;----------------------------------------------------------
    ; Convert remainder into minutes and seconds
    ;----------------------------------------------------------
    mov ax, number          ; AX = remaining seconds
    xor dx, dx
    mov bx, 60              ; 60 seconds in a minute
    div bx                  ; AX = minutes, DX = seconds
    mov minute, ax          ; Save minutes
    mov second, dx          ; Save seconds

    ;----------------------------------------------------------
    ; Print message "Time (hh:mm:ss) = "
    ;----------------------------------------------------------
    mov ah, 9
    lea dx, msg2
    int 21h

    ;----------------------------------------------------------
    ; Print hours with leading zero if needed
    ;----------------------------------------------------------
    mov ax, hour
    call print_two_digits   ; Print HH
    mov dl, ':'             ; Print colon separator
    mov ah, 2
    int 21h

    ;----------------------------------------------------------
    ; Print minutes
    ;----------------------------------------------------------
    mov ax, minute
    call print_two_digits   ; Print MM
    mov dl, ':'
    mov ah, 2
    int 21h

    ;----------------------------------------------------------
    ; Print seconds
    ;----------------------------------------------------------
    mov ax, second
    call print_two_digits   ; Print SS

    ;----------------------------------------------------------
    ; Exit program
    ;----------------------------------------------------------
    mov ah, 4Ch
    int 21h
main endp


;==================================================================
; Procedure: print_two_digits
; Ensures numbers <10 are printed with a leading zero (e.g. 01)
; Input: AX = number
;==================================================================
print_two_digits proc
    push ax
    cmp ax, 10
    jae no_zero             ; If AX ≥ 10, skip zero
    mov dl, '0'             ; Print leading zero
    mov ah, 2
    int 21h
no_zero:
    pop ax
    call print_num          ; Print actual number
    ret
print_two_digits endp


;==================================================================
; Procedure: print_num
; Prints any positive integer stored in AX
; Uses division by 10 and stack to reverse digits
;==================================================================
print_num proc
    push ax
    push bx
    push cx
    push dx

    mov bx, 10              ; Divisor = 10
    mov cx, 0               ; Counter for digits

    cmp ax, 0
    jne convert_digits
    mov dl, '0'             ; Special case: if AX=0, print '0'
    mov ah, 2
    int 21h
    jmp print_done

convert_digits:
    xor dx, dx
digit_loop:
    div bx                  ; AX ÷ 10 → quotient in AX, remainder in DX
    push dx                 ; Save remainder (digit) on stack
    inc cx                  ; Increase digit count
    cmp ax, 0               ; Repeat until AX=0
    jne digit_loop

print_loop:
    pop dx                  ; Get digit from stack
    add dl, '0'             ; Convert to ASCII
    mov ah, 2
    int 21h                 ; Print digit
    loop print_loop

print_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_num endp

end main
