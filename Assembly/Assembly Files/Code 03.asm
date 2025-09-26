.MODEL SMALL
.STACK 100H   
.CODE
MAIN PROC   
    
    MOV AH, 1
    INT 21H 
    MOV BL, AL 
    
    CMP BL, 97D
    JL NEXT
    
    SUB BL, 32D
    
    NEXT:  
    MOV AH, 2
    MOV DL, BL
    INT 21H
    
    
    
    MOV AX, 4C00H
    INT 21H
END MAIN