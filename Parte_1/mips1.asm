.data
sinal: .word 9, 5, 7, 5, 3, 4, 0, 2, 6, 4, 2, 5, 4, 1, 2, 1, 6, 2, 2, 3, 6, 3, 0, 0, 7, 8, 3, 4, 5, 4, 0, 5, 2, 9, 8, 7
histograma: .space 40
virgula: .asciiz ", "
nova_linha: .asciiz "\n"

.text
.globl main
main:
    li $s0, 0         
    la $s1, histograma   
    li $s2, 36        
    la $s3, sinal     

histogramaFunc:
    lw $s4, ($s3)     
    sll $s4, $s4, 2   
    add $s5, $s1, $s4  
    lw $t0, ($s5)     
    addiu $t0, $t0, 1   
    sw $t0, ($s5)     
    addiu $s3, $s3, 4   
    addiu $s0, $s0, 1   
    bne $s0, $s2, histogramaFunc   

    li $s0, 0         
    li $s2, 10        

mostrar:
    li $v0, 1         
    lw $a0, ($s1)     
    syscall          

    addiu $s1, $s1, 4   
    addiu $s0, $s0, 1

    li $v0, 4
    beq $s0, $s2, imprimir_linha
    la $a0, virgula
    syscall

    j mostrar
    
imprimir_linha:
    li $v0, 4
    la $a0, nova_linha
    syscall          

    li $v0, 10        
    syscall           
