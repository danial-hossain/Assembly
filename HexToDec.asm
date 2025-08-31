.model small
.stack 100h  
.data
  a db 'Enter a hex digit character(0-F) : $' 
  b db 'if you want to do it again?(Y/N) $' 
  c db 'Try Again$'
.code
  
main proc
  mov ax,@data
  mov ds,ax
   
  Repeat:  

  mov ah,9
  lea dx,a
  int 21h
     
  mov ah,1
  int 21h  
   
  cmp al,'0'
  jl Invalid
  
  cmp al,'9'
  jle valid 
  
  cmp al,'A'
  jl Invalid
  
  cmp al,'F' 
  jle Valid 
  
  Invalid:  
  mov ah,2
  mov dl,13
  int 21h
  mov dl,10
  int 21h  
  
  mov ah,9
  lea dx,c 
  int 21h
  
  mov ah,2
  mov dl,13
  int 21h
  mov dl,10
  int 21h
  jmp Repeat

Valid:
 
  mov bl,al
  
  cmp bl,57 
  jg L2     


    L1: 
   mov ah,2
   mov dl,13
   int 21h
   mov dl,10
   int 21h     
   mov dl,bl
   int 21h
   jmp Goto
  
  L2: 
   mov ah,2
   mov dl,13
   int 21h
   mov dl,10
   int 21h  
   mov dl,'1'
   int 21h
   sub bl,17
   mov dl,bl
   int 21h 
         
  Goto:  
   mov ah,2
   mov dl,13
   int 21h
   mov dl,10
   int 21h
      
   mov ah,9
   lea dx,b  
   int 21h
   
   mov ah,1
   int 21h
   
   cmp al,'Y' 
   mov ah,2
   mov dl,13
   int 21h
   mov dl,10
   int 21h 
  
   je Repeat
     
   cmp al,'N'
   je exit
          
         
   exit:
   mov ah,4ch  
   int 21h
   main endp
end main