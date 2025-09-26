.MODEL SMALL
.STACK 100H   
.CODE
MAIN PROC             
    MOV AL, 65D
    MOV BL, 97D
    
    MOV AH,2 
    
    CMP AL,BL
    JLE L1  
    
    MOV DL,BL
    JMP DISPLAY
    
    L1:
    MOV DL,AL
    
    DISPLAY:
    INT 21H

    MOV AX, 4C00H
    INT 21H
END MAIN