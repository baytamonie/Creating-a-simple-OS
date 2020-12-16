[bits 16] ; Instruct nasm to output 16-bit opcodes.

; Include our global descritor table structure.
%include "gdt.asm"

;switch to protected mode.

switch_to_pm:

  cli    ; We must switch off interrupts until we have set-up the protected mode interrupt vector, otherwise interrupts will run amuck.

  lgdt [gdt_descriptor]   ; Load our golbal descriptor table, which defines the protected mode segments.


  mov eax, cr0    ; To make the switch to protected mode, we set the first bit of CR0, a special CPU control register.
  or eax, 0x1
  mov cr0, eax

  jmp CODE_SEG:init_pm  ; Make a far jump to our 32-bit code. This also forces the CPU to flush its cache of pre-fetched and real-mdoe decoded instructions, which can cause problems for certain processors.

[bits 32] ; Instruct nasm to output 32-bit opcodes.

; Initialise registers and the stack once in PM.
init_pm:

  ; Now in PM, our old segments are meaningless, so we point our segment registers to the data selector we defined in our GDT.

  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  ; Update our stack position so it is right at the top of the free space.

  mov ebp , 0x90000
  mov esp, ebp

  ; Finally, call osme well-know label, where general 32-bit code may take over to boot the 32-bit OS.

  call BEGIN_PM


[bits 16] ; Instruct nasm to output 16-bit opcodes
