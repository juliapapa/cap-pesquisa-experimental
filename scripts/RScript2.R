#####
## Nivelamento em R
## Aula 3
## Umberto Mignozzetti
####

####
## Gráficos
####

## Tipos de variáveis, tipos de gráficos

# Antes de fazermos gráficos e a análise visual 
# do nossos bancos, precisamos entender que variáveis 
# temos. Cada variável terá uma forma de analisar os dados própria.

# Temos na prática dois tipos de variáveis 
# (ver Bussab e Morettin, 2017):
  
# - Qualitativas
# - Quantitativas

# Dentro de cada uma delas, temos os seguinte valores:
  
# - **Qualitativas nominais**: medidas qualitativas
#   que não tem imbuídos uma idéia de ordem (ex.: sexo, 
#   branco ou não branco, tem ou não uma caneta, etc.)

# - **Qualitativas ordinais**: medidas qualitativas que 
#   possuem uma idéia de ordem (ex.: escolaridade, classe 
#   social, faixa de renda, etc.)

# - **Quantitativas discretas**: medidas quantitativas 
#   que são representadas por valores inteiros (ex.: 
#   número de filhos, dias sem trabalhar, número de 
#   fotos tiradas em um dia, curtidas no Instagram, etc.)

# - **Quantitativas contínuas**: medidas quantitativas 
#   que podem ser fracionadas, sem perder coerência 
#   (ex.: renda, crescimento do PIB, proporção de votos
#   recebida por um candidato, etc.)

# Cada tipo variável pede por um determinado tipo de 
# gráfico que adequa-se melhor para descrever a variação. 

## GRÁFICOS PARA VARIÁVEIS QUANTI

# Tomemos por exemplo, o banco `USArrests`, 
# que mapeia crimes para cada 100 mil habitantes 
# nos EUA. Para descrevermos uma variável quantitativa, 
# podemos usar o 
# [histograma](https://pt.wikipedia.org/wiki/Histograma). 

# Para fazer um histograma em R basta usarmos o 

# EXERCÍCIO: carregue e analise o banco `USArrests`
data(USArrests)
help(USArrests)

# ANALISE:
library(tidyverse)
ggplot(data = USArrests) +
  geom_histogram(mapping = aes(x = Murder), bins=15)

# E temos um gráfico onde o número de assaltos para 
# cada 100 mil habitantes é contra sua frequência. 
# Nós começamos o gráfico com `ggplot`. Esse é o 
# comando do tidyverse para criar gráficos. Passamos 
# somente um parâmetro internamente ao comando: que o 
# banco de dados que estamos considerando é o 
# `USArrests` (`data = USArrests`). 

# Em seguida, adicionamos ao gráfico gerado a 
# figura geométrica que queremos. No caso, 
# a figura geométrica é o `geom_histogram`, 
# que gera as barras e conta as frequências 
# internamente no código. Em todo gráfico devemos 
# indicar o `mapping`, que é o posicionamento das 
# figuras geométricas. No caso de um histograma, 
# precisamos da variável, no eixo *x*. Portanto, 
# completamos o comando com 
# `geom_histogram(mapping = aes(x = Murder))`.

## GRMÁTICA DOS GRÁFICOS

# Nesse sentido, todo gráfico segue uma 
# ordem de construção, que Wickham chama 
# de a *gramática dos gráficos*. Em resumo, a gramática 
# dos gráficos significa que todo gráfico tem três elementos:
  
# * Um conjunto de dados (**data**);
# * Um sistema de coordenadas (**mappings**);
# * Um conjunto de figuras geométricas que caracteriza 
#   os gráficos (**geom**).

# No caso do histograma, os dados é o vetor com as 
# taxas de assassinato para cada 100 mil habitantes:
USArrests$Murder

# O sistema de coordenadas é mapear esses dados em caixas, 
# e contar a frequência por caixa. Por exemplo, 
# no caso dos dados acima, vamos ordenar os dados 
# e calcular a frequencia em caixas de tamanho 1:
sort(USArrests$Murder)

