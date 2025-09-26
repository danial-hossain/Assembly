                 .MODEL SMALL
.STACK 100H

.DATA
R     DB 'ENTER RANGE: $'
FAB   DB 13,10,13,10,'FIBONACCI SERIES $'
N     DB ?
TEMP  DW ?          
DIVISOR DW 10      

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

  
    MOV DX,OFFSET R
    MOV AH,9
    INT 21H

   
    XOR BX,BX
    MOV BL,10

    MOV AH,1
    INT 21H
    CMP AL,13
    JE NEXT
    SUB AL,30H
    MOV CL,AL

 
    MOV AH,1
    INT 21H
    CMP AL,13
    JE NEXT
    SUB AL,30H
    MOV CH,AL

    MOV AL,CL
    MUL BL
    ADD AL,CH
    MOV N,AL
    JMP INPUT_DONE

NEXT:
    MOV N,CL

INPUT_DONE:
   
    LEA DX,FAB
    MOV AH,9
    INT 21H

    MOV CX,0
    MOV CL,N        
    CMP CL,0      
    JE EXIT_PROGRAM
    
    MOV BL,0        
    MOV BH,1     

   
    PUSH BX
    PUSH CX
    MOV AL,BL
    MOV AH,0
    CALL DISPLAY_NUMBER
    POP CX
    POP BX
    DEC CX          
    JZ EXIT_PROGRAM

 
    PUSH BX
    PUSH CX
    MOV AL,BH
    MOV AH,0
    CALL DISPLAY_NUMBER
    POP CX
    POP BX
    DEC CX       
    JZ EXIT_PROGRAM

FIB_LOOP:
  
    MOV AL,BL
    ADD AL,BH
    MOV BL,BH
    MOV BH,AL
    
    
    PUSH BX
    PUSH CX
    MOV AL,BH
    MOV AH,0
    CALL DISPLAY_NUMBER
    POP CX
    POP BX
    
    LOOP FIB_LOOP

EXIT_PROGRAM:
    ; exit
    MOV AH,4CH
    INT 21H
MAIN ENDP


DISPLAY_NUMBER PROC
    MOV CX,0       
    MOV BX,DIVISOR 

DIGIT_LOOP:
    XOR DX,DX      
    DIV BX         
    PUSH DX        
    INC CX         
    CMP AX,0        
    JNE DIGIT_LOOP  

PRINT_DIGITS:
    POP DX         
    ADD DL,30H     
    MOV AH,2       
    INT 21H
    LOOP PRINT_DIGITS

 
    MOV DL,' '
    MOV AH,2
    INT 21H
    
    RET
DISPLAY_NUMBER ENDP

END MAIN


