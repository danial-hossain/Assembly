.model small
.stack 100h

.data
num1 dw 48
num2 dw 18

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, num1   
    mov bx, num2   

gcd_loop:
    cmp bx, 0     
    je done
    xor dx, dx   
    div bx        
    mov ax, bx    
    mov bx, dx     
    jmp gcd_loop

done:

    add al, 30h  
    mov dl, al
    mov ah, 2
    int 21h

   
    mov ah, 4Ch
    int 21h

main endp
end main
