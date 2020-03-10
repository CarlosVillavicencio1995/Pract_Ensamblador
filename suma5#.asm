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
    mov edx, 2
    int 80h
%endmacro
section .data 
    msj db 'Ingrese 5 numeros :'
    len_msj equ $-msj
    par db ' <- Es numero par',10
    len_par equ $-par
    impar db ' <- Es numero impar',10
    len_impar equ $-impar
section .bss
    num resb 2
    suma resb 2
section .text
    global _start

_start:
    escritura msj, len_msj
    mov ecx, 5
    mov eax, 0
    mov [suma], eax
leer:
    push ecx
    lectura num
    pop ecx

    mov al, [num]
    sub al, '0'
    push eax
    loop leer   
    mov ecx, 5
comp:
    pop eax
    push ecx
    call sumando
    pop ecx
    loop comp
    jmp presentar

sumando:
    mov ebx, [suma]
    add eax, ebx
    mov [suma], eax 
    ret

presentar:
    mov al,[suma]
    mov cl, 10
    div cl
    add eax, '00'
    mov [suma], eax
    escritura suma,2
salir:
    mov eax, 1
    int 80h 