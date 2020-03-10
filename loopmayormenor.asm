%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro leer 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data

    msj db 'Ingrese un numero: ',
    len equ $-msj

    msjP db 'El numero menor es: ',
    lenP equ $-msjP

    msjI db 'El numero mayor es: ',
    lenI equ $-msjI

    newLine db '',10

    espace db ' '

section .bss
    cont resb 2
    numero resb 2
    menor resb 2
    mayor resb 2
section .text
    global _start
_start:
    mov ecx, 5
pedirNumero:
    push ecx
    escribir msj, len
    leer numero, 2
    pop ecx

    mov eax, [numero]
    sub eax, '0'
    push eax

    loop pedirNumero

    mov ecx, 4
    
    pop eax
    mov [menor], eax
    mov [mayor], eax
bucleMenor:
    pop eax
    call compararMenor
    call compararMayor
    loop bucleMenor
    jmp  presentar

compararMenor:
    mov bl, [menor]
    cmp al, bl
    jb esMenor
    ret

esMenor:
    mov [menor], al
    ret

compararMayor:
    mov bl, [mayor]
    cmp al, bl
    jg esMayor
    ret

esMayor:
    mov [mayor], al
    ret

presentar:
    escribir newLine,1

    escribir msjP, lenP
    mov eax, [menor]
    add eax, '0'
    mov [menor], eax
    escribir menor, 1

    escribir newLine,1

    escribir msjI, lenI
    mov eax, [mayor]
    add eax, '0'
    mov [mayor], eax
    escribir mayor, 1

    escribir newLine,1
    escribir newLine,1
salir:
    mov eax, 1
    int 80h