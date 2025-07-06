.MODEL SMALL            ; Sets the memory model to SMALL
.STACK 100H             ; Reserves 100h for the stack segment
.CODE                   ; Begins the code segment 
MAIN PROC               ; Declares the start of the MAIN procedure
    ;display prompt
    MOV AH,2            ; Sets function 02h in register AH
    MOV DL,'?'          ; Loads the ASCII value of ? into DL
    INT 21H             ; Calls interrupt 21H
                  
    ;input a character              
    MOV AH,1            ; Sets up function 01h
    INT 21H             ; Calls interrupt 21H, input is in AL
    MOV BL,AL           ; Stores input from AL to BL      
    
    ;go to a new line
    MOV AH,2
    MOV DL,0DH          ; display carriage return 0DH,move to beginning of current line
    INT 21H
    MOV DL,0AH          ; display line feed 0AH to move cursor down one line
    INT 21H          
    
    ;display character
    MOV DL,BL
    INT 21H           
    
    ;return to DOS
    MOV AX,4C00H        ; Calls function 4Ch to terminate the program and return control
    INT 21H            
    END MAIN