# Por exemplo, na caixa de 0 a 1 temos um dado, 
# na de 1 a 2 nenhum, na de 2 a 3, sete casos, e 
# assim por diante. Esse será o tamanho da barra. 
# Por fim, o geom usado, o histograma, vai dar o gráfico final 
# (um grupo de retangulos com esses números que calculamos). 
# Essa é a *gramática dos gráficos*, e toda figura é 
# composta por esses elementos mais outras firulas que 
# adicionamos para facilitar o entendimento.

# EXERCÍCIO: faça um histograma de Assault
ggplot(data = USArrests) +
  geom_histogram(mapping = aes(x = Assault), binwidth = 50,
                 fill = 'red', col = 'black', alpha = 0.1)

# Similar ao histograma, temos dois gráficos 
# interessantes, e que seguem a mesma lógica: 
# o gráfico de densidade, e o gráfico de pontos.

# Gráfico de pontos:
ggplot(data = USArrests) +
  geom_dotplot(mapping = aes(x = Murder), 
               binwidth = 1, alpha = 0.3) +
  scale_x_continuous(limits = c(0, 20))

# Gráfico da densidade usando kernel Gaussiano
ggplot(data = USArrests) +
  geom_density(mapping = aes(x = Murder), 
               kernel = 'gaussian')

# Outro gráfico importante para variáveis quantitativas é 
# o [diagrama de caixa](https://pt.wikipedia.org/wiki/Diagrama_de_caixa), 
# ou *box-plot*. O diagrama de caixa plota os 
# [quartis](https://pt.wikipedia.org/wiki/Quartil) da 
# distribuição, o que dá uma idéia da dispersão da variável.

# Box-plot
ggplot(data = USArrests) +
  geom_boxplot(mapping = aes(x = 1, y = Murder), alpha=0.3)

# Similar a este, mas mais bonito é o violin-plot. 
# Ele faz exatamente como o diagrama de caixa, mas converge 
# suavemente para os [quartis](https://pt.wikipedia.org/wiki/Quartil) 
# da distribuição:
  
# violin plot:
ggplot(data = USArrests) +
  geom_violin(mapping = aes(x = 'Violin', y = Murder), 
              lwd = 2)

# EXERCÍCIO: Faça um dotplot, density plot e um violin plot da
# variável Assault

## CUSTOMIZANDO GRÁFICOS

# Ainda sobre os gráficos, você pode customizar 
# as figuras a gosto. Existem uma série de funções 
# que nos auxiliam a colocar titulos, subtitulos, 
# mudar esquema de cores, etc. Por exemplo, vamos 
# fazer o histograma de Assault, colocando as 
# informações necessárias para compreendermos o gráfico:
  
## Nice plot
ggplot(data = USArrests) +
  geom_histogram(mapping = aes(x = Assault), bins = 10) +
  labs(x = 'Assaltos para cada 100 mil habitantes',
       y = 'Frequencia',
       title = 'Assaltos em Estados Americanos')

# Primeiro, `bins = 10` reduz o numero de divisões, 
# limitando-as em 10. Isso significa que teremos 
# dez barras em nosso histograma. Segundo, usamos 
# o comando `labs` para colocar o título e uma 
# descrição para os eixos `x` e `y`. Dessa forma temos:
  
# Labs      |  O que faz
# ----------------------------------
# x         |  definição do eixo x
# y         |  definição do eixo y
# title     |  título do gráfico
# subtitle  |  subtítulo do gráfico
#           |  (embaixo do título)
# caption   |  explicação abaixo
#           |  do gráfico

## EXERCÍCIO: Faça um gráfico de Assault, publication level.
data(USArrests)
library(tidyverse)
ggplot(data = USArrests) +
  geom_histogram(mapping = aes(x = Assault), 
                 bins = 8, color = 'gray20', 
                 fill = 'gray80', alpha = 0.5) +
  labs(x = 'Assaltos para cada 100 mil habitantes',
       y = 'Frequencia',
       title = 'Assaltos em Estados Americanos')
  

# Ainda, se você quiser alterar outros componentes, 
# basta consultar a [cheat sheet do ggplot2]
# (https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)

####
## GRÁFICOS PARA VARIÁVEIS QUALITATIVAS
####

# Para variáveis qualitativas, podemos fazer os famosos 
# gráficos de barras. Por exemplo, no banco `PErisk` 
# temos uma variável chamada `courts`, que vale 1 quando 
# um país tem um judiciário independente e 0 se o país não 
# tem o judiciário independente (que pode significar que o 
# país tem ou não judiciário, e que se tem, não é independente). 
# Para começar a análise:

