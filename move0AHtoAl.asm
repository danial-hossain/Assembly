.model small
.stack 100h
.data
.code

main proc
    mov ax, @data
    mov ds, ax

    mov al, 0AH      
    mov ah, 0      

    mov bl, 10
    div bl         

  
    mov cl, al      
    mov ch, ah     

  
    add cl, 48      
    mov dl, cl
    mov ah, 2
    int 21h

   
    add ch, 48     
    mov dl, ch
    mov ah, 2
    int 21h

   
    mov ah, 4Ch
    int 21h
main endp
end main
