.data
    V: .word 9, 5, 7, 5, 3, 4, 0, 2, 6, 4, 2, 5, 4, 1, 2, 1, 6, 2, 2, 3, 6, 3, 0, 0, 7, 8, 3, 4, 5, 4, 0, 5, 2, 9, 8, 7
    H: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
    .globl main

main:
    la $t0, V                # Carrega o endereço do vetor V em $t0
    la $t1, H                # Carrega o endereço do vetor H em $t1
    li $t2, 10               # Define o número máximo de intensidades como 10
    li $t3, 0                # Inicializa o contador do loop externo em 0

init_histogram:
    beq $t3, $t2, count_histogram   # Se o contador do loop externo for igual ao número máximo de intensidades, vai para a contagem do histograma

    sw $zero, ($t1)          # Inicializa o elemento atual do vetor H com 0

    addi $t1, $t1, 4        # Avança para o próximo elemento no vetor H
    addi $t3, $t3, 1        # Incrementa o contador do loop externo
    j init_histogram

count_histogram:
    la $t0, V                # Carrega o endereço do vetor V em $t0
    li $t4, 36              # Define o tamanho do vetor V como 36
    li $t5, 0               # Inicializa o contador do loop interno em 0

count_loop:
    beq $t5, $t4, print_histogram   # Se o contador do loop interno for igual ao tamanho do vetor V, vai para a impressão do histograma

    lw $t6, 0($t0)           # Carrega o elemento atual do vetor V em $t6

    sll $t7, $t6, 2         # Multiplica o elemento por 4 (tamanho de uma word)
    add $t7, $t7, $t1        # Adiciona o offset do vetor H

    lw $t8, 0($t7)           # Carrega o valor atual do contador de ocorrências do número em $t8
    addi $t8, $t8, 1         # Incrementa o contador

    sw $t8, 0($t7)           # Armazena o valor atualizado do contador de ocorrências no vetor H

    addi $t0, $t0, 4         # Avança para o próximo elemento no vetor V
    addi $t5, $t5, 1         # Incrementa o contador do loop interno
    j count_loop

print_histogram:
    la $t1, H                # Carrega
    syscall
