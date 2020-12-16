[bits 32]

VIDEO_MEMORY equ 0xb85A0
WHITE_ON_BLACK equ 0x0f

print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY

print_string_pm_loop:
  mov al, [esi]
  mov ah, WHITE_ON_BLACK

  cmp al, 0
  je print_string_pm_done

  mov [edx], ax
  add esi, 1
  add edx, 2
  jmp print_string_pm_loop

print_string_pm_done:
  popa
  ret
[bits 16]
