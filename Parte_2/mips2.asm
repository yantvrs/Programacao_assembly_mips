.data

  #Definimos o intervalo que será utilizado
  a: .float 2.0
  b: .float 3.0
  
  
  #Definimos o maximo de 10 iterações
  maximo_de_it: .word 10
  
  #Definimos a tolerancia de 0.1
  tolerancia: .float 0.1
  

.text
main:
  lw $t0, maximo_de_it
  lwc1 $f1, a
  jal f
  mov.s $f2, $f0
  li $t1, 0
  mov.s $f3, $f1
  lwc1 $f4, b
  lwc1 $f5, tolerancia
  
  
#Definimos o método da bisseção que será utilizado
bisecao:
  add $t1, $t1, 1
  sub.s $f6, $f4, $f3
  li $t2, 2
  mtc1 $t2, $f7
  cvt.s.w $f7, $f7
  div.s $f6, $f6, $f7
  add.s $f1, $f3, $f6
  jal f
  mtc1 $zero, $f7
  cvt.s.w $f7, $f7
  c.eq.s $f0, $f7
  bc1f check_tol
  

#Definimos as regras para caso haja convergência
convergencia:
  li $v0, 4
  la $a0, root_found_message
  syscall
  li $v0, 2
  mov.s $f12, $f1
  syscall
  li $v0, 4
  la $a0, performed_iterations_message
  syscall
  li $v0, 1
  move $a0, $t1
  syscall
  li $v0, 10
  syscall

#Definimos para saber se a convergência foi alcançada
check_tol:
  c.lt.s $f6, $f5
  bc1t convergencia

  mul.s $f6, $f2, $f0
  c.lt.s $f7, $f6

  movt.s $f3, $f1
  movt.s $f2, $f0

  movf.s $f4, $f1
  bne $t0, $t1, bisecao

  la $a0, root_not_found
  li $v0, 4
  syscall
  li $v0, 10
  syscall
  
#Definimos a função
f:
  addi $sp, $sp, -8
  swc1 $f2, 0($sp)
  sw $t0, 4($sp)

  mul.s $f0, $f1, $f1
  mul.s $f0, $f0, $f1

  li $t0, 10
  mtc1 $t0, $f2
  cvt.s.w $f2, $f2

  sub.s $f0, $f0, $f2

  lwc1 $f2, 0($sp)
  lw $t0, 4($sp)
  addi $sp, $sp, 8
  jr $ra

  .data
  #Mostramos as mensagens no console
  root_not_found: .asciiz "Nenhuma raiz foi encontrada!"
  root_found_message: .asciiz "Raiz: "
  performed_iterations_message: .asciiz "\nNúmero de iterações: "