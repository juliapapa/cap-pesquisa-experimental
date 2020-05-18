## Manipulando dados R
## Umberto Mignozzetti e Lucas Mingardi

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

#### `rename`

# É a função que usamos para renomear variáveis no banco.
PErisk_renomeado <- rename(PErisk, pais = country, 
                           indepjud = courts)
head(PErisk_renomeado)

#### `filter`

# Filtrando dados
PErisk_filtrado <- filter(PErisk, courts == 1)
head(PErisk_filtrado)
dim(PErisk_filtrado)

# Caso você precise filtrar de acordo com mais de 
# uma condição, por exemplo, cortes independentes 
# mas alta corrupção (menor que 3), você pode 
# passar os comandos em sequência:
PErisk_filtrado2 <- filter(PErisk, courts == 1, prscorr2 < 3)
head(PErisk_filtrado2)
dim(PErisk_filtrado2)

#Operador	 | Significado
#--------------------------------
#`<` e `<=` | menor e menor e igual
#`>` e `>=` | maior e maior e igual
#`==`	     | é igual
#`!=`	     | é diferente
#`!`        | nega uma proposição
#`|`	       | ou
#`&`	       | e
2>4 # Falso (dois maior que quatro)
2<=4 # Verdadeiro (dois menor ou igual a quatro)
2!=4 # Verdadeiro (dois diferente de quatro)
2>4 | 2<=4 # Verdadeiro (dois maior que 4 ou dois menor ou igual a 4)
2>4 & 2<=4 # Falso (dois maior que 4 e dois menor ou igual a 4)

# E portanto, podemos usar esses operadores para 
# filtrar o banco como quisermos.

#### `arrange`

# A função `arrange` serve para ordenar o 
# banco de dados, incluindo ordem alfabetica 
# e numerica. Basta selecionar uma ou mais 
# variáveis que serão usadas para fazer o 
# ordenamento. Por exemplo:
PErisk_ordenadoPIB <- arrange(PErisk, gdpw2)
head(PErisk_ordenadoPIB)

# Ou também podemos reverter a ordem:
PErisk_ordenadoPIB2 <- arrange(PErisk, desc(gdpw2))
head(PErisk_ordenadoPIB2)

# A função `desc` entende que queremos ordenar em ordem decrescente.

#### `mutate` e `transmute`

# Frequentemente em processamento de dados 
# queremos alterar os valores de colunas, 
# ou multiplicando, ou passando funções que 
# são de interesse do usuário. No caso, `gdpw2` 
# denota o PIB per capita, em log 
# (para diminuir a escala). Suponha que queremos 
# transformar em dolares novamente. 
# Precisamos usar a função `exp`:
PErisk_PIBemDolares <- mutate(PErisk, PIBpc = exp(gdpw2))
head(PErisk_PIBemDolares)

# Ainda, podemos usar essas funções para criar 
# variáveis que fazem comparações, e retornam 
# resultados dessas comparações:
PErisk_transmuted2 <- mutate(PErisk_transmuted, 
                             riscoNota = ifelse(risco>5, 'Alto', 'Baixo'))
head(PErisk_transmuted2)

#### `group_by` + `summarize`

# Muitas vezes precisamos de estatísticas 
# descritivas dos bancos por grupos de variáveis. 
# Por exemplo, suponha que queremos saber as 
# médias de algumas variáveis que temos no 
# banco. Podemos aplicar a seguinte função:
PErisk_summarized <- summarize(PErisk, 
                               courts_media = mean(courts, na.rm=T),
                               barb2_media = mean(barb2, na.rm=T),
                               gdpw2_media = mean(gdpw2, na.rm=T)
)
head(PErisk_summarized)

# E aqui usamos a média simples `mean`, 
# para calcular médias (note o `, na.rm=T`: 
# excluir valores perdidos...). Podemos 
# usar as seguintes funções:
  
# Função R     | Estatística
# ---------------------------------------------
# sum()        | Soma de valores
# mean()       | Média
# var()        | Variancia
# sd()         | Desvio-padrão
# median()     | Mediana
# summary()    | Resumo Estatístico
# quantile()   | Quantis
# mad()        | Desvio absoluto da mediana
# IQR()        | Intervalo inter-quartil
# min()        | Valor mínimo
# max()        | Valor máximo
# n()          | Numero de observações
# n_distinct() | Numero de valores únicos
# first()      | Primeira observação
# last()       | Ultima observação
# nth()        | n-ésima observação

