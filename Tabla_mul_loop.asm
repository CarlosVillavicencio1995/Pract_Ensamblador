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
    mov ecx, 9

multiplicar:

    mov al, [num] 
    sub al, '0'
    push ecx

    mul cl
    mov bl, 10
    div bl
;    add bl,'0'
    add ax,'00'
    mov [resp], ax
    mov ax, cx
    div bl
    add ax,'00'
    mov [pila], ax 
    call presentar
    pop ecx
    loop multiplicar
    jmp salir
presentar:
    escritura num,1
    escritura multiplicado, len_multplicado
    escritura pila, 2
    escritura igual, len_igual
    escritura resp, 2
    escritura new_line, len_new
    ret

salir:
    mov eax, 1
    int 80h 