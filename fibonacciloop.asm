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
    msj1 db 'Ingrese numero de Fibonacci que quiere presentar :'
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
    mov ecx, [num]
    sub ecx, '0'
    mov eax, 0
    mov ebx, 0
    mov edx, 1
fib:
    push ecx
    mov eax, ebx
    mov ebx, edx
    add edx, eax
    push eax
    push ebx
    push edx
    mov cl, 10
    div cl
    add eax,'00'
    mov [resp], eax
    call presentar
    pop edx
    pop ebx
    pop eax 
    pop ecx
    loop fib
    jmp salir
salir:
    mov eax, 1
    int 80h 
presentar:
    escritura resp, 2
    escritura new_line,len_new
    ret