## Exercícios: 1. Carregue o banco PE risk
##             2. Analise o banco
##             3. Faça um histograma do pib per capita

PErisk <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/PErisk.csv')

# Gráfico de barras:
ggplot(data = PErisk) +
  geom_bar(mapping = aes(x = courts))

PErisk$courts = as.factor(PErisk$courts)
levels(PErisk$courts) <- c('Judiciário comprometido', 'Judiciário independente')

ggplot(data = PErisk) +
  geom_bar(mapping = aes(x = courts))

# Para variáveis com mais de uma variação o 
# princípio é similar. Por exemplo, para a variável 
# que mede a ausência de risco de expropriação 
# (maior valor significa menor chance de ter sua 
# propriedade expropriada pelo estado), temos:
  
# Gráfico de barras: mais de duas barras
ggplot(data = PErisk) +
  geom_bar(mapping = aes(x = factor(prsexp2)))

# E quando usamos o comando `factor`, construímos 
# fatores com os valores. Podemos ainda alterar 
# o esquema de cores e os fundos das variáveis, 
# bem como a intensidade da cor da barra. Por exemplo:

# Exercício: faça um barplot para corrupção.
ggplot(data = PErisk) +
  geom_bar(mapping = aes(x = factor(prscorr2)))

# Barras coloridas
ggplot(data = PErisk) +
  geom_bar(mapping = aes(x = factor(prsexp2)), 
           fill = gray(1:6/7), color = 'red')

# O comando `rainbow` gera cores do arco-íris. 
# Se usarmos `rainbow(6)` o sistema calcula seis 
# cores no arco-íris que são igualmente espassadas. O parametro 
# `fill` significa o preenchimento das colunas.

## EXERCÍCIO: Faça um gráfico de barras da variável
#             de corrupção. Inclua titulos e nomes nos eixos.

####
## CRUZAMENTOS DE VARIÁVEIS
#### 

# Formular hipóteses estatísticamente testáveis 
# é, no geral, cruzar variáveis. No caso, vamos 
# fazer alguns gráficos que cruzam tipos de 
# variáveis, e ajudam a formular e ter uma primeira 
# aproximação visual da hipótese.

## Quali-Quali: o *mosaic-plot*

# Uma pergunta de pesquisa interessante é: 
# será que países com um judiciário independente 
# tem menos corrupção do que um país sem judiciário independente?
# Essa pergunta é importante, principalmente no contexto 
# atual, de todas as investigações políticas. Para medir 
# essa hipótese temos de comparar duas variáveis: a 
# ausência de corrupção (`prscorr2`) e existência de 
# judiciário independente (`courts`):
  
# Mosaic-plot
ggplot(data = PErisk) +
  geom_bar(mapping = aes(x = factor(prscorr2), 
                         fill = courts),
           position = 'fill')

# E para melhorar a hipótese, podemos transformar a 
# variável de corrupção em binária.

# Mosaic-plot: 2.0
PErisk$lowcorrup = as.numeric(PErisk$prscorr2>2)
PErisk$lowcorrup = as.factor(PErisk$lowcorrup)
levels(PErisk$lowcorrup) <- c('Alta corrupção', 'Baixa corrupção')
ggplot(data = PErisk) +
  geom_bar(mapping = aes(x = lowcorrup, 
                         fill = courts),
           position = 'fill')

# Portanto, parece que temos uma associação entre 
# judiciários livres e baixa corrupção. Note que se 
# você criar níveis corretos para as variáveis e 
# atribuir nomes aos fatores, o R imprime os nomes, 
# ao invés de 0 e 1:
  
# Mosaic-plot: 3.0
PErisk$lowcorrup_fator = factor(PErisk$lowcorrup)
levels(PErisk$lowcorrup_fator) <- c('Alta', 'Baixa')

PErisk$courts_fator = factor(PErisk$courts)
levels(PErisk$courts_fator) <- c('Não Independente', 'Independente')

ggplot(data = PErisk) +
  geom_bar(mapping = aes(x = lowcorrup, 
                         fill = courts),
           position = 'fill') +
  labs(x = 'Corrupção', 
       y = 'Proporção', 
       fill = 'Status das Cortes')

