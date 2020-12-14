[org 0x7c00]

mov ah, 0x0e 

mov bp, 0x8000 ; (base pointer)stack base
mov sp,bp ; stack pointer (moves downwards)


;Push Chars
push 'A '
push 'B'
push 'C'



mov al, [0x7FFE]
int 0x10


mov al, [0x7FFC]
int 0x10

mov al, [0x7FFA]
int 0x10









jmp $







;pop and print
pop bx
mov al, bl
int 0x10

;pop and print
pop bx
mov al, bl
int 0x10


;pop and print
pop bx
mov al, bl
int 0x10




jmp$

times 510-($-$$) db 0
dw 0xaa55 