# Por exemplo, se quisermos o mesmo 
# exercício, mas agora calculando medianas:
PErisk_summarized2 <- summarize(PErisk, 
                                courts_mediana = median(courts, na.rm=T),
                                barb2_mediana = median(barb2, na.rm=T),
                                gdpw2_mediana = median(gdpw2, na.rm=T)
)
head(PErisk_summarized2)

# No entanto, muitas vezes precisamos calcular 
# essas estatísticas de acordo com grupos de 
# valores para uma variável de agrupamento. 
# Por exemplo, quais são as médias das variáveis 
# `barb2` (premio da informalidade) e `gdpw2` 
# (PIB per capita) para os países, de acordo 
# com seus níveis de risco de expropriação 
# (`prsexp2`)? Para isso, basta usarmos a 
# função de agrupamento antes de pedirmos o sumário:
PErisk_agrupado <- group_by(PErisk, prsexp2)
PErisk_agrupado <- summarize(PErisk_agrupado, 
                             barb2_media = mean(barb2, na.rm=T),
                             gdpw2_media = mean(gdpw2, na.rm=T),
                             ncasos = n())
head(PErisk_agrupado)

# O agrupamento não tem efeito prático, mas diz 
# ao sistema que, caso utilizemos a função 
# `summarize`, ele deve levar em conta a variável 
# de agrupamento.

#### `sample_*`

# Muitas vezes estamos trabalhando com bancos 
# de dados extremamente grandes. Para facilitar 
# o trabalho, precisamos usar bancos de dados 
# menores, que cabem na memória, ou tomam menos 
# tempo de processamento. Assim, podemos criar o 
# script que vai rodar no banco maior, e deixar o 
# computador processando os dados enquanto fazemos 
# qualquer outra coisa. Para isso, precisamos ter 
# capacidade de extrair amostras dos bancos de dados 
# que estamos usando. Para extrair amostras de tamanhos 
# pré-determinados usamos a função `sample_n`. 
# Por exemplo, vamos extrair dez casos do banco `PErisk`:
sample_n(PErisk, 10)

# As vezes, por questões de replicação, ou para evitar 
# viéses, podemos retirar amostras com reposição (amostra 
# com reposição significa: toda vez que tirarmos 
# bolinhas de um saco, devolvemos a bolinha e sorteamos 
# novamente). Nesse caso:
sample_n(PErisk, 10, replace=T)

# E portanto, Venezuela foi sorteada duas vezes. 
# Ainda, podemos usar a função de agrupamento, 
# se quisermos que o sorteio seja feito levando 
# em conta as frequências dentro de cada grupo:
PErisk_agrupado <- group_by(PErisk, courts)
sample_n(PErisk_agrupado, 5)

# E isso seleciona cinco casos que tem judiciários 
# independentes, e cinco casos que não tem judiciários 
# independentes. Ainda, podemos amostrar frações do 
# banco de dados usando a função `sample_frac`:
sample_frac(PErisk, 0.1)

# E tiramos assim uma amostra de 10% dos dados 
# (ou seja, 6 dos 62 casos de `PErisk`).

#### Tubos (sequência de comandos)

# Por exemplo, suponha que queremos tirar as médias do prêmio 
# no mercado negro e PIB per capita, para países com altas 
# taxas de corrupção, separando países em grupos de acordo 
# com a independência das cortes. Dessa forma, temos três tarefas:
  
# 1. Selecionar só os países com alta taxa de corrupção (`prscorr2 < 3`);
# 2. Agrupar os dados por presença e ausência de cortes;
# 3. Calcular as médias das variáveis e retornar os resultados.

# Uma vez decididas as tarefas, o uso fica simples:
PErisk_piped <- PErisk %>% # Primeiro informamos o banco de dados
  filter(prscorr2 < 3) %>% # Passo 1
  group_by(courts) %>% # Passo 2
  summarize(barb2_media = mean(barb2, na.rm=T),
            gdpw2_media = mean(gdpw2, na.rm=T),
            gdpw2dol_media = exp(mean(gdpw2, na.rm=T))) # Passo 3
PErisk_piped

