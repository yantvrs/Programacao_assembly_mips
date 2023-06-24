# 🌟 Programação Assembly para Arquitetura MIPS (operações com ponto flutuante) 🖥️

Este repositório contém um programa em assembly para a arquitetura MIPS que implementa o método da bisseção para encontrar a raiz positiva da equação f(x) = x^3 - 10. O programa utiliza operações com ponto flutuante para realizar os cálculos necessários.

## Detalhes da disciplina 📚

- Disciplina: DCA0104 – Arquitetura de Computadores
- Turmas: 01 (35T34) e 02 (46M34), 2023.1
- Professor: Diogo Pinheiro Fernandes Pedrosa

## Contextualização e Problema 🧐

Em diversos problemas de ciências e engenharia, é necessário encontrar as raízes de uma equação. Para isso, o método da bisseção é frequentemente utilizado. Neste problema específico, deseja-se encontrar a raiz positiva da equação f(x) = x^3 - 10.

## Método da Bisseção 📉

O método da bisseção é um procedimento numérico utilizado para determinar as raízes de uma equação. Ele consiste em reduzir gradativamente um intervalo [a, b], até uma determinada tolerância, e testar o valor intermediário do novo intervalo para determinar se ele está próximo da raiz desejada.

O algoritmo do método da bisseção pode ser resumido da seguinte forma:

1. Defina os pontos extremos a e b, a tolerância TOL e o número máximo de iterações N.
2. Inicialize i = 1 e calcule FA = f(a).
3. Enquanto i ≤ N, faça:
   - Calcule p = a + (b - a)/2.
   - Calcule FP = f(p).
   - Se FP = 0 ou (b - a)/2 < TOL, então:
     - Exiba p.
     - Pare o algoritmo.
   - Incremente i.
   - Se FA * FP > 0, então:
     - Atualize a = p e FA = FP.
     - Senão, atualize b = p.
4. Exiba a mensagem "Raiz não encontrada!".

## Resolvendo o problema 💡

Para encontrar a raiz positiva da equação f(x) = x^3 - 10 pelo método da bisseção, com uma tolerância de 0,1, máximo de 10 iterações e intervalo de busca igual a [2.0, 3.0], o programa em assembly realiza os cálculos necessários utilizando operações com ponto flutuante.

## Executando o programa ▶️

Para executar o programa, utilize um simulador MIPS compatível, como MARS ou QtSPIM. Carregue o código assembly fornecido e execute-o no simulador. A saída exibirá a raiz aproximada encontrada ou a mensagem "Raiz não encontrada!" caso a solução não seja encontrada dentro do número máximo de iterações.

## Observação 📝

Certifique-se de configurar corretamente o ambiente de simulação MIPS e de fornecer os valores adequados para os parâmetros do método da bisseção no código assembly, conforme especificado no enunciado do problema.