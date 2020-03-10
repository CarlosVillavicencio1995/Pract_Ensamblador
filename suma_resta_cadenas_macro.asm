%macro escribir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro
section .data
    mensaje db "la suma es = "
    len equ $- mensaje
    n1 db '3277'
    n2 db '2566'
    suma db '     '
    len_suma equ $- suma

    resta db '     '
    len_resta equ $- resta

    espacio db " "
    len_e equ $- espacio

section .bss

section .txt
    global _start

_start:
    mov ecx, 4  ; numero de digitos de cada operando
    mov esi, 3  ; index source
    clc         ; permite poner la bandera del carry en 0 o desactivar el carry

ciclo_suma: 
    mov al, [n1 + esi] ; al ser cadena se empieza con 0
    adc al, [n2 + esi] ; 7+6+acarreo
    aaa                ; suma Al 6 y AH suma el acarreo se aplica despues de una suma 
                       ; con acarreo y suma el contenido del abandera de el carry 
                       ; al primer operando y despues al segundo
    pushf              ; guarda estado de todas las banderas

    or al, 30h         ; es similar a sub al,'0'

    popf               ; restaura el estado de las banderas

    mov [suma + esi], al 
    dec esi
    loop ciclo_suma 

    escribir mensaje, len
    escribir suma, len_suma
    escribir espacio, len_e

    mov ecx, 4  ; numero de digitos de cada operando
    mov esi, 3  ; index source
    clc 

ciclo_resta: 
    mov al, [n1 + esi] ; al ser cadena se empieza con 0
    sbb al, [n2 + esi]
    aas                ; suma Al 6 y AH suma el acarreo se aplica despues de una suma 
                       ; con acarreo y suma el contenido del abandera de el carry 
                       ; al primer operando y despues al segundo
    pushf              ; guarda estado de todas las banderas

    or al, 30h         ; es similar a sub al,'0'

    popf               ; restaura el estado de las banderas

    mov [resta + esi], al 
    dec esi
    loop ciclo_resta

    escribir mensaje, len
    escribir resta, len_resta
    escribir espacio, len_e

    mov eax, 1
    int 80h