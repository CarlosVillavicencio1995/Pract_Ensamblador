%macro escritura 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 80h
%endmacro
%macro lectura 2
mov eax, 3
mov ebx, 2
mov ecx, %1
mov edx, %2
int 80h
%endmacro

section .data
    msj db "Ingrese numero 1:", 10
    len_msj equ $ - msj

    msj2 db "Ingrese numero 2:", 10
    len_msj2 equ $ - msj2

    msj3 db "Ingrese numero 3:", 10
    len_msj3 equ $ - msj3

    msj4 db "son iguales", 10
    len_msj4 equ $ - msj4

    msj5 db "no son iguales", 10
    len_msj5 equ $ - msj5

section .bss

    num1: resb 1
    num2: resb 1
    num3: resb 1
    
section .text
    global _start:

_start:
;--------------- LEE NUMERO 1 -------------

    escritura msj, len_msj
    lectura num1, 2

;--------------- LEE NUMERO 2 -------------

    escritura msj2, len_msj2
    lectura num2, 2

;--------------- LEE NUMERO 3 -------------

    escritura msj3, len_msj3
    lectura num3, 2

;--------------- DESARROLLO

    mov al, [num1]
    mov bl, [num2]
    mov cl, [num3]
    
    sub al, '0'
    sub bl, '0'
    sub cl, '0'
    
    add al, bl 
    
    add al, '0'
    add bl, '0'
    add cl, '0'
    
    cmp al, cl
    je iguales
    jmp comp2 

iguales:
    escritura msj4, len_msj4
    jmp salir;

comp2:
    mov al, [num1]
    mov bl, [num2]
    mov cl, [num3]
    
    sub al, '0'
    sub bl, '0'
    sub cl, '0'
    
    add al, cl 
    
    add al, '0'
    add bl, '0'
    add cl, '0'
    
    cmp al, bl
    je iguales
    jmp comp3

comp3:
    mov al, [num1]
    mov bl, [num2]
    mov cl, [num3]
    
    sub al, '0'
    sub bl, '0'
    sub cl, '0'
    
    add bl, cl 
    
    add al, '0'
    add bl, '0'
    add cl, '0'
    
    cmp bl, al
    je iguales

    escritura msj5, len_msj5
    jmp salir 

salir:
 mov eax, 1
 int 80h