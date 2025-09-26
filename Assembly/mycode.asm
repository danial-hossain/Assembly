.MODEL SMALL
.STACK 100H

.DATA     
INPUT DB 2,2,3,4,5,6,7,8,9,4  
MSG1 DB 10,13,'LARGEST VALUE: $'  
MSG2 DB 10,13,'SMALLEST VALUE: $' 
MSG3 DB 10,13,'RANGE: $'          
LARGER DB ?
SMALLER DB ?
     
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

   
    LEA SI,INPUT 
    MOV CX,0          
    MOV BL,0          
    
LARGEST:
    MOV AL,[SI]        
    CMP AL,BL          
    JLE NOT_LARGER   
    MOV BL,AL         
NOT_LARGER:
    INC SI             
    INC CX            
    CMP CX,10          
    JL LARGEST        
    
PRINT1:   
    MOV LARGER,BL      
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    MOV AH,2
    MOV DL,BL
    ADD DL, '0'       
    INT 21H  
    
  
    LEA SI,INPUT      
    MOV CX,0          
    MOV BL,100        
    
SMALLEST:
    MOV AL,[SI]       
    CMP AL,BL         
    JGE NOT_SMALLER    
    MOV BL,AL          
NOT_SMALLER:
    INC SI          
    INC CX            
    CMP CX,10        
    JL SMALLEST       
    
PRINT2:   
    MOV SMALLER,BL    
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    MOV AH,2
    MOV DL,BL
    ADD DL, '0'       
    INT 21H  
    

    MOV AH,9
    LEA DX,MSG3
    INT 21H
                
    MOV BL, LARGER
    SUB BL, SMALLER
    MOV AH,2
    MOV DL,BL
    ADD DL, '0'      
    INT 21H          
     
EXIT:              
    MOV AH,4Ch
    INT 21h 
MAIN ENDP
END MAIN