# Esse gráfico ficou ótimo, e mostra claramente a 
# relação entre independência de judiciários e nível de corrupção.

## Quali-Quanti: o *box-plot*

# Outra hipótese legal, e que envolve cruzar uma 
# variável quali com uma variável quanti, é: você 
# acha que o prêmio no mercado negro cresce ou diminui 
# em uma sociedade com muita corrupção. Podemos imaginar 
# que corrupção é um sinal de que a sociedade está pouco 
# institucionalizada, e isso certamente impacta nos 
# ganhos de transações ilicitas. Por outro lado, 
# alguém pode imaginar que mais corrupção um mercado 
# negro mais competitivo, e portanto, que gere menores ganhos.

# Para testar essas hipóteses, vamos usar a variável 
# `lowcorrup_fator`, que criamos para captar o nível 
# alto ou baixo de corrupção em uma sociedade, e a variável 
# `barb2`, que é o ganho em logaritmo do mercado negro 
# nos países. Note que quanto maior essa variável, 
# maior o ganho do mercado negro vis-a-vis o mercado formal.

# Do ponto de vista gráfico, podemos fazer ambos um 
# box-plot ou um violin-plot para entendermos a 
# dispersão. No entanto, colocamos a quali (corrupção) 
# no eixo x e a quanti (prêmio do mercado negro) no 
# eixo y.

# Usando box-plot
ggplot(data = PErisk) +
  geom_boxplot(mapping = aes(x = lowcorrup, y = barb2))

# Usando violin-plot
ggplot(data = PErisk) +
  geom_violin(mapping = aes(x = lowcorrup, y = barb2))

# Portanto, há diferenças importantes nas distribuições 
# nos dois casos. Nesse sentido, temos algum fundamento 
# para acreditar que haja uma relação significativa 
# entre corrupção e os ganhos na informalidade.

## Quanti-Quanti: o *diagrama de dispersão*

# Sobre quanti x quanti, ainda no banco do risco político 
# e econômico (`PErisk`), podemos nos perguntar se a 
# informalidade afeta o PIB per capita. De um lado, 
# o mercado formal ter burocracias, impostos, entre 
# outras, que faz com que seja extremamente caro seguir 
# suas regras. De outro, o mercado formal proporciona 
# proteções e garantias a seus usuários, algo que falta 
# no mercado informal. Qual dessas perspectivas vale empiricamente?

# Temos duas variáveis: `gdpw2`, para PIB per capita 
# (por trabalhador), e `barb2`, que é o prêmio no mercado 
# informal. Para comparar ambas usamos um diagrama de dispersão:

# Diagrama de dispersão
ggplot(data = PErisk) +
  geom_point(mapping = aes(x = barb2, y = gdpw2))

# O `geom_point` é a figura geométrica que plota 
# os pontos no diagrama de dispersão. É evidente que 
# para mapear esses pontos, precisamos de duas variáveis, 
# que são respectivamente os valores em cada um dos eixos. 
# Portanto, no `mapping`, o `aes` contém as duas variáveis 
# e a indicação de eixo para cada uma delas. 

# É difícil ver a tendência no gráfico acima, pois 
# parece mesmo uma nuvem de dados toda distribuída 
# aleatóriamente. Ainda assim, podemos colocar uma reta 
# ajustada, que capta a tendência linear:
  
# Diagrama de dispersão com reta ajustada:
ggplot(data = PErisk) +
  geom_point(mapping = aes(x = barb2, y = gdpw2)) +
  geom_smooth(mapping = aes(x = barb2, y = gdpw2), 
              method = 'lm')

# Para colocar a reta ajustada temos de usar o 
# `geom_smooth`. O `mapping` é similar, a diferença 
# é com o `method`, que captura o fato que queremos 
# uma reta ajustada por regressão linear 
# simples (`method = 'lm'`).

# Podemos ainda diferenciar os países de acordo 
# com possuir ou não um judiciário independente. No caso:
  
# Diagrama de dispersão + variável binária
ggplot(data = PErisk) +
  geom_point(mapping = aes(x = barb2, y = gdpw2, color = courts)) +
  geom_smooth(mapping = aes(x = barb2, y = gdpw2), 
              method = 'lm')

