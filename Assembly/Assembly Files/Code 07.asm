.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    MOV AH,1
    INT 21H
    
    CMP AL, 'y'
    JE THEN
    CMP AL,'Y'
    JE THEN
    JMP ELSE_
    THEN:
        MOV AH,2
        MOV DL,AL
        INT 21H
        JMP END_IF
    ELSE_:
    
    END_IF:   
    
    MOV AX,4C00H
    INT 21H

END MAIN