[org 0x7c00] ; where bios is loaded
; print a char to the screen
;mov al, [0x7c07] ; first time accessing memory




;mov bx, 0x7c0  ;
;mov ds, bx ; move bx into data segment


;mov al, [0xC]  ;0x7c0 * 0x10-> 0x7c00 + 0xC --> 0x7c0c
mov ah, 0xe; BIOS scrolling teletype function
mov al, [my_character]
int 0x10; interrupt




mov al, [my_character2]
int 0x10; interrupt


my_character:
 db 'X'

my_character2:
 db 'Y'

jmp$ ; endless jump- to stop the CPU zooming of executing arbitary bytes
     ; in memory at code.
 
; pad out the bootsector to 512 bytes with the last 2 bytes as magic
; (bootable) number
 times 510-($-$$) db 0
 dw 0xaa55
 
