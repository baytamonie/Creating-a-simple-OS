[org 0x7c00]

; Setup the stack away from our code.
mov bp, 0x8000 ; Set the stack base (bottom)
mov sp,bp

;; mov dx , [0x7c00 + 510] get bootsector
;;mov dx, [0x7c00 + 510]
;;call print_hex

mov ax ,0xc000
mov ds, ax
mov si, 0x57a9
call print_string

jmp $

call find_bios_string



jmp $ ; hang CPU here.

;find_me:
;db 'BIOS',0



; include print string function(prints null-terminated string pointed to by si register)
%include"/home/bayta/Documents/OS/Creating-a-simple-OS/functions/functions.asm"





find_bios_string:
  mov bx, 0
  ; es is a segment register
  ;mov es, 0 (ERROR)
  mov es, bx ; can't move a direct value (must be from a register) es-> 0



  _search_loop:
    mov al, [es:bx]
    cmp al, 'B'
    jne _continue_search

    mov al, [es:bx+1] ; i have to change the data segment register for correct calculations
    cmp al, 'I'
    jne _continue_search

    mov al, [es:bx+2]
    cmp al, 'O'
    jne _continue_search

    mov al, [es:bx+3]
    cmp al, 'S'
    jne _continue_search

    mov dx, es
    call print_hex
    ;c000 << 4 -> c0000 + ;0x8383; ->0xc8383
    ; i got this instead of ;0x8383;-> 0x57a9
    mov dx, bx
    call print_hex

    jmp $

    _continue_search:

    inc bx ; 0xffff + 1 --> 0x0000 -> 0x1ffff
    cmp bx, 0
    je _inc_segment


    jmp _search_loop
    _inc_segment:
       ;add es, 0x10000 ; can't add to this register (CPU Limitations (16 bit mode))
       mov cx, es
       add cx, 0x1000 ;  0x1000 ->0x100000 (it gets shifted before adding)->0x11234
       mov es, cx
       jmp _search_loop


  ret






print_hex:
 push bx
 push si
 mov si, HEX_TEMPLATE

 mov bx, dx ; bx-> 0x1234
 shr bx, 12 ; bx ->  0x0001
 ;add bx, 48
 mov bx,[bx+HEXABET]
 mov [HEX_TEMPLATE+2] ,bl

 mov bx, dx ; bx-> 0x1234
 shr bx, 8 ; bx ->  0x0012
 and bx, 0x000f ; bx -> 0002
 ;add bx, 48
 mov bx,[bx+HEXABET]
 mov [HEX_TEMPLATE+3] ,bl

 mov bx, dx ; bx-> 0x1234
 shr bx, 4 ; bx ->  0x0123
 and bx, 0x000f ; bx -> 0003
 ;add bx, 48
 mov bx,[bx+HEXABET]
 mov [HEX_TEMPLATE+4] ,bl

 mov bx, dx ; bx-> 0x1234
 ;shr bx, 0 ; bx ->  0x1234
 and bx, 0x000f ; bx -> 0004
 ;add bx, 48
 mov bx,[bx+HEXABET]
 mov [HEX_TEMPLATE+5] ,bl

 call print_string
 pop si
 pop bx
 ret

HEX_TEMPLATE:
  db '0x???? ', 0
HEXABET:
  db '0123456789abcdef'

; Pad out the bootsector to 512 bytes with last 2 bytes as magic 'bootable' number.
times 510-($-$$) db 0
dw 0xaa55
