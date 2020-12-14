[org 0x7c00]

mov ah, 0x0e

; printing the alphabet 

mov al, 'A'
loop:
  int 0x10 
  add al, 1  
  cmp al, 'Z'
  jle loop



jmp $
times 510-($-$$) db 0 
dw 0xaa55
