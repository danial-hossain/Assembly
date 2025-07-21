.model small
.stack 100h  
.data
  a db 'Enter 1st Capital Alphabet : $' 
  b db 'Enter 2nd Capital Alphabet : $' 
  c db 'Alphabetical Order : $'
.code
  
main proc
  mov ax,@data
  mov ds,ax
    
  mov ah,9
  lea dx,a
  int 21h
     
  mov ah,1
  int 21h
  mov bl,al
  
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
  mov bh,al
  
  cmp bl,bh
  jg L1
  
  L2: 
   mov ah,2
   mov dl,13
   int 21h
   mov dl,10
   int 21h
   
   mov ah,9
   lea dx,c
   int 21h
    
   mov ah,2 
   mov dl,bl
   int 21h
   mov dl,bh
   int 21h
   jmp exit
   
  L1: 
   mov ah,2
   mov dl,13
   int 21h
   mov dl,10
   int 21h
   
   mov ah,9
   lea dx,c
   int 21h
      
   mov ah,2   
   mov dl,bh
   int 21h
   mov dl,bl
   int 21h
   
   exit:
   mov ah,4ch  
   int 21h
   main endp
end main