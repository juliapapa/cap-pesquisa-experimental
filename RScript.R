# Minha soma criativa
2+2

# Instalação de pacotes legais
install.packages('tidyverse',dependencies = T)
install.packages('car', dependencies = T)
install.packages('pscl', dependencies = T)

# Ixi, esses não deram certo!
install.packages('Zelig', dependencies = T)
install.packages('Zelig',repos='http://cran.us.r-project.org')

# Esse pacote foi o último
install.packages('devtools',repos='http://cran.us.r-project.org',dependencies = T)

# R como calculadora

# Soma
2+2

# Subtração
3-3

# Multiplicação
3*3

# Divisão
5/2

# Potencia
2^3

# Funções

# Log
log(3)

# Exponencial
exp(3)

# log1p
log(0) # qual o log de zero???
log1p(0)

# Numeros especiais
Inf # infinito
NA  # não tem valor (missing data)
NaN # not a number
pi  # é o dito-cujo mesmo!
T   # True (lógica)
TRUE # True (lógica) por extenso
F   # False (lógica)
FALSE # False (lógica) por extenso

# Operação mais complexa
4+(22/7*(55/pi))

# Variável (Numeric)
v = 3
w <- 7
v+w

# Characters
z <- 'Meu deus, estou assistindo aula na sexta a noite!'

# Boolean
x = FALSE

# Classe
class(v)
class(z)
class(x)

# Perguntar class
is.numeric(z)
is.character(z)
!is.numeric(z)

# Vetores
nums <- c(2, 3, 4, 4, 5.5, 5)

## Algebra de vetores
2*nums # Multiplicação por escalar

nums2 <- c(-1, 0, 1, 2, 3, 4)

nums+nums2 # Soma de vetores

nums
nums+1

sum(nums) # Soma componentes

## Operações lógicas
nums > 5 # > maior que...
nums < 5 # < menor que...
nums == 5 # == igual...
nums >= 5 # >= maior-igual que...
nums <= 5 # <= menor-igual que...
nums != 5 # != diferente...

# [a, b]: todos os números entre a e b, inclusive
# [3, 5]: entre três e cinco, inclusive
nums >= 3 & nums <= 5

# [3, 5): entre três e cinco, inclusive 3
nums >= 3 & nums < 5

# x < 3 ou x >= 5:
nums < 3 | nums >= 5

# Texto?
nomes = c('umberto', 'gabriel', 'camila', 
          'fernanda', 'giovanna')

nomes == 'umberto'
nomes != 'umberto'

nomes %in% c('umberto', 'gabriel')

# Criando um banco de dados

# Método ruim...
est_civ <- c('solteiro','casado','casado',
             'solteiro','solteiro','casado',
             'solteiro','solteiro','Casado',
             'solteiro','casado','solteiro',
             'solteiro','casado','casado',
             'solteiro','casado','casado')

table(est_civ)

# Encontrando casos
est_civ[9]

# Corrijo?
est_civ[9] <- 'casado'

table(est_civ)

## Modo melhor
est_civ2 <- c(0,1,1,0,0,1,
              0,0,1,0,1,0,
              0,1,1,0,1,1)

## factor: fatores em R
est_civ2 <- factor(est_civ2, levels = c(0,1),
                   labels = c('solteiro', 'casado'))


## Educ: Níveis: 0 EF e 1 EM e 2 SUP
educ <- c(0,0,0,1,0,0,0,0,1,1,1,0,1,0,1,1,2,2)
educ <- factor(educ, levels = c(0,1,2),
               labels = c('EF', 'EM', 'ES'))
table(educ)

## nfil
nfil <- c(NA, 1, 2, NA, NA, 0, NA, NA, 1, NA,
          2, NA, NA, 3, 0, NA, 1, 2)
table(nfil)

## salário
sal <- c(4, 4.56, 5.25, 5.73, 6.26, 6.66, 6.86,
         7.39, 7.59, 7.44, 8.12, 8.46, 8.74,
         8.95, 9.13, 9.35, 9.77, 9.8)

## idade
idade <- c(26,32,36,20,40,28,41,43,34,23,33,27,
           37,44,30,38,31,39)

## região de procedencia
# 0 int, 1 cap, 2 outr
reg <- c(0,1,1,2,2,0,0,1,1,2,0,1,2,2,0,2,1,2)
reg <- factor(reg, levels = c(0,1,2),
              labels = c('interior', 
                         'capital', 
                         'outra'))
table(reg)

# class do reg
class(reg)

## Data frame: banco de dados!
dat <- data.frame(est_civ2, educ, nfil, sal, idade, reg)

## Ver o banco de dados:
View(dat)

# head: seis primeiros casos
head(dat)

# tail: seis ultimos casos
tail(dat)

# ver 10 primeiros casos:
head(dat, 10)

# nova classe: data.frame
class(dat)

# mostra a variável educ
dat$educ # mostra a variável educ
dat[,2] # sintaxe: bco[linhas,colunas]

# 11o caso?
dat[11,]

# a idade do 6o caso?
dat[6,5]
dat[6,'idade']
dat$idade[6]

# selecionar as pessoas 6, 12, 15
dat[c(6,12,15),] # sintaxe: bco[linhas,colunas]

# selecionar as pessoas 6, 12, 15 e idade e salário
dat[c(6,12,15),c('idade', 'sal')] # sintaxe: bco[linhas,colunas]
dat[c(6,12,15),c(5,4)] # sintaxe: bco[linhas,colunas]

## Gráficos:

## var quali
##      est_civ2, educ, e reg
##        Nominal: est_civ2, reg
##        Ordinais: educ
## var quanti
##      nfil, sal, e idade
##        Discreta: nfil, idade
##        Contínua: sal

## unidimensional

## quali
table(est_civ2)

## barplot
barplot(table(est_civ2))

## customizando
barplot(table(est_civ2), 
        main = 'Estado Civil', ylim = c(0,10),
        ylab = 'Frequência', col = 'blue')

## Exercício: barplot de reg
barplot(table(reg), col = rainbow(3))

## pie chart:
pie(table(reg), col = rainbow(3))


