;====================== BRACKET CHECKER ======================
; Checks (), {}, [] balance and matching in an expression.
; Reports: Correct / Too many Left / Too many Right / Mismatch
; Then asks to continue (Y) or exit.
;============================================================

.MODEL SMALL 
.STACK 100H 

.DATA 
PROMPT          DB 0DH,0AH,'Enter an Algebraic Expression : $'
CORRECT         DB 0DH,0AH,'Expression is Correct.$'
LEFT_BRACKETS   DB 0DH,0AH,'Too many Left Brackets.$'
RIGHT_BRACKETS  DB 0DH,0AH,'Too many Right Brackets. Begin Again!$'
MISMATCH        DB 0DH,0AH,'Bracket Mismatch. Begin Again!$'
CONTINUE        DB 0DH,0AH,'Type Y if you want to Continue : $'

.CODE 

MAIN PROC

    ; --- Set up data segment ---
    MOV  AX, @DATA              ; load DS with program's data segment
    MOV  DS, AX

@START:
    ; --- Show input prompt ---
    LEA  DX, PROMPT             ; DX = addr("Enter an Algebraic Expression : ")
    MOV  AH, 9                  ; DOS print-$-terminated string
    INT  21H

    XOR  CX, CX                 ; CX = 0 → will track current bracket depth
                                ; (how many unmatched left brackets are pushed)

@INPUT:
    ; --- Read one character from keyboard ---
    MOV  AH, 1                  ; AH=1 → read char w/ echo
    INT  21H                    ; AL = character, CR = 0Dh

    CMP  AL, 0DH                ; Enter pressed?
    JE   @END_INPUT             ; if CR, finish reading this line

    ; --- Handle left brackets: push them on stack, depth++ ---
    CMP  AL, '('
    JE   @PUSH
    CMP  AL, '{'
    JE   @PUSH
    CMP  AL, '['
    JE   @PUSH

    ; --- Handle right round bracket ")" ---
    CMP  AL, ')'
    JE   @ROUND

    ; --- Handle right curly bracket "}" ---
    CMP  AL, '}'
    JE   @CURLY

    ; --- Handle right square bracket "]" ---
    CMP  AL, ']'
    JE   @SQUARE

    ; Any other character: ignore and keep reading
    JMP  @INPUT

@PUSH:
    ; Push the left bracket we saw (in AL) onto the hardware stack.
    ; We push AX (word) for convenience; we will compare DL later.
    PUSH AX                     ; push the left bracket
    INC  CX                     ; depth++
    JMP  @INPUT                 ; read next char

@ROUND:                         ; we saw a ')'
    CMP  CX, 0                  ; do we have any unmatched left bracket?
    JLE  @RIGHT_BRACKETS        ; none → too many right brackets
    POP  DX                     ; pop last left bracket into DL
    DEC  CX                     ; depth--
    CMP  DL, '('                ; did it match '(' ?
    JNE  @MISMATCH              ; wrong kind → mismatch
    JMP  @INPUT                 ; OK → continue reading

@CURLY:                         ; we saw a '}'
    CMP  CX, 0
    JLE  @RIGHT_BRACKETS
    POP  DX
    DEC  CX
    CMP  DL, '{'                ; must match '{'
    JNE  @MISMATCH
    JMP  @INPUT

@SQUARE:                        ; we saw a ']'
    CMP  CX, 0
    JLE  @RIGHT_BRACKETS
    POP  DX
    DEC  CX
    CMP  DL, '['                ; must match '['
    JNE  @MISMATCH
    JMP  @INPUT

@END_INPUT:
    ; We hit Enter. If depth != 0, there are unclosed left brackets.
    CMP  CX, 0
    JNE  @LEFT_BRACKETS         ; depth > 0 → missing right brackets

    ; depth == 0 → expression is correct
    LEA  DX, CORRECT
    MOV  AH, 9
    INT  21H
    JMP  @ASK_CONT

@MISMATCH:
    ; Closing bracket type didn’t match most recent left bracket
    LEA  DX, MISMATCH
    MOV  AH, 9
    INT  21H
    JMP  @ASK_CONT

@LEFT_BRACKETS:
    ; Enter pressed with left brackets still open (depth > 0)
    LEA  DX, LEFT_BRACKETS
    MOV  AH, 9
    INT  21H
    JMP  @ASK_CONT

@RIGHT_BRACKETS:
    ; We saw a right bracket with no corresponding left bracket (depth==0)
    LEA  DX, RIGHT_BRACKETS
    MOV  AH, 9
    INT  21H
    JMP  @ASK_CONT

@ASK_CONT:
    ; Ask if user wants to continue
    LEA  DX, CONTINUE           ; "Type Y if you want to Continue : "
    MOV  AH, 9
    INT  21H

    MOV  AH, 1                  ; read a key
    INT  21H                    ; AL = key
    CMP  AL, 'Y'                ; continue only on uppercase Y
    JE   @START

@EXIT:
    MOV  AH, 4CH                ; terminate to DOS
    INT  21H

MAIN ENDP
END MAIN
