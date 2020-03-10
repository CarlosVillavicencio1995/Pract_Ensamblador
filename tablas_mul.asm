%macro escritura 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
 int 80h
%endmacro
%macro lectura 1
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, 1
    int 80h
%endmacro
section .data 
    msj1 db 'Ingrese numero '
    len_msj1 equ $-msj1

    multiplicado db ' * '
    len_multplicado equ $-multiplicado

    igual db ' = ' 
    len_igual equ $-igual 

    new_line db '',10
    len_new equ $-new_line

section .bss
    num resb 2
    resp resb 2
    pila resb 2
section .text
    global _start

_start:
    escritura msj1, len_msj1
    lectura num
    mov bl, 0
    jmp multiplicar
multiplicar:
    inc bl
    mov al, [num] 
    sub al, '0'
    push ebx
    mul bl
    mov cl, 10
    div cl
;    add bl,'0'
    add ax,'00'
    mov [resp], ax
    mov ax, bx
    div cl
    add ax,'00'
    mov [pila], ax
   
    escritura num, 2
    escritura multiplicado, len_multplicado
    escritura pila, 2
    escritura igual, len_igual
    escritura resp, 2
    escritura new_line, len_new
    pop ebx
    cmp bl, 12
    je salir
    jmp multiplicar

salir:
    mov eax, 1
    int 80h 