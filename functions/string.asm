[org 0x7c00]


mov bp, 0x8000
mov sp, bp

mov dx, 0x3333
call print_hex

;mov si, HELLO_MSG
;call print_string

;mov si, GOODBYE_MSG
;Call print_string



jmp $
%include "functions.asm"

print_hex:
  mov si, HEX_TEMPLATE
  call print_string
  ret


;
;Data
;

HEX_TEMPLATE:
  db '0x0000',0

HELLO_MSG:
  db 'Hello',0
GOODBYE_MSG:
  db 'Goodbye',0



times 510-($-$$) db 0
dw 0xaa55
