.MODEL SMALL
.STACK 100H
.DATA
MSG DW 'HELLO!$'

.CODE
MAIN PROC
    ;initialize DS
    MOV AX,@DATA    ; Loads address of data segment into AX
    MOV DS,AX       ; Sets DS to point to data segment
    
    ;display message
    LEA DX,MSG      ; Loads the address of MSG to DX
    MOV AH,9        ; Sets up function 09h        
    INT 21H         ; Calls interrupt 21h to execute function 09h and print the message  
    
    ;return to DOS
    MOV AX,4C00H
    INT 21H
    END MAIN