# E portanto, o operador `%>%` (*pipe*) permite montarmos 
# uma função composta. Como em matemática temos funções 
# compostas, no processamento de dados, em varias etapas, 
# também podemos fazer funções compostas usando essa idéia de 
# tubos e tubulações.

#### `distinct`

# Essa função remove dados que aparecem repetidos nos 
# bancos de dados. Por exemplo: suponha que você cometeu 
# um erro e tem um banco de dados em que as entradas 
# aparecem replicadas. Por exemplo:
PErisk_dupl <- sample_frac(PErisk, 5, replace=T) %>%
  arrange(country) # Pede um sample com o cinco vezes o tamanho do banco de dados...
PErisk_dupl

# E queremos corrigir o erro, excluindo as observações 
# repetidas. Para isso, usamos a função `distinct`:
PErisk_distinct <- PErisk_dupl %>% distinct()
PErisk_distinct
dim(PErisk_distinct)

### Disposição de bancos de dados

# Há várias maneiras de se dispor de um data.frame.
# Por exemplo, verifiquem essa base de resultados 
# de um tratamento médico.
dat <- data.frame(
  id = c(1,2,3),
  grupo = c('g1', 'g2', 'g3'),
  treatment_a = c(.36,.25,.3),
  treatment_b = c(.15,.12,.13),
  treatment_c = c(.43,.33,.35)
)
dat

# No entanto, o mesmo banco de dados pode ser apresentado na 
# seguinte forma:
dat_alt <- data.frame(
  id = c(1,1,1,2,2,2,3,3,3),
  grupo = c('g1', 'g1', 'g1', 'g2', 'g2', 'g2', 'g3', 'g3', 'g3'),
  treatment = c('a','b','c','a','b','c','a','b','c'),
  valor = c(.36,.15,.43,.25,.12,.33,.3,.13,.35)
)
dat_alt

# No pacote `tidyr` temos varias funções para transformar as 
# bases de dados de modo a transformar as entradas seguindo 
# o princípio de banco de dados *arrumado* (colunas = variáveis, 
# linhas = casos). Vejamos algumas:
  
#### `separate`
  
# Este comando separa 1 colunas em duas ou mais, com base 
# em algum padrão de character. Por exemplo:
df <- data.frame(x = c("a.b", "a.d", "b.c"))
df

# Separando em colunas A e B, usando o ponto como separador:
df %>% separate(x, c("A", "B"), sep='\\.')

# Se tivermos mais variações que o esperado, o sistema preenche 
# com NA onde não tem variação:
df <- data.frame(x = c('a.b.c', 'a.d.f.h', 'b.c'))
df

# Separando em colunas A até D:
df %>% separate(x, c('A', 'B', 'C', 'D'), sep='\\.')

#### `unite`

# Este comando é o contrário de separate: ele 
# une mais de uma colunas em uma só. Por exemplo:

df <- data.frame(x = c("a.b", "a.d", "b.c"))
df

# Separando em colunas A e B, usando o ponto como separador:
df_separate <- df %>% separate(x, c("A", "B"), sep='\\.')
df_separate

# Agora unindo de volta as variáveis:
df_separate %>% unite(x, A, B)

# Mas por default o sistema usa o sublinhado 
# (`_`) para juntar as coisas. Quando o banco 
# tem NA, em geral dá problemas:
df <- data.frame(x = c('a.b.c', 'a.d.f.h', 'b.c'))
df

# Separando em colunas A até D:
df_separate <- df %>% 
  separate(x, c('A', 'B', 'C', 'D'), sep='\\.')
df_separate

# Juntando...com NAs:
df_separate %>% unite(x, A,B,C,D)

# Basta depois extrair os NAs com operações de texto. 
# Uma função de R ótima para substituir textos é a `gsub`, 
# e você pode estudar mais sobre ela na ajuda do R.

#### `spread`

# Agora suponha que temos um banco de dados com o seguinte formato:
dat <- data.frame(
  caso = c('c1','c1','c1','c2','c2','c2','c3','c3','c3'),
  treat = c(1,2,3,1,2,3,1,2,3),
  result = c(.1,.2,.1,.5,.2,.9,1,.1,0)
)
dat

# E queremos compactar esses dados, de acordo com os 
# níveis de tratamento aplicados. A função `spread` 
# pode nos ajudar nessa tarefa:
dat_spread <- dat %>% spread(caso,result)
dat_spread

#### `gather`

