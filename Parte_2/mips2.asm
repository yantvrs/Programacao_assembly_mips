.data
  # Definimos o intervalo que será utilizado
  interval_start: .float 2.0
  interval_end: .float 3.0
  
  # Mostramos as mensagens no console
  root_not_found_message: .asciiz "Nenhuma raiz foi encontrada!"
  root_found_message: .asciiz "Raiz: "
  performed_iterations_message: .asciiz "\nNúmero de iterações: "
  
  # Definimos o máximo de 10 iterações
  max_iterations: .word 10
  
  # Definimos a tolerância de 0.1
  tolerance: .float 0.1

.text
main:
  lw $t0, max_iterations   # Carrega o valor máximo de iterações
  lwc1 $f1, interval_start # Carrega o valor do início do intervalo para $f1
  jal f                    # Chama a função 'f'
  mov.s $f2, $f0           # Move o resultado de 'f' para $f2
  li $t1, 0                # Inicializa o contador de iterações em 0
  mov.s $f3, $f1           # Copia o valor do início do intervalo para $f3
  lwc1 $f4, interval_end   # Carrega o valor do fim do intervalo para $f4
  lwc1 $f5, tolerance      # Carrega o valor da tolerância para $f5

  # Chama a função 'bisecao'
  jal bisecao

  # Fim do programa
  li $v0, 10
  syscall

# Função de bissecção
bisecao:
  bisecao_loop:
    add $t1, $t1, 1        # Incrementa o contador de iterações
    sub.s $f6, $f4, $f3    # Calcula o intervalo (fim - início) e armazena em $f6
    li $t2, 2              # Carrega o valor 2 para $t2
    mtc1 $t2, $f7          # Move o valor de $t2 para $f7
    cvt.s.w $f7, $f7       # Converte o valor em $f7 para ponto flutuante
    div.s $f6, $f6, $f7    # Divide $f6 por 2
    add.s $f1, $f3, $f6    # Calcula o novo ponto médio e armazena em $f1
    jal f                  # Chama a função 'f'
    mtc1 $zero, $f7        # Move 0 para $f7
    cvt.s.w $f7, $f7       # Converte 0 para ponto flutuante
    c.eq.s $f0, $f7        # Compara o resultado de 'f' com 0
    bc1f check_tol         # Se não for igual a 0, vai para 'check_tol'
    j bisecao_loop         # Se for igual a 0, volta para 'bisecao_loop'

check_tol:
  c.lt.s $f6, $f5          # Compara o intervalo com a tolerância
  bc1t convergencia        # Se for menor, vai para 'convergencia'

  mul.s $f6, $f2, $f0      # Multiplica f(início) e f(ponto médio) e armazena em $f6
  c.lt.s $f7, $f6          # Compara 0 com o resultado da multiplicação
  movt.s $f3, $f1          # Se o resultado for maior que 0, move o novo ponto médio para $f3
  movt.s $f2, $f0          # Se o resultado for maior que 0, move o resultado de 'f' para $f2

  movf.s $f4, $f1          # Move o novo ponto médio para $f4

  bne $t0, $t1, bisecao_loop  # Se o número máximo de iterações não foi atingido, volta para 'bisecao_loop'

  la $a0, root_not_found_message  # Carrega o endereço da mensagem 'root_not_found' para $a0
  li $v0, 4               # Carrega o código da syscall para imprimir string para $v0
  syscall                 # Imprime a mensagem
  j exit_program          # Vai para o fim do programa

convergencia:
  jal print_root_found_message             # Chama a função para imprimir a mensagem de raiz encontrada
  jal print_root_value                     # Chama a função para imprimir o valor da raiz
  jal print_performed_iterations_message   # Chama a função para imprimir a mensagem de número de iterações
  jal print_iteration_count                # Chama a função para imprimir o contador de iterações
  j exit_program                           # Salta para o fim do programa

print_root_found_message:
  li $v0, 4                               # Carrega o código da syscall para imprimir string para $v0
  la $a0, root_found_message               # Carrega o endereço da mensagem 'root_found_message' para $a0
  syscall                                 # Imprime a mensagem
  jr $ra                                  # Retorna para o chamador

print_root_value:
  li $v0, 2                               # Carrega o código da syscall para imprimir um número em ponto flutuante para $v0
  mov.s $f12, $f1                         # Move o valor da raiz ($f1) para o registrador apropriado ($f12)
  syscall                                 # Imprime o valor da raiz
  jr $ra                                  # Retorna para o chamador

print_performed_iterations_message:
  li $v0, 4                               # Carrega o código da syscall para imprimir string para $v0
  la $a0, performed_iterations_message     # Carrega o endereço da mensagem 'performed_iterations_message' para $a0
  syscall                                 # Imprime a mensagem
  jr $ra                                  # Retorna para o chamador

print_iteration_count:
  li $v0, 1                               # Carrega o código da syscall para imprimir um inteiro para $v0
  move $a0, $t1                           # Move o contador de iterações ($t1) para o registrador apropriado ($a0)
  syscall                                 # Imprime o contador de iterações
  jr $ra                                  # Retorna para o chamador

exit_program:
  li $v0, 10                              # Carrega o código da syscall para encerrar o programa para $v0
  syscall                                 # Encerra o programa

# Função 'f'
f:
  addi $sp, $sp, -8       # Cria espaço na pilha
  swc1 $f2, 0($sp)        # Salva o valor de $f2 na pilha
  sw $t0, 4($sp)          # Salva o valor de $t0 na pilha

  mul.s $f0, $f1, $f1     # Calcula f(x) = x^3
  mul.s $f0, $f0, $f1
  li $t0, 10              # Carrega o valor 10 para $t0
  mtc1 $t0, $f2           # Move o valor de $t0 para $f2
  cvt.s.w $f2, $f2        # Converte o valor em $f2 para ponto flutuante
  sub.s $f0, $f0, $f2     # Calcula f(x) - 10

  lwc1 $f2, 0($sp)        # Restaura o valor de $f2 da pilha
  lw $t0, 4($sp)          # Restaura o valor de $t0 da pilha
  addi $sp, $sp, 8        # Libera o espaço da pilha
  jr $ra                  # Retorna para o chamador
