.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    
    MOV CX,05
    MOV AH,2
    MOV DL,'*'
    TOP:
        INT 21H
        LOOP TOP
        
    MOV AX,4C00H
    INT 21H

END MAIN