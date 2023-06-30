# Discente : Vinícius Yan Tavares Nascimento

.data
V: .word 9, 5, 7, 5, 3, 4, 0, 2, 6, 4, 2, 5, 4, 1, 2, 1, 6, 2, 2, 3, 6, 3, 0, 0, 7, 8, 3, 4, 5, 4, 0, 5, 2, 9, 8, 7
H: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
.globl main

main:
    # Calcula o tamanho do vetor V
    la $t0, V
    la $t1, H
    lw $t2, 0($t0)  # Carrega o primeiro elemento de V

count_loop:
    beq $t2, $zero, end_count  # Verifica se o elemento é zero
    sll $t3, $t2, 2  # Multiplica o valor por 4 para obter o offset de H
    add $t3, $t3, $t1  # Calcula o endereço de H[num]
    lw $t4, 0($t3)  # Carrega o valor atual de H[num]
    addiu $t4, $t4, 1  # Incrementa o valor de H[num]
    sw $t4, 0($t3)  # Armazena o novo valor de H[num]

end_count:
    addiu $t0, $t0, 4  # Avança para o próximo elemento de V
    lw $t2, 0($t0)  # Carrega o próximo elemento de V
    bnez $t2, count_loop  # Loop enquanto não for o final de V

    # Exibe os elementos do vetor H
    la $t0, H
    li $v0, 1  # Código de syscall para imprimir inteiro
    li $t1, 0  # Índice inicial do vetor H

print_loop:
    lw $a0, 0($t0)  # Carrega o elemento atual de H para ser impresso
    syscall
    addiu $t0, $t0, 4  # Avança para o próximo elemento de H
    addiu $t1, $t1, 1  # Incrementa o índice
    blez $a0, end_print  # Verifica se chegou ao final de H
    li $v0, 4  # Código de syscall para imprimir string
    la $a0, space  # Imprime um espaço entre os elementos
    syscall
    j print_loop

end_print:
    li $v0, 10  # Código de syscall para sair do programa
    syscall

.data
space: .asciiz " "
