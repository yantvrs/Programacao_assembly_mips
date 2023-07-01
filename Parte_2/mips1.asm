section .data
    a dd 2.0
    b dd 3.0
    TOL dd 0.1
    N dd 10

section .text
    global _start
_start:
    mov ecx, 1

    fld dword [a]
    fmul dword [a]
    fstp dword [FA]

loop_start:
    fld dword [a]
    fadd dword [b]
    fdiv dword 2.0
    fstp dword [p]

    fld dword [p]
    fmul dword [p]
    fmul dword [p]
    fsub dword 10.0
    fstp dword [FP]

    fld dword [FP]
    fcom dword 0.0
    je found_root
    fld dword [b]
    fld dword [a]
    fsub dword [b]
    fdiv dword 2.0
    fcomp dword [TOL]
    jb found_root
    cmp ecx, dword [N]
    jg not_found_root

    fld dword [FA]
    fmul dword [FP]
    fldz
    fucomip st(1), st(0)
    fstp st(0)
    jae update_b
    mov eax, dword [p]
    mov dword [a], eax
    fstp dword [FA]
    jmp loop_start

update_b:
    mov eax, dword [p]
    mov dword [b], eax
    fstp dword [FA]
    jmp loop_start

found_root:
    fld dword [p]
    call print_float
    jmp exit

not_found_root:
    mov edx, message_not_found
    call print_string
    jmp exit

print_string:
    mov eax, 4
    mov ebx, 1
    mov ecx, edx
    mov edx, 20
    int 0x80
    ret

print_float:
    sub esp, 8
    fstp qword [esp]
    mov eax, 2
    mov ebx, 1
    lea ecx, [esp]
    mov edx, 8
    int 0x80
    add esp, 8
    ret

