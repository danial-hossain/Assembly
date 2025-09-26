.MODEL SMALL
.STACK 100H
.CODE   
    MAIN PROC   
        MOV DL, 'B'
        MOV AH, 2
        INT 21H
        
        CALL NOT_MAIN
        
        MOV DL, 'C'
        MOV AH, 2
        INT 21H
       
        MOV AH, 4CH
        INT 21H 
    MAIN ENDP
    
    INCLUDE PGM05.ASM
END MAIN