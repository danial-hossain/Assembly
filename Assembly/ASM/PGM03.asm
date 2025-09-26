.MODEL SMALL
.STACK 100H
.CODE   
    MAIN PROC   
        MOV DL, 'B'
        MOV AH, 2
        INT 21H
        
        CALL NOT_MAIN
       
        INT 21H
       
        MOV AH, 4CH
        INT 21H 
    MAIN ENDP
    
    NOT_MAIN PROC 
        
        INT 21H   
        
        MOV DL, 'C'
        MOV AH, 2
        INT 21H
        
        RET
    NOT_MAIN ENDP
END MAIN











.model small
.stack 100h 
.data
a dw 10,13
.code 
main proc
    
    xor cx,cx
    mov ah,1   
    
for:
       int 21h        ; AH=1 ? read char (with echo), result in AL
       push ax        ; save character on stack
       inc cx         ; count characters
       cmp al,a    ; Enter key? (Carriage Return = 0Dh)
       jne for        ; if not Enter, keep reading
       
do:
      mov ah,2        ; AH=2 ? print char in DL
      pop ax          ; get last character from stack
      mov dl,al       ; move character into DL
      int 21h         ; print it
      loop do         ; CX--, repeat until CX=0
      
exit:
    mov ah,4ch        ; AH=4Ch ? exit to DOS
    int 21h
main endp
end main
