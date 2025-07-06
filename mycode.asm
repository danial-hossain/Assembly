.model small
.stack 256
.code

main proc
    mov ah, 1        ; DOS function to read a character
    int 21h          ; call interrupt, result in AL
    mov bl, al       ; store input character in BL

    mov ah, 2        ; DOS function to display character
    mov dl, bl       ; move character to DL for output
    int 21h          ; call interrupt to display

exit:
    mov ah, 4Ch      ; DOS function to exit program
    int 21h
main endp
end main
