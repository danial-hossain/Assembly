.MODEL SMALL
.STACK 100H
.DATA   
    MSG1 DB 'ZERO$' 
    MSG2 DB 'POS$'
    MSG3 DB 'NEG$'    
.CODE
MAIN PROC   
    MOV AX,@DATA
    MOV DS, AX
    
    MOV AX,00
    CMP AX,0
    JL NEGATIVE
    JE ZERO
    JG POSITIVE
    NEGATIVE:
        LEA DX, MSG3
        JMP END_CASE
    ZERO:
        LEA DX, MSG1
        JMP END_CASE
    POSITIVE:
        LEA DX, MSG2
    END_CASE:   
        MOV AH, 9
        INT 21H

END MAIN