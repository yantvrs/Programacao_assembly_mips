# Identificação: [Vínicius Yan Tavares Nascimento]

.data
V: .word 9, 5, 7, 5, 3, 4, 0, 2, 6, 4, 2, 5, 4, 1, 2, 1, 6, 2, 2, 3, 6, 3, 0, 0, 7, 8, 3, 4, 5, 4, 0, 5, 2, 9, 8, 7
H: .word 0:10

.text
.globl main

main:
    li $t0, 36          # Número total de elementos no vetor V
    li $t1, 10          # Número máximo de intensidades (0 a 9)
    la $s0, V           # Endereço base do vetor V
    la $s1, H           # Endereço base do vetor H

    # Inicializa o vetor H com zeros
    li $t2, 0
    li $t3, 0
init_loop:
    sw $t2, ($s1)
    addiu $s1, $s1, 4
    addiu $t3, $t3, 1
    bne $t3, $t1, init_loop

    # Calcula o histograma
    move $s1, $s0      # Reinicia o endereço base do vetor V
calc_loop:
    lw $t2, ($s1)      # Carrega o valor atual de V[i]
    add $t3, $t2, $t1  # Calcula o deslocamento para o índice de H
    sll $t3, $t3, 2    # Multiplica por 4 para converter em bytes (cada elemento de H é um word)
    add $t3, $t3, $s1  # Adiciona o deslocamento ao endereço base do vetor H
    lw $t4, ($t3)      # Carrega o valor atual de H[V[i]]
    addiu $t4, $t4, 1  # Incrementa o valor
    sw $t4, ($t3)      # Armazena o novo valor em H[V[i]]

    addiu $s1, $s1, 4  # Incrementa o endereço de V
    addiu $t0, $t0, -1 # Decrementa o contador
    bnez $t0, calc_loop

    # Exibe os elementos obtidos no vetor H
    la $s1, H
    li $v0, 4          # Código da syscall para imprimir string
print_loop:
    lw $a0, ($s1)
    li $v0, 1          # Código da syscall para imprimir inteiro
    syscall
    addiu $s1, $s1, 4
    addiu $t0, $t0, -1
    bnez $t0, print_loop

    li $v0, 10         # Código da syscall para encerrar o programa
    syscall
