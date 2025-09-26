.MODEL SMALL
.STACK 100H   
.CODE
MAIN PROC 
    
    MOV AL, 98D
    MOV BL, 97D
    
    MOV CL, AL      
    CMP BL, CL        
    JLE NEXT         
    MOV CL, BL       

    NEXT: 
    
    MOV AH, 2
    MOV DL, CL
    INT 21H
    
    MOV AX, 4C00H
    INT 21H
END MAIN