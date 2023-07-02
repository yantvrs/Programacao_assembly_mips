# Atividade assembly mips 1
# Discente: Vinícius Yan Tavares Nascimento
# Matrícula : 20200069226

.data
vector: .word 9,5,7,5,3,4,0,2,6,4,2,5,4,1,2,1,6,2,2,3,6,3,0,0,7,8,3,4,5,4,0,5,2,9,8,7
# Declara a variável "vector" como um vetor de palavras (inteiros de 32 bits)
# Os valores dentro do vetor são: 9, 5, 7, 5, 3, 4, 0, 2, 6, 4, 2, 5, 4, 1, 2, 1, 6, 2, 2, 3, 6, 3, 0, 0, 7, 8, 3, 4, 5, 4, 0, 5, 2, 9, 8, 7

histogram: .space 50
# Declara a variável "histogram" como uma área de espaço na memória de 50 bytes.
# Essa área será usada para armazenar o histograma.

new_line: .asciiz "\n"
# Declara a sequência de caracteres "\n" e a atribui à variável "new_line".
# Essa sequência representa uma nova linha.

comma: .asciiz ","
# Declara a sequência de caracteres "," e a atribui à variável "comma".
# Essa sequência representa uma vírgula.

prompt: .asciiz "H ["
# Declara a sequência de caracteres "H [" e a atribui à variável "prompt".
# Essa sequência será usada como cabeçalho ao imprimir o histograma.

closing_bracket: .asciiz "]"
# Declara a sequência de caracteres "]" e a atribui à variável "closing_bracket".
# Essa sequência será usada como fechamento ao imprimir o histograma.

.text
.globl main

main:
    li $s0, 0          	# Inicializa o registrador $s0 (contador do loop) com o valor 0
    la $s1, histogram	# Carrega o endereço da variável "histogram" para o registrador $s1
    li $s2, 36        	# Inicializa o registrador $s2 com o valor 36 (tamanho do sinal)
    la $s3, vector    	# Carrega o endereço da variável "vector" para o registrador $s3

    jal histogramFunc   # Chama a função histogramFunc

    # Adiciona o cabeçalho "H [" antes de mostrar os elementos
    li $v0, 4         		# Carrega o código da syscall para impressão de uma string para o registrador $v0
    la $a0, prompt     		# Carrega o endereço do cabeçalho para o registrador $a0
    syscall           		# Chama a syscall para imprimir o cabeçalho

    jal show            	# Chama a função show

    li $v0, 10         		# Carrega o código da syscall para finalizar o programa para o registrador $v0
    syscall            		# Chama a syscall para finalizar o programa

# Função histogramFunc
histogramFunc:
    lw $s4, ($s3)     			# Carrega o valor do sinal para o registrador $s4
    sll $s4, $s4, 2   			# Multiplica o valor por 4 (shift left logical)
    add $s5, $s1, $s4   		# Calcula o endereço correspondente no histograma
    lw $t0, ($s5)     			# Carrega o valor atual do histograma para o registrador $t0
    addiu $t0, $t0, 1   		# Incrementa o valor do histograma em 1
    sw $t0, ($s5)     			# Armazena o novo valor no histograma
    addiu $s3, $s3, 4   		# Avança para o próximo valor do sinal
    addiu $s0, $s0, 1   		# Incrementa o contador do loop em 1
    bne $s0, $s2, histogramFunc   	# Verifica se o contador chegou ao fim e, se não, salta para "histogramFunc"
    li $s0, 0         			# Reinicia o contador do loop com o valor 0
    li $s2, 10       			# Define o número de elementos a serem mostrados
    jr $ra              		# Retorna para a função chamadora

# Função show
show:
    li $s0, 0          	# Inicializa o registrador $s0 (contador do loop) com o valor 0

show_loop:
    li $v0, 1         		# Carrega o código da syscall para impressão de um inteiro para o registrador $v0
    lw $a0, ($s1)     		# Carrega o valor do histograma para o registrador $a0
    syscall           		# Chama a syscall para imprimir o valor do histograma
    addiu $s1, $s1, 4   	# Avança para o próximo valor do histograma
    addiu $s0, $s0, 1   	# Incrementa o contador do loop em 1
    beq $s0, $s2, show_line  	# Verifica se todos os elementos foram mostrados e, se sim, salta para "show_line"

    li $v0, 4         		# Carrega o código da syscall para impressão de uma string para o registrador $v0
    la $a0, comma   		# Carrega o endereço da vírgula para o registrador $a0
    syscall           		# Chama a syscall para imprimir a vírgula
    j show_loop         	# Salta para o início do loop em "show_loop"

show_line:
    # Adiciona o fechamento "]"
    li $v0, 4         	       	# Carrega o código da syscall para impressão de uma string para o registrador $v0
    la $a0, closing_bracket  	# Carrega o endereço do fechamento para o registrador $a0
    syscall           			# Chama a syscall para imprimir o fechamento
    li $v0, 4         			# Carrega o código da syscall para impressão de uma string para o registrador $v0
    la $a0, new_line  			# Carrega o endereço da nova linha para o registrador $a0
    syscall           			# Chama a syscall para imprimir a nova linha
    jr $ra              		# Retorna para a função chamadora

