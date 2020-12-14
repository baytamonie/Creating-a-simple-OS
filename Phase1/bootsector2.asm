mov ah, 0x0e ; BIOS scrolling teletype function

mov al, 'B'
int 0x10

mov al, 'a'
int 0x10

mov al, 'y'
int 0x10

mov al, 't'
int 0x10

mov al, 'a'
int 0x10

mov al, 'O'
int 0x10

mov al, 'S'
int 0x10


jmp $ ; endless jump

times 510-($-$$) db 0
dw 0xaa55
