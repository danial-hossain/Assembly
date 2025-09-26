;WHILE condition DO
;   statements
;END_WHILE


.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    MOV AH,1
    INT 21H  
    
    WHILE_:
    CMP AL,0DH
    JE END_WHILE
    INT 21H
    JMP WHILE_   
    
    END_WHILE: 
     
    MOV AX,4C00H
    INT 21H
END MAIN