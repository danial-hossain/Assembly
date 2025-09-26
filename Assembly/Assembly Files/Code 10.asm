;REPEAT
;   statements
;UNTIL condition

.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC  
    
    MOV AH,1

    REPEAT:
    INT 21H
    CMP AL,' '
    JNE REPEAT
    END_WHILE:
    
    MOV AX, 4C00H
    INT 21H
    
END MAIN


.model small
.stack 100h
.code 
main proc
    mov ah,1   
    xor cx,cx
    for:
       int 21h
       push ax    
       inc cx
       cmp al,0DH
       jne for
       
    do:
      mov ah,2
      pop ax
      mov dl,al
      int 21h
      loop do
      
      
      
exit:
    mov 4,ah
    int 21h
    main endp
end main
       