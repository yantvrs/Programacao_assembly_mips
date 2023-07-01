.data

vector: .word 9,5,7,5,3,4,0,2,6,4,2,5,4,1,2,1,6,2,2,3,6,3,0,0,7,8,3,4,5,4,0,5,2,9,8,7
histogram: .space 50
new_line: .asciiz "\n"
comma: .asciiz ","


.text
.globl main

main:
    li $s0, 0         # contador do loop
    la $s1, histogram   # endereço do histograma
    li $s2, 36        # tamanho do sinal
    la $s3, vector     # endereço do sinal

histogramFunc:
    lw $s4, ($s3)     # carrega o valor do sinal
    sll $s4, $s4, 2   # multiplica o valor por 4
    add $s5, $s1, $s4   # calcula o endereço correspondente no histograma
    lw $t0, ($s5)     # carrega o valor atual do histograma
    addiu $t0, $t0, 1   # incrementa o valor
    sw $t0, ($s5)     # armazena o novo valor no histograma
    addiu $s3, $s3, 4   # avança para o próximo valor do sinal
    addiu $s0, $s0, 1   # incrementa o contador
    bne $s0, $s2, histogramFunc   # verifica se o contador chegou ao fim

    li $s0, 0         # reinicia o contador
    li $s2, 10        # número de elementos para mostrar

mostrar:
    li $v0, 1         # código da syscall para impressão de um inteiro
    lw $a0, ($s1)     # carrega o valor do histograma
    syscall           # imprime o valor

    addiu $s1, $s1, 4   # avança para o próximo valor do histograma
    addiu $s0, $s0, 1   # incrementa o contador

    li $v0, 4         # código da syscall para impressão de uma string
    beq $s0, $s2, imprimir_linha   # verifica se todos os elementos foram mostrados
    la $a0, comma   # carrega o endereço da vírgula
    syscall           # imprime a vírgula

    j mostrar         # volta para o início do loop

imprimir_linha:
    li $v0, 4         # código da syscall para impressão de uma string
    la $a0, new_line   # carrega o endereço da nova linha
    syscall           # imprime a nova linha

    li $v0, 10        # código da syscall para finalizar o programa
    syscall           # finaliza o programa
