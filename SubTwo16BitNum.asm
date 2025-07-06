.model small
.stack 100h
.code
main proc
    mov ax,170
    mov bx,175
    sub bx,ax
    mov cx,bx
    mov dx,cx
    mov ah,2 
    add dl,48
    int 21h
    
mov ah,4ch
main endp
end main