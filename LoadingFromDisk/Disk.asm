[org 0x7c00]

mov bp, 0xffff
mov sp, bp

call read_from_disk

mov si, MY_MESSAGE
call print_string
jmp $

%include "/home/bayta/Documents/OS/Creating-a-simple-OS/functions/functions.asm"
 read_from_disk:
  mov ah, 0x02 ; Read sectors from drive.
  mov al, 1 ; number of sectors to read.
  mov ch, 0 ; select first cylinder (tracks).
  mov dh, 0 ; select first read/write head.
  mov cl, 2; select 2nd sector (1st sector is the boot sector).

  mov bx, 0
  mov es, bx ; es ->0  we're not applying the segment modification to the 16 bit address in bx and we're not going to load i thigher than this .
  mov bx, 0x7c00 + 512

  int 0x13
  jc read_error ; Jump to error message if carry flag set (by BIOS)
  ret
read_error:
   mov si, DISK_ERROR
   call print_string
   jmp $

DISK_ERROR:
   db 'Error reading disk!' , 0

times 510-($-$$) db 0
dw 0xaa55

MY_MESSAGE:
  db 'Am I loaded in memory yet?', 0

  ;times 512 db 0  (sometimes the emulator wants the sector to be full)