# E portanto, a relação parece ser mais intensiva nos países que 
# tem cortes independentes. Ou seja, talvez maior prêmio no
# mercado negro seja mais maléfico para o PIB em países 
# com instituições melhor consolidadas, do que em 
# países com instituições judiciárias não-livres.

# Gráfico com uma só reta ajustada, mas diferenciando pontos
ggplot(data = PErisk) +
  geom_point(mapping = aes(x = barb2, y = gdpw2, color = courts)) +
  geom_smooth(mapping = aes(x = barb2, y = gdpw2), 
              method = 'lm')

# Gráfico com duas retas ajustadas, para cada um dos tipos de pontos
ggplot(data = PErisk) +
  geom_point(mapping = aes(x = barb2, y = gdpw2, color = courts)) +
  geom_smooth(mapping = aes(x = barb2, y = gdpw2, color = courts), 
              method = 'lm')

# E aí está a confirmação (ao menos visual) de que judiciário 
# independente e alto prêmio no mercado negro, é má 
# notícia para o PIB per capita.

# EXERCÍCIO: faça um diagrama de dispersão para Assault e População
#            urbana no banco USArrests

## BONUS: fazendo um gráfico com mais de duas variáveis

# Para variáveis quanti-quanti aprendemos que o R faz 
# diagramas de disperção duas a duas. Uma ideia legal 
# seria: e se tivermos quatro variáveis quanti? 
# Podemos fazer um diagrama de dispersão com todas 
# elas, cruzando de duas em duas, em um único 
# gráfico? A resposta é sim! E o comando para fazer 
# chama-se `pairs`. Por exemplo, suponha que 
# queremos fazer isso com o `USArrests`. Vamos 
# olhar se ele seria adequado à tarefa:
View(USArrests)

# Portanto, parece um banco bem adequado: todas as 
# quatro variáveis são numéricas. Nesse caso, o 
# R tem um gráfico, chamado de `pairs`, que se 
# adequa bem ao cruzamento de várias variáveis quantitativas:
pairs(USArrests, gap=0, col=2)

# Como você pode ver, na diagonal principal 
# temos o nome da variável, e cada um dos 
# cruzamentos acima (ou abaixo). Note que o triangulo 
# superior é o espelho do triângulo inferior, ou seja, 
# é o mesmo cruzamento, mas alterando as abscissas 
# (eixo x), pelas ordenadas (eixo y). `col=2` 
# significa a cor vermelha para a bolota. 

####
## Exercícios
###

# 1. Carregue o banco `USArrests`. Faça um violin plot para 
#    a variável Assault.

# 2. Carregue o banco `USJudgeRatings`. Faça um histograma 
#    da variável `INTG`.

# 3. No banco `USJudgeRatings`, faça um diagrama de 
#    dispersão entre `INTG` e `DMNR`. Descreva em palavras os 
#    achados.

# 4. Carregue o banco `voteincome` do pacote Zelig. Faça 
#    um violin-plot de educação segmentado por renda. Descreva 
#    com palavras os achados.

# 5. No banco `voteincome`, faça um mosaic-plot de voto 
#    versus educação. Faz sentido teórico o resultado? Por que?
  
# 6. Usando o banco `voteincome` responda à seguinte 
#    pergunta: gráficamente, existe alguma diferença de 
#    sexo entre votantes e não-votantes?
  
# 7. Usando o banco `voteincome` responda à seguinte 
#    pergunta: qual estado que tem mais pessoas indo votar?

# 8. Usando o banco `voteincome`, suponha que você vá 
#    colocar em um relatório ao seu superior os 
#    resultados do cruzamento entre ir votar e estado. 
#    Coloque título, subtítulo e escolha um esquema de 
#    cores que chame a atenção.

# 9. Carregue o banco `sanction` do pacote Zelig. 
#    Faça um gráfico de barras colorido para a variável `ncost`.

# 10. Usando o banco `sanction` do pacote Zelig, 
#     responda à seguinte pergunta: quais países sofrem 
#     mais perdas com sanções, os que cooperam mais ou os 
#     que cooperam menos?

####
## MANIPULANDO DADOS EM R
####

