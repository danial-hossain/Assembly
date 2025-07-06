.model small
.stack 100h
.data
input db 'Enter an uppercase letter : $' 
output db 'Corresponding lowercase  letter : $'
char db ?
.code
main proc  
    mov ax,@data
    mov ds,ax
    
   
    lea dx,input
    mov ah,9
    int 21h
    
    mov ah,1
    int 21h
    mov char,al
    
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    lea dx,output
    mov ah,9
    int 21h
    
    
    add char,32
    mov ah,2
    mov dl,char
    int 21h
  
mov ah,4ch
main endp
end main