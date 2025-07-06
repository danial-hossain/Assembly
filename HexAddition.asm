.model small
.stack 100h
.data
a db 0AH       ; 0011b
b db 0FH       ; 0001b
.code

main proc 
  mov ax, @data
  mov ds, ax

  mov al, a
  add al, b      ; AL = a + b = 4
  mov ah,0    ; Convert number to ASCII ('0' + 4 = '4')
  mov bl,10
  div bl
  
  mov ch,ah
  mov cl,al
           
           
           
          
           
  mov dl, cl 
  add dl,48
  mov ah, 2
  int 21h        ; Print character
   mov dl, ch
   add dl,48
  mov ah, 2
  int 21h 
  mov ah, 4ch
  int 21h        ; Exit program
main endp
end main