# Agora que sabemos visualizar dados, precisamos saber como 
# sair de variáveis que achamos na internet (ou mesmo 
# em arquivos de texto), sem nenhuma estrutura, 
# e construímos um banco de dados coerente.

## Pacotes de manipulação de dados

# Temos três grupos de pacotes para lidarmos com 
# processamento de dados no R. O R vem com pacotes 
# instalados do `r-base` (por assim dizer, o coração 
# do R) que tem duas características básicas. Segundo, 
# temos o `tidyverse`, que é o pacote criado por
# Wickham, baseado na idéia de gramáticas na análise 
# de dados. Finalmente, temos o `data.table`, um 
# pacote que torna eficiente a analise e processamento 
# de grandes bases de dados no R. Cada um desses 
# pacotes tem prós e contras. Abaixo, um sumário 
# preparado pelo colega e cientista de dados 
# *Guilherme Duarte*, que explica as diferenças dos 
# pacotes:
  
# * `dplyr`/`tidyr`:
#   + Fácil de escrever e lidar.
#   + A sintaxe permite maior legibilidade e maior rapidez
#   + O uso dos operadores pipe, por exemplo, "%>%" permite 
#     organizar melhor as operações.

# * `data.tables`:
#   + As vezes, é mais rápido.
#   + Difícil de se lidar.
#   + Melhor para trabalhar com big data

# * `r-base`:
#   + Sintaxe não é muito limpa.
#   + Difícil de se lidar.
#   + Nas horas de dificuldade, salva o trabalho.

# Neste curso, como falamos, vamos no `tidyverse`, 
# pois ele possui algumas características que o torna 
# mais fácil de usar, e ao mesmo tempo sofisticado, 
# possibilitando que você se aprofunde nas técnicas 
# sem grandes dificuldades de operação.

## O conceito de banco de dados **arrumado** (tidy datasets)

# O tidyverse é baseado na idéia de banco *arrumado*. 
# O que isso significa?
  
# Primeiro, note que qualquer conjunto de objetos 
# pode ser descrito como um banco de dados. 
# Isso não ajuda muito para entender o que 
# são bancos de dados, principalmente porque 
# confunde-se com a idéia de banco de dados que 
# temos corriqueiramente (que é algo como uma planilha 
# de Excel). Na verdade, bancos de dados podem ser as 
# coisas mais variadas o possível: por exemplo, 
# um banco de fotos é um tipo de banco de dados; 
# um conjunto de arquivos pode ser um tipo de banco 
# de dados, etc.

# Aqui nosso princípio é o de banco arrumado: 
# num banco arrumado, duas características são 
# verdadeiras:
  
# 1. Uma linha sempre representa um único caso;
# 2. Uma coluna sempre representa uma única variável.

# Desse modo, num banco arrumado, não podemos ter 
# uma parte de um caso em uma linha e o restante 
# em outra. Da mesma forma, não podemos ter em 
# uma coluna uma parte de uma variável e outra 
# parte em outra coluna do mesmo banco.

# Para *arrumar* os bancos de dados que 
# achamos na internet, usamos o *tidyverse*.

####
## O **tidyverse**
####

# *tidyverse* é o nome de uma série de pacotes 
# criados por Hadley Wickham para operar com 
# dados. Os pacotes visam facilitar o trabalho 
# do cientista de dados, pois são baseados na 
# idéia de `gramáticas`, ou seja, os componentes 
# mínimos para cada um dos passos de análise. O *tidyverse* 
# é composto dos seguintes pacotes:
  
# * Pacotes para processar dados: `dplyr`, `tidyr`, 
#   `stringr`, `lubridate`
# * Pacotes para visualização de dados: `ggplot2`
# * Pacotes para importar/exportar dados: `haven`, `httr`, 
#   `readxl`, `readr`, `rvest`

# Cada pacote desses tem uma funcionalidade, mas 
# o princípio geral que rege todos os pacotes do 
# *tidyverse* são:
  
# 1. Estruturas de dados reutilizaveis: sempre 
#    que possível, reutilizar as estruturas de dados, 
#    e não criar novas estruturas desnecessáriamente.

# 2. Criar funções simples, usando tubos (*pipe*) 
#    sempre que possível: resolver problemas por 
#    partes, sempre dividindo problemas complexos em passos simples.

