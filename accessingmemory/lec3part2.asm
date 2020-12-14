[org 0x7c00]

mov [0x40],word 0x0 ; corrupitng interrupt 10 (mutliplied by 4)


mov al, [my_char]
mov ah, 0x0e 
int 0x10

my_char:
   db 'X'
times 510-($-$$) db 0
dw 0xaa55
    
jmp $; 