# A função `gather` reverte o que a função `spread` 
# faz. Nesse caso, ela recolhe os valores espalhados 
# pelas colunas e criar colunas novas:
dat_spread %>% gather(caso, result, -treat)

### Agregação de bancos de dados

# Um problema frequente que temos em análise de 
# dados é a necessidade de combinar diversos 
# bancos em um só. Isso é extremamente complexo 
# na maior parte dos pacotes de estatística, mas 
# felizmente, é bem fácil de fazer no R.

# Para este problema, vamos considerar os seguintes bancos:

# First dataset
dat1 <- PErisk %>% 
  filter(country %in% PErisk$country[1:5]) %>%
  select(country, courts:prsexp2)
dat1

# Second dataset
dat2 <- PErisk %>% 
  filter(country %in% PErisk$country[2:6]) %>%
  select(country, prscorr2, gdpw2)
dat2

# Note que ambos os dados compartilham a variável 
# `country`, mas que os países são diferentes do 
# banco 1 para o banco 2. A variável que eles tem 
# em comum é essencial para juntarmos um banco no 
# outro: ela determina quais casos são os mesmos nos 
# dois bancos, e note que separamos os bancos para serem 
# diferentes nas outras variáveis. Isso é comum, quando 
# pegamos pesquisas em que um grupo de pesquisadores coletou 
# um certo conjunto de variáveis sobre o país, e outro coletou 
# outro conjunto de variáveis. Agora, vamos juntar os bancos 
# para analisa-las juntas. Temos, resumidamente, quatro tipos 
# de funções que servem a esse propósito:
  
# Comando     | Descrição
# ----------------------------------------------------
# inner_join  | Junta os bancos, preservando os casos
#             | presentes em ambos os bancos
# left_join   | Agrega os dados do segundo banco ao
#             | primeiro, preservando valores que 
#             | estejam incompletos no primeiro banco
# right_join  | Agrega os dados do segundo banco ao
#             | primeiro, preservando valores que 
#             | estejam incompletos no primeiro banco
# full_join   | Agrega todos os dados, independente
#             | se os casos aparecem em um e não em
#             | outro banco. Preenche com NA onde
#             | não tem informação.
# semi_join   | Preserva os casos no primeiro banco
#             | que também existem no segundo banco
# anti_join   | Preserva os casos no primeiro banco
#             | que não existem no segundo banco

#### `inner_join`

# O `inner_join` é útil para juntar bancos de dados 
# preservando somente aqueles que aparecem nos dois bancos.
dat3_innerjoin <- inner_join(dat1, dat2)
dat3_innerjoin

# Ou seja, os casos incompletos (Argentina no primeiro 
# banco não aparece no segundo banco, e Bolivia no segundo 
# banco não aparece no primeiro banco) são descartados.

#### `left_join`

# Junta todos os casos do primeiro banco no segundo 
# banco. Se algum caso não existe no segundo banco, 
# o sistema preenche com NA os locais onde os dados 
# estão ausentes.
dat3_leftjoin <- left_join(dat1, dat2)
dat3_leftjoin

#### `right_join`

# Junta todos os casos do segundo banco no primeiro. 
# Se algum caso não existe no primeiro banco, o sistema 
# preenche com NA os locais onde os dados estão ausentes.
dat3_rightjoin <- right_join(dat1, dat2)
dat3_rightjoin

#### `full_join`

# O `full_join` junta todos os casos em um banco e no 
# outro, independente de um caso aparecer em um banco 
# e não em outro. Ele preenche os valores faltantes com 
# NA em ambos os lados.
dat3_fulljoin <- full_join(dat1, dat2)
dat3_fulljoin

#### `semi_join`

# O `semi_join` preserva parte do primeiro banco, que tem 
# variáveis também no segundo banco.
dat3_semijoin <- semi_join(dat1, dat2)
dat3_semijoin

# Isso é util para identificar o que temos no primeiro banco 
# que também temos no segundo banco.

#### `anti_join`

# O comando `anti_join` preserva os casos que estão completos 
# no primeiro banco, mas não tem nenhuma entrada no segundo banco.
dat3_antijoin <- anti_join(dat1, dat2)
dat3_antijoin

# A idéia é que usando o `anti_join`, você consegue ter 
# uma idéia do que está faltando no segundo banco, mas que 
# existe no primeiro.