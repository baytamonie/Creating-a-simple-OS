[org 0x7c00]

mov dx, 9
; if <10 -> print 't'
;else -> print 'T'




cmp dx,10 ; cmp->compare 
jl less_than_10

mov al, 'T'
jmp endif 

less_than_10:
  mov al, 't'

endif:



mov ah,0x0e
int 0x10 

jmp $

times 510-($-$$) db 0
dw 0xaa55

; these are based on a previous cmp
; je target ; jump if equal
; jne target ; jump if not equal
; jl target ; jump ifless than
; jle target ; jump if less than or equal
; jg target ; jump if greater than
; jge target ; jump if greater than or equal
