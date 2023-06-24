# 📚 Descrição do Repositório

Este repositório contém dois projetos relacionados à disciplina de Arquitetura de Computadores (DCA0104) ministrada pelo professor Diogo Pinheiro Fernandes Pedrosa. Os projetos são divididos em duas partes:

## Parte 1: Conjunto de Instruções da Arquitetura MIPS (operações com valores inteiros)

O primeiro projeto aborda a implementação de um programa em assembly para a arquitetura MIPS. O objetivo é calcular o histograma de um vetor de amostras de sinal, representando a contagem de ocorrências de cada intensidade presente no vetor.

O programa utiliza operações com valores inteiros e segue o seguinte algoritmo:

1. Declaração de variáveis e constantes: Lmax (número máximo de intensidades) e TAM (tamanho do vetor).
2. Inicialização do vetor H: define todos os elementos como zero.
3. Cálculo do histograma: percorre o vetor de amostras e incrementa o valor correspondente no vetor H.
4. Exibição do vetor H utilizando chamada de sistema (syscall).

O programa deve ser testado em um simulador MIPS, como MARS ou QtSPIM.

## Parte 2: Programação Assembly para Arquitetura MIPS (operações com ponto flutuante)

O segundo projeto aborda a aplicação do método da bisseção para encontrar a raiz positiva de uma equação. O programa em assembly para a arquitetura MIPS implementa esse método e realiza o cálculo da raiz aproximada.

O método da bisseção consiste em reduzir gradativamente um intervalo [a, b], até uma determinada tolerância, e testar o valor intermediário para verificar se ele está próximo da raiz desejada.

O programa segue o algoritmo do método da bisseção e recebe como entrada os seguintes parâmetros: pontos extremos a e b, tolerância TOL, número máximo de iterações N.

A saída do programa exibirá a solução aproximada p ou a mensagem "Raiz não encontrada!" caso a solução não seja encontrada dentro do número máximo de iterações.

Neste projeto, a equação utilizada é f(x) = x^3 - 10, a raiz positiva deve ser encontrada com uma tolerância de 0,1, máximo de 10 iterações e intervalo de busca igual a [2.0, 3.0].

O programa também deve ser testado em um simulador MIPS, como MARS ou QtSPIM.

