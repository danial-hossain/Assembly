.model small
.stack 100h
.data
digit1 db 'Enter Digit 1 :$'
digit2 db 'Enter Digit 2 :$' 
sum db 'Sum of the Digits :$'
d1 db ?
d2 db ? 

.code

main proc  
    mov ax,@data
    mov ds,ax
    
    lea dx,digit1
    mov ah,9
    int 21h
    
    mov ah,1 
    int 21h
    mov d1,al  
    
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
             
    lea dx,digit2
    mov ah,9
    int 21h   
    
    mov ah,1 
    int 21h
    mov d2,al
    
    sub d1,48
    sub d2,48  
    mov bl,d1
    add bl,d2
    add bl,48 
       
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    lea dx,sum
    mov ah,9
    int 21h 
    
           
    mov dl,bl
    mov ah,2
    int 21h
    
mov ah,4ch
main endp
end main
    
     
    
    
    
    
    