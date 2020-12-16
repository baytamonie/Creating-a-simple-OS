[org 0x7c00]
mov bp, 0xffff
mov sp, bp

mov si, MSG_REAL_MODE
call print_string

; switch into pm

call switch_to_pm


jmp $

%include "functions.asm"
%include "switch_to_pm.asm"
%include "pm_functions.asm"
[bits 32]
BEGIN_PM:
  mov esi, MSG_PROT_MODE
  call print_string_pm
; video memory is at 0xb8000


  jmp $;

[bits 16]
; Messages to display
MSG_REAL_MODE db "started in 16-bit Real Mode", 0
MSG_PROT_MODE db "successfully switched into 32-bit Protected Mode", 0


times 510-($-$$) db 0
dw 0xaa55
