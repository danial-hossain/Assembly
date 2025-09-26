.MODEL SMALL 
.STACK 100H 

.DATA 
PROMPT1 DB 'Enter the string : $' 
PROMPT2 DB 0DH,0AH,'The string with words reversed : $' 
BUFFER  DB 100 DUP('$')   ; input buffer (100 bytes, filled with '$') 
NEWLINE DB 0DH,0AH,'$'    ; newline characters (CR LF) 

.CODE 

MAIN PROC 

    ; --- setup DS segment ---
    MOV AX, @DATA     ; load data segment address
    MOV DS, AX        ; DS = data segment

    ; --- Show first prompt ---
    LEA DX, PROMPT1   ; load address of "Enter the string :"
    MOV AH, 9         ; DOS print string
    INT 21H           ; call DOS interrupt

    ; --- Read input string into BUFFER ---
    XOR CX, CX        ; CX = 0 (will count characters)
    LEA SI, BUFFER    ; SI points to start of BUFFER

READ_LOOP: 
    MOV AH, 1         ; DOS read character
    INT 21H           ; input char -> AL
    CMP AL, 0DH       ; is it Enter key (carriage return)?
    JE END_INPUT      ; if yes → finish input
    MOV [SI], AL      ; store char in buffer
    INC SI            ; move to next buffer position
    INC CX            ; increment character count
    JMP READ_LOOP     ; keep reading

END_INPUT: 
    MOV BYTE PTR [SI], 0  ; terminate string with 0 (null)

    ; --- Show second prompt ---
    LEA DX, PROMPT2   ; load address of "The string with words reversed :"
    MOV AH, 9         ; DOS print string
    INT 21H 

    ; --- Start processing buffer ---
    LEA SI, BUFFER    ; SI = start of BUFFER

; ====================================================
; MAIN LOOP TO PROCESS WORDS
; ====================================================

NEXT_WORD: 
    MOV AL, [SI]      ; load character from buffer
    CMP AL, 0         ; is it end of string?
    JE DONE           ; if yes → program ends

    CMP AL, ' '       ; is it a space?
    JNE WORD_START    ; if not space → start of a word

    ; if it IS a space → print space as it is
    MOV DL, ' ' 
    MOV AH, 2         ; DOS print character
    INT 21H 
    INC SI            ; move to next char
    JMP NEXT_WORD     ; repeat

; ====================================================
; WORD FOUND → find its end
; ====================================================

WORD_START: 
    MOV DI, SI        ; DI = start of word

FIND_END: 
    MOV AL, [DI]      ; check each character
    CMP AL, 0         ; end of string?
    JE REVERSE        ; if yes → go print backward
    CMP AL, ' '       ; space found?
    JE REVERSE        ; if yes → end of word
    INC DI            ; else keep moving DI
    JMP FIND_END

; ====================================================
; Print word backwards (from DI down to SI)
; ====================================================

REVERSE: 
    DEC DI            ; step back to last letter of word

PRINT_BACK: 
    CMP DI, SI        ; are we before start of word?
    JB WORD_DONE      ; if yes → word is done
    MOV DL, [DI]      ; take character
    MOV AH, 2 
    INT 21H           ; print character
    DEC DI            ; move backward
    JMP PRINT_BACK    ; repeat

; ====================================================
; Finished one word → move SI to next word
; ====================================================

WORD_DONE: 
    MOV AL, [SI] 
    CMP AL, 0         ; end of string?
    JE DONE 

FIND_SPACE: 
    MOV AL, [SI]      ; scan until space or end
    CMP AL, 0 
    JE NEXT_WORD      ; if end, go check next
    CMP AL, ' ' 
    JE NEXT_WORD      ; if space, go handle it
    INC SI            ; else keep moving forward
    JMP FIND_SPACE 

; ====================================================
; Exit program
; ====================================================

DONE: 
    MOV AH, 4CH       ; terminate program
    INT 21H 

MAIN ENDP 
END MAIN 
