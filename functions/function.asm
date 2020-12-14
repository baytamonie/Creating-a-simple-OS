[org 0x7c00]


mov bp, 0x8000
mov sp, bp


mov al, 'X'
call print_char



mov al, 'Y'
call print_char



mov al, 'Z'
call print_char



jmp $
 
;functions


print_char:
  mov ah, 0x0e
  int 0x10
  ;push ax
  ;pusha ; push all registers
  ;mov ax, 'B'
  ;add ax , 1
  ;popa ; pop all registers
  ;pop ax
  ret
  ; pop dx 
  ;jmp dx

times 510-($-$$) db 0
dw 0xaa55
