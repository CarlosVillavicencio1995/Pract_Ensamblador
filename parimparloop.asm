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
section .text
    global _start

_start:
    escritura msj, len_msj
    mov ecx, 5
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
    push eax
    add eax,'0'
    mov [num],eax
    escritura num, 2
    pop ebx
    mov al, bl
    mov bl, 2
    div bl
    call dividir
    pop ecx
    loop comp
    jmp salir

dividir:
    cmp ah, 0
    je espar
    jmp esimpar    
espar:
    escritura par, len_par
    ret 
esimpar:
    escritura impar, len_impar
    ret

salir:
    mov eax, 1
    int 80h 