.MODEL SMALL

.STACK 100H

.CODE

    MAIN PROC
        MOV DL, 'B'
        MOV AH, 2
        INT 21H
        
    MAIN ENDP
    
  END MAIN
