; GDT : global descritor table, which defines protected mode memory segments

gdt_start:

gdt_null: ; mandotary null descritor
  dd 0x0 ; dd -> define double word (4 bytes)
  dd 0x0

gdt_code: ; code segment descritor
  ; base=0x0, limit= 0xffff,
  ; 1st flags: (present)1 (privilege)00 (descritor type)1 -> 1001b
  ; type flags: (code)1 (conforming)0 (readable)1 (acceessed)0 -> 1010b
  ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 --> 1100b

  dw 0xffff ; Limit (bits 0-15)
  dw 0x0 ; Base (bits 0-15)
  db 0x0  ; Base (bits 16-23)
  db 10011010b ; 1st flags, type flags
  db 11001111b ; 2nd flags, Limit (bits 6-19)
  db 0x0 ; Base(bits 24-31)

gdt_data: ; data segment descritor
  ; Same as code segment except for the type flags
  ; Type flags : (code)0 (expand down)0 (writable)1 (acceessed)0 ->  0010b
  dw 0xffff ; Limit (bits 0-15)
  dw 0x0 ; Base (bits 0-15)
  db 0x0  ; Base (bits 16-23)
  db 10010010b ; 1st flags, type flags
  db 11001111b ; 2nd flags, Limit (bits 6-19)
  db 0x0 ; Base(bits 24-31)
gdt_end:
  ; The reason for putting a label at the end of the GDT is so we can have the assembler calculate the size of the GDT for the GDT descritor (below)
; GDT descritor: points to our descritor table and is passed to the CPU on the switch to protected mode, so it can find out GDT.
gdt_descriptor:
  dw gdt_end - gdt_start - 1 ; size of our GDT, always less one of the true size
  dd gdt_start ; Start address of our GDT
; Define some constants for the GDT segment descritor offsets, which are what segment registers must contain when in protected mode. For example, when we set DS = 0x10 in PM, the cPU know that we mean it to use the segment described at offset 0x10 (i.e. 16 bytes) in our GDT, which in case is the DATA segment (0x0-> NULL; 0x08 -> CODE; 0x10 -> DATA).

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
