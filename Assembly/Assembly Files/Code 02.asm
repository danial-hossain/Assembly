.MODEL SMALL
.STACK 100H   
.DATA
    msg1 db 'first$'
    msg2 db 'second$'
.CODE
MAIN PROC   
    
    MOV AX, @DATA
    MOV DS, AX
    
    JMP NEXT
    
    mov ah, 9
    lea dx, msg1
    int 21h      

    NEXT: 
        
    mov ah, 9
    lea dx, msg2
    int 21h 
    
    MOV AX, 4C00H
    INT 21H
END MAIN