# 3. Aceitar a programação funcional: diferente de 
#    linguagens orientadas a objetos, o R é funcional. 
#    Dessa forma, use os objetos do R, e não construa 
#    outros objetos.

# 4. Códigos para humanos: os códigos devem ser fáceis 
#    para os humanos entenderem. Dessa forma, use verbos 
#    para funções, use nomes grandes, faça a sintaxe ser 
#    auto-explicativa e use comentários e descrições de modo 
#    abundante.

#####
## Operações no mesmo banco de dados
#####

# Num mesmo banco de dados, podemos aplicar as seguintes operações:
  
#  Operação    | Motivo
#-------------------------------------------------
#  select      | Seleciona variáveis do banco
#  rename      | Renomeia variáveis do banco
#  filter      | Selecionar um subconjunto de casos
#  arrange     | Ordena o banco de dados
#  mutate      | Adiciona ao banco de dados uma
#              | variável transformada
#  transmute   | Cria novo banco de dados aplicando
#              | uma dada transformação
#  group_by    | Agrupa o banco de dados de acordo
#              | com uma variável dada
#  summarise   | Calcula o sumário dos resultados
#              | do banco de dados
#  sample_n    | Calcula uma amostra de tamanho n
#              | do banco original
#  sample_frac | Retira uma proporção dos dados
#              | como amostra do banco original
#  distinct    | Preserva todos os casos que tem
#              | variação distinta dos outros

#### `select`

# Suponha que queremos selecionar somente as variáveis 
# `barb2` e `gdpw2`, ou seja, a variáveis quantitativas 
# contínuas premio no mercado negro e pib per capita. Nesse caso:
PErisk_so_quanti <- select(PErisk, barb2, gdpw2)
head(PErisk_so_quanti)

# Ou seja, a sintaxe foi a seguinte:
### banco_pos_selecao <- select(banco_inicial, var1, var2, var3, ...)

# SELECT POR CARACTERISTICAS
PErisk_so_com_co <- select(PErisk, starts_with('co'))
head(PErisk_so_com_co)

# E a função `starts_with` seleciona somente as 
# variáveis cujo nome começa com `co`, no caso 
# `country` e `courts` (poderia ter usado `cou` e funcionaria igual). 
# Outra função de seleção importante é a que seleciona pelo fim:
PErisk_termina_com_2 <- select(PErisk, ends_with('2'))
head(PErisk_termina_com_2)

# E portanto, seleciona todas as variáveis que o nome 
# termina com o número 2. Podemos também selecionar as 
# variáveis que contém, em seus nomes, um conjunto de 
# caracteres que determinarmos. Por exemplo, suponha 
# que queremos selecionar as variáveis que contem `exp` 
# no nome (porque queremos coisas relacionadas à expropriação):
PErisk_contem_exp <- select(PErisk, contains('exp'))
head(PErisk_contem_exp)

# NOMES:
names(PErisk)

# Podemos selecionar as variáveis entre `courts` e 
# `prscorr2` usando dois pontos:
PErisk_entre_vars <- select(PErisk, courts:prscorr2)
head(PErisk_entre_vars)

# E se usarmos o sinal de menos (`-`) em frente 
# à seleção (coloque a seleção entre parênteses), 
# pegamos todas as variáveis menos as que especificamos:
PErisk_menos_entre_vars <- select(PErisk, -(courts:prscorr2))
head(PErisk_menos_entre_vars)

# E portanto, esses são os métodos de seleção:
  
#  Método             | Efeito
#----------------------------------------------------
# v1, v2, v3 (etc)   | Seleciona as variáveis listadas
# starts_with('xyz') | Nome começa com `xyz`
# ends_with('xyz')   | Nome termina com `xyz`
# contains('xyz')    | Contém `xyz` no nome
# vk:vn              | Todas entre `vk` e `vn`
# -(vk:vn)           | Todas menos as entre `vk` e `vn`

# E você ainda pode usar o `select` para selecionar e 
# renomear variáveis:
PErisk_barb_renome <- select(PErisk, premio_mercado_negro = barb2)
head(PErisk_barb_renome)

# E a mesma lógica vale para um grupo de variáveis:
PErisk_renome <- select(PErisk, vars = courts:prscorr2)
head(PErisk_renome)

## PX AULA: CONTINUAMOS ISSO!