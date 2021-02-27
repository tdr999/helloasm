section .data
msg1: db 'buna seara, doamnelor si domnilor', 10
lenMsg1: equ $-msg1
; lungimea mesajului e 'adresa liniei curente-adresa de inceput 
; a mesajului, aka labelul mesajului
msg2: db 'In seara aceasta o sa ciclam intre aceste mesaje', 10
lenMsg2: equ $-msg2

section .bss

section .text

global _start

_start:
    nop
    mov ecx, 4
compara:
    cmp ecx, 2
    jge print
    mov eax, 4 ; write sys call, parametrii de aici
    mov ebx, 1
    mov ecx, msg2
    mov edx, lenMsg2
    int 80h
    jmp quit

print:
    push ecx ;salvam in stack valoarea din ecx care e folosit cunter
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, lenMsg1
    int 80h
    pop ecx ;intoarcem valoarea dupa folosirea ecx ptr sys call
    sub ecx, 1 ;scadem cu 1 ecx ca sa nu loop infinit
    jmp compara

quit:
    mov eax, 1 ; quit syscall
    mov ebx, 0
    int 80h
;compile with
;nasm -f elf hello.asm
;ld -m elf_i386 hello.o -o hello
