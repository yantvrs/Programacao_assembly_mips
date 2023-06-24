## MIPS Assembly - Cálculo do Histograma

O código apresentado é um programa em linguagem assembly MIPS que realiza o cálculo do histograma de um vetor de amostras. O objetivo é contar o número de ocorrências de cada intensidade presente no vetor e armazenar essas contagens em um vetor de saída.

### Funcionamento

O programa inicia declarando os vetores `V` e `H` na seção de dados. O vetor `V` contém as amostras de intensidade, e o vetor `H` será utilizado para armazenar o histograma.

Na seção de texto, a função `main` é definida como o ponto de entrada do programa. Primeiramente, são definidos os registradores e endereços necessários para o processamento. O registrador `$t0` é usado para armazenar o número total de elementos no vetor `V` (36 no exemplo fornecido), enquanto `$t1` representa o número máximo de intensidades (0 a 9).

Em seguida, o programa inicializa o vetor `H` com zeros usando um loop. Os registradores `$t2` e `$t3` são usados para percorrer o vetor `H`, e a instrução `sw` é usada para armazenar o valor zero em cada posição de `H`.

Após a inicialização do vetor `H`, o programa entra em um loop para calcular o histograma. O endereço base do vetor `V` é copiado para o registrador `$s1`, que será usado para acessar os elementos de `V` durante a iteração. Dentro do loop, o valor atual de `V[i]` é carregado para o registrador `$t2`.

A próxima etapa é calcular o índice correto no vetor `H` para incrementar a contagem da intensidade correspondente. Isso é feito somando o valor de `V[i]` com o número máximo de intensidades (`$t1`) e armazenando o resultado em `$t3`. Em seguida, é aplicado um deslocamento para converter o índice em bytes, já que cada elemento de `H` é um word (4 bytes). O endereço de `H[V[i]]` é calculado adicionando o deslocamento a `$s1`.

Após obter o endereço correto, o valor atual de `H[V[i]]` é carregado para o registrador `$t4` e incrementado em uma unidade usando a instrução `addiu`. Em seguida, o novo valor é armazenado novamente em `H[V[i]]` usando `sw`.

O loop continua incrementando o endereço de `V`, decrementando o contador de elementos (`$t0`) e verificando se o contador é diferente de zero (`bnez`). O loop continua até que todos os elementos de `V` tenham sido processados.

Em seguida, o programa entra em um novo loop para exibir os elementos obtidos no vetor `H`. O endereço base de `H` é copiado novamente para `$s1`, e a syscall `print_int` é usada para imprimir cada elemento do vetor. O loop continua até que todos os elementos de `H` tenham sido impressos.

Por fim, a syscall é usada para encerrar o programa.

### Uso

Para utilizar o programa, você precisa montá-lo e executá-lo em um simulador MIPS, como MARS ou QtSPIM. Certifique-se de fornecer o vetor `V` inicializado com as amostras desejadas e ajust

ar o número total de elementos (`$t0`) e o número máximo de intensidades (`$t1`) de acordo com o seu contexto.

### Autor

[Seu nome completo e matrícula]