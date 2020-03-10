%macro presentar 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 80H
%endmacro
%macro ingresar 1
mov eax, 3
mov ebx, 2
mov ecx, %1
mov edx, 2
int 80H
%endmacro

section .data
    msj_ingrese db 'ingrese num1', 10
    leng_ingrese equ $ - msj_ingrese

    msj_ingrese2 db 'ingrese num2', 10
    leng_ingrese2 equ $ - msj_ingrese2

    msj_positivo db 'es positivo', 10
    leng_positivo equ $ - msj_positivo
    msj_negativo db 'es negativo', 10
    leng_negativo equ $ - msj_negativo    
section .bss
    num1:		resb	2
	num2:		resb	2
section .text

    global _start:
_start:
    
    presentar msj_ingrese, leng_ingrese
    ingresar num1

    presentar msj_ingrese2, leng_ingrese2
    ingresar num2

    mov al,[num1] 
    mov bl, [num2]
    sub al, '0'
    sub bl, '0'
    sub al, bl
    js negativo
    jmp positivo
positivo:
    presentar msj_positivo, leng_positivo
    jmp salir

negativo:
    presentar msj_negativo, leng_negativo
    jmp salir
salir:
    mov eax, 1
    int 80h    