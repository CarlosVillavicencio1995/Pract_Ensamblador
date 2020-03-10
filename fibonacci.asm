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
    msj1 db 'Ingrese numero de Fibonacci que quiere presentar'
    len_msj1 equ $-msj1

    coma db ' , '
    len_coma equ $-coma

    igual db ' = ' 
    len_igual equ $-igual 

    new_line db '',10
    len_new equ $-new_line

section .bss
    ab resb 2
    resp resb 2
    num resb 2
section .text
    global _start

_start:
    escritura msj1, len_msj1
    lectura num
    mov cx, [num]
    sub cx, '0'
    mov ax, 0
    mov bx, 0
    mov dx, 1
fib:
    push cx
    mov ax, bx
    mov bx, dx
    add dx, ax
    push ax
    push bx
    push dx
    mov cl, 10
    div cl
    add ax,'00'
    mov [resp], ax
    escritura resp, 2
    escritura new_line,len_new
    pop dx
    pop bx
    pop ax 
    pop cx
    dec cx
    cmp cx, 0
    jnz fib
    jz salir
salir:
    mov eax, 1
    int 80h 