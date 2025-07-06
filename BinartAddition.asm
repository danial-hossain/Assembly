.model small
.stack 100h
.data
a db 0111b
b db 0001b
.code

main proc 
           
  mov ax,@data
  mov ds,ax
  
  
  mov al,a
  add al,b  
  add al,48
  

  mov dl,al  
  mov ah,2  
  int 21h
  
  
  mov ah,4ch
  int 21h
  main endp
end main