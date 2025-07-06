.model small
.stack 100h
.code
main proc
    mov dl,65
    mov ah,2 
    int 21h
    
mov ah,4ch
main endp
end main
    