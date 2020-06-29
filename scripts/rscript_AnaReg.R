## Preliminares
data(USArrests)
Chile <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/Chile.csv')
Duncan <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/Duncan.csv')
Anscombe <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/Anscombe.csv')
turnout <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/turnout.csv')
sanction <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/sanction.csv')

##########################
## Análise de Regressão ##
##########################

require(tidyverse)
require(lmtest)
require(car)

x = c(0,1,1,3,4,5,5,6,6,7,8,8,9,9,10,11,12)
y = c(21,20,19,21,24,22,27,27,26,26,25,28,27,29,26,30,29)
plot(x,y,col = 10,pch=16,xlab="variável explicativa", ylab="variável explicada",
     main="Qual a melhor reta que ajusta estes dados?")

#######################################
## Regressão Linear - Duas Variáveis ##
#######################################

# Uma das soluções para este problema é dada
# pela Regressão Linear. Vejamos uma regressão para estes
# dados:

modelo <- lm(y~x)
# Onde 'lm' significa 'linear model', o comando para regressão
# linear e y~x significa y em função de x... Vejamos os resultados:

modelo # Dá o resultado da regressão...

summary(modelo) # Faz os testes preliminares.

# façamos os gráficos para ficar mais intuitivo:

plot(y~x)
abline(modelo) # Plota a reta ajustada...

# O comando 'lm' significa Linear Model e chama a função 
# para fazer a regressão. O parametro ~ informa o console 
# que a variável 'y' será explicada pela variável 'x'. 
# O comando 'abline' plota a reta com o modelo no 
# grafico de dispersão.

# Quase tão importante quanto os dados em si são os resíduos. 
# Uma primeira hipótese para eles é que se distrbuem normalmente.
# Vejamos se isso é verdade:

boxplot(resid(modelo)) # ? mais-ou-menos simétrico... isso é bom...
hist(resid(modelo)) ## ? quase uma normal...

qqnorm(resid(modelo))
qqline(resid(modelo))
# Este é o grafico QQ-Norm. Ele, juntamente com o comando 
# qqline, são usados
# para observarmos se o formato da distribuição 
# é normal... Quanto mais na
# reta, mais normal.

# Um teste formal de normalidade é o shapiro.test:
shapiro.test(resid(modelo)) #H_0: Os dados são normais...

# Portanto o resíduo é normal. O shapiro entretanto é um teste
# qua chamamos de assintótico, ou seja, ele é mais consistente a
# medida que aumentamos a quantidade de dados que dispomos... Em
# geral, a maior parte dos testes estatísticos tem esta propriedade...

# Para usarmos uma plotagem da análise 
# do modelo que seja padrão do R,
# usamos a função plot(modelo) e obtemos
# alguns gráficos de interesse:
par("mfrow"=c(2,2)) # quatro gráficos na mesma tela...
plot(modelo, 1:4) # O R faz até seis. Os quatro primeiros são mais importantes...
par("mfrow"=c(1,1)) # volta as janelas gráficas ao normal...

# O primeiro gráfico é o resíduo contra 
# os valores ajustados do modelo.
# Ele nos dá uma idéia de quanto nosso 
# ajuste é ou não razoável. Ou seja,
# podemos por ele observar se o 
# modelo está bem especificado, se ocorreu
# heterocedasticidade, entre outros...
# O segundo é o qqnorm... Nos dá a idéia 
# de se o dado se distribui normalmente ou não.
# O terceiro é equivalente ao primeiro mas com dados padronizados. Neste,
# o ideal é que os dados sejam uma faixa meio bagunçada 
# entre o zero e o 2 no y...
# O quarto nos dá uma idéia de alavancagem, ou seja, 
# o quanto os dados estão distantes da rera ajustada 
# e, eventualmente, 'puxando' seu valor em alguma
# direção...

# Vejamos outro modelo interessante:
# Questão: Será que a população urbana 
# influencia na taxa de criminalidade?
# Aparentemente, nossa intuição nos diz 
# que quanto maior a população urbana,
# maior também é a taxa de criminalidade.

# O modelo que eu vou propor é 
# Assault~UrbanPop. Ou seja, tentarmos explicar
# o numero de assaltos em função da população 
# urbana no Estado em questão.
# Assim, para realizarmos o ajuste:
modelo <- lm(Assault~UrbanPop, data=USArrests)
modelo # Para ver se ficou bonito...

# Vejamos o modelo por dentro:
summary (modelo)

# Ou seja, o modelo nao esta muito bom... 
# Vejamos a ANOVA:
anova (modelo)

# Uma pergunta que pode surgir: Será que o resíduo é normal?
# Pelo histograma:
dev.off()
hist (resid(modelo)) # nao da para saber direito...

# Note que resid(modelo) é um comando. 
# Ele retorna os resíduos do modelo
# ajustado. Vejamos um gráfico de QQ-Plot:
qqnorm (resid(modelo)); qqline(resid(modelo))

# Bom, é mais-ou-menos normal você não acha? 
# Vamos agora para um teste
# mais formal sobre o assunto:
shapiro.test(resid(modelo))

# É, o resíduo é normal. O que quer dizer que 
# o teste t dos parâmetros
# funciona corretamente.

# Vejamos como se comporta o resíduo graficamente:
plot(modelo, 1)
plot(modelo, 2)
plot(modelo, 3)
plot(modelo, 4)

# Os gráficos evidenciam que temos 
# em geral um bom modelo. O problema é
# que o R2 é baixo e o teste t dos 
# parâmetros foram não significativos.
# Isso quer dizer que o ajuste não é dos melhores...

# Vejamos por ultimo, só por desencargo 
# de consciência, um gráfico dos dados:
plot(Assault~UrbanPop, data=USArrests)
abline(modelo)

# Digamos que quisessemos saber quais 
# os valores encontrados no ajuste,
# que correspondem aos valores do modelo 
# dada a variável independente:
fitted(modelo)

# A mesma coisa para os valores dos res?duos:
resid(modelo)

# Os valores previstos para a m?dia em cada Estado:
predict(modelo, int="c") #int="c": faz o intervalo de confian?a para a m?dia.

# Digamos que queiramos plotar os intervalos de confian?a e predi????o
# para o nosso modelo no gr?fico onde j? plotamos a reta ajustada e
# os dados. O que devemos fazer ent?o ? gerarmos um vetor de dados
# para realizarmos o ajuste:
dados_pred = data.frame(UrbanPop=pretty(USArrests$UrbanPop, 15))

# O comando pretty que é dado dentro do comando para criarmos
# o vetor de dados para que o R calcule as previsões é
# bem interessante.
# Ele basicamente encontra o padrão 
# de variação dos dados e monta um vetor
# que varia próximo dos dados mas com padrão 
# bem ajeitado. Basta olharmos
# o resultado final que ele gera:
dados_pred

# Vamos agora criar o intervalo de predi????o. Note que o comando
# predict funciona em outras situa????es. N?s vamos ver j? outros usos...
# Agora vejamos ele criando um intervalo de predi????o:
intp <- predict(modelo, int="p", newdata=dados_pred)

# Note o parametro 'int="p"'. Isso diz ao R que calcule o intervalo con-
# siderando que seja de predi????o para valores individuais de Assault.
# Os valores correspondentes s?o os constantes em dados_pred.
# Agora vamos fazer o mesmo para o intervalo de confian?a para a m?dia:
intc <- predict(modelo, int="c", newdata=dados_pred)

# Ajustando o dado que temos como data.frame para facilitar:
intp = as.data.frame(intp)
intc = as.data.frame(intc)

# Agora plotando nossos dados no gráfico:
matlines (dados_pred, intp, col=2, lty=3, lwd=2) # Plotando predi????o...
matlines (dados_pred, intc, col="gray70", lty=2, lwd=2) # Plotando confian?a...
abline(modelo, lwd=2)

# Note que o intervalo de confian?a para a m?dia fica bem mais pr?ximo da
# reta ajustada que o intervalo de predi????o. Isso est? de acordo certo?!

# Na pr?tica, este tupo de gr?fico nunca usamos porque s?o raros os pro-
# blemas que envolvem somente duas vari?veis.

# Vamos ent?o agora introduzir alguns testes de hip?teses sobre
# nosso modelo. Para tanto, devemos baixar o pacote 'lmtest'.
# Neste pacote est?o contidos os principais testes que fazemos para
# nossa an?lise de regress?o.
#install.packages(lmtest)
require(lmtest)

# Um procedimento importante na apresenta????o de nossos dados ? o inter-
# valo de confian?a para os par?matros que estimamos. A 95% de confian?a:
confint(modelo)

# Ou seja, os extremos inferiores e superiores dos par?metros estimados 
# dado o nivel de signific?ncia acima. Vejamos se baixarmos o coeficiente
# de confian?a para 0.80:
confint(modelo, level=.8)

# Ou seja, a 0.80, nosso intervalo n?o cont?m o zero e portanto ? significa-
# tivo. Nota: Use este par?metro com cuidado, dependendo do que colocar
# nele, voc? sempre rejeita a hip?tese nula...

# Heterocedasticidade: Um teste importante para heterocedasticidade
# ? o teste de Goldfeld-Quandt. A hip?tese nula deste teste ? a de
# que nao ha heterocedasticidade. Vejamos para o nosso modelo:
gqtest(modelo)

# Ou seja, com p-valor de 0.66, rejeitamos a 
# hip?tese de heterocedasticidade...

# Um outro problema que pode ocorrer ? quanto a especifica????o de
# nosso modelo. Um m?todo bem legal para verificarmos se a especifica????o
# do modelo est? boa ? o 'resettest'. A hip?tese nula do teste ? de que
# o modelo est? bem especificado e a hip?tese alternativa ? de que n?o
# est?. Assim, para nosso modelo:
resettest(modelo)

# Ou seja, o modelo est? bem especificado... Vamos ent?o passar para
# Regress?o com mais de duas vari?veis e da? veremos outros testes...

#######################################
## Regress?o Linear - Mais Vari?veis ##
#######################################

# No Chile, em 1988 houve um plebiscito para votar se Pinochet continuava
# ou n?o no governo. Uma alma caridosa coletou dados sobre este aconteci-
# mento e hoje temos como usar estes dados em aula.

# Vamos observar se o banco ficou bom:
dim(Chile) # 2700 casos e 8 vari?veis... Bom!

# Vamos ver os nomes das vari?veis:
names(Chile)

# Agora o sum?rio do banco:
summary(Chile)

# A minha proposta a voc?s ? modelarmos a escala de apoio ao 'statusquo'
# em fun????o da popula????o, da renda, da idade, e da escolaridade.
# Assim, o modelo fica: statusquo~income+population+age+education...
# Aplicando a formula:
modelo <- lm(statusquo~income+population+age+education, data=Chile)

# Como o banco n?o est? atachado, devemos mandar o R procurar as vari?veis
# no banco Chile, da? o par?metro 'data=Chile'. Vejamos nosso modelo:
modelo

# ? meio dif?cil ler as coisas neste formato. Assim, uma maneira legal ?:
round(coef(modelo), digits=8)

# Agora melhororu um pouco. O comando 'coef' mostra os coeficientes e o
# comando 'round' trunca os dados na quantidade de d?gitos que queremos...

# O sum?rio do modelo:
summary(modelo)

# Ou seja, todos os coeficientes foram significativos menos o intercepto...
# vejamos os gr?ficos padr?o do modelo:
plot(modelo, 1)
plot(modelo, 2)
plot(modelo, 3)
plot(modelo, 4)

# O gr?fico apresenta um padr?o estranho... Bom, quando estamos lidando com
# dados de cross-section em geral podemos encontrar tais problemas.
# estes tipos de dados envolvem muitas vari?veis de unidades diferentes.
# Isso explica o R2 baixo que sempre obtemos.

# Para vermos se o res?duo se distribui normalmente:
shapiro.test(resid(modelo))

# Ou seja, o res?duo n?o ? normal. Os testes qua fazemos sup?e normalidade.
# Isso ? um problema mas, como temos muitos dados, o Teorema do Limite Central
# nos garante que os testes s?o consistente assintoticamente e da?, eles ainda
# s?o v?lidos. Uma tabela de ANOVA para o modelo:
anova(modelo)

# Como temos mais de uma vari?vel explicativa, aparece a possibilidade de 
# termos problemas de multicolineridade. O comando no R para verificarmos
# este problema ? o 'vif': variance inflation factor:
vif(modelo)

# Na pr?tica, cortamos em 10. Algumas pessoas mais rigorosas poderiam cortar
# em um numero menor. O problema ? que, multicolinearidade ? muito comum e
# seu tratamento nunca ? muito simples. Em geral n?o fazemos nada...

# Vamos ent?o testar se o modelo apresenta heterocedasticidade:

# O teste gr?fico: 
plot(modelo, 1)

# Pelo teste gr?fico h? heterocedasticidade. Pelo teste de Goldfeld-Quandt:
gqtest(modelo)

# Ou seja, n?o apresenta... Interessante porque na verdade apresenta.
# Vejamos com outro teste, mais potente: o teste de 
# Breusch-Pagan. A hip?tese nula tamb?m ? n?o apresentar heterocedasticidade:
bptest(modelo)

# Agora apresentou... O que deu errado? Note que n?o existe teste definitivo
# para a Heterocedasticidade ainda porque muitas podem ser as causas dela.
# Assim como a multicolinearidade, a heterocedasticidade s? ? corrigida quando
# temos o problema em larga escala...

# O teste de Goldfeld-Quandt funciona somente quando o padr?o ? 
# acentuadamente diferente em cada categoria. Em todo caso, o 
# 'olhometro' ? uma boa alternativa, pelo menos descritiva...

# Vejamos agora ent?o, se o modelo est? mal especificado por meio
# do teste Reset de Ramsey:
resettest(modelo)

# Ou seja, o modelo est? bem especificado. O problema mesmo ? a hetero-
# cedasticidade...

## Exerc?cio:
# Vamos carregar o banco Anscombe
# U. S. State Public-School Expenditures
head(Anscombe)

# Seu dever ?? formular um modelo para o gasto com educacao...
# 5 minutos... Teste a consist?ncia do modelo...

## Aplicando transforma????es ?s vari?veis:
# Vamos supor que queremos as respostas todas em elasticidade.
# Para obtermos o modelo em elasticidade, teremos que:
modelo<-lm(I(log(education))~I(log(income))+I(log(young))+I(log(urban)), 
           data=Anscombe)
summary(modelo)

# A varia????o dada agora ? em elasticidade. A interpreta????o de cada
# coeficiente de correla????o parcial ? em varia????es percentuais.
# Note a transforma????o 'I'. Usamos esta fun????o para aplicar a fun????o
# log para cada vari?vel e trabalharmos com elasticidade...

## Um modelo mais divertido...
# Vamos estimar o prestigio de profissoes usando dois preditores:
# Vamos para isso usar os dados de Duncan:

# Duncan's Occupational Prestige Data

pairs(Duncan) # Vamos observar alguns padr?es...
row.names(Duncan) <- Duncan$X
Duncan$X <- NULL

# Ou seja, a gra?a neste banco ? que as vari?veis est?o correlacionadas
# entre si e da?, teremos situa????es interessantes para testarmos...
modelo <- lm(prestige~., data=Duncan)

# O ponto depois da regress?o significa que vamos fazer o teste
# de prestige com rela????o ?s outras vari?veis, no caso,
# type, income e education... Vejamos o modelo:
modelo
summary(modelo)

# E observando os erros...
plot(modelo, which=1:4)

# Para observarmos como cada vari?vel se comporta com rela????o
# Ao modelo, usamos o que chamamos de Partial Plots,
# que plota os res?duos contra a vari?vel para testarmos
# o que chamamos tecnicamente de correla????o parcial. Da?,
cr.plots(modelo, ask=F) # Ask =F ? importante!

# Ou seja, ele produz um gr?fico para a correla????o parcial
# de acordo com cada preditor. Isso nos ajuda a ver a influ?ncia
# de cada preditor na variavel explicada...

# Outro teste interessante, ? o de multicolinearidade.
# Podemos fazer para nosso modelo da seguinte forma:
vif(modelo)

# Multicolinearidade acima de 4 j? pode ser considerado problem?tico.
# O corte naturalmente ? arbitr?rio mas geralmente, mais de 10 ? muito ruim
# mesmo, e pode acreditar, isso atrapalha muito... Se formos rigorosos,
# h? uma multicol. bastante elevada nestes dados...

# Para testarmos heterocedasticidade:
gqtest(modelo) # Goldifeld-Quandt... Ou,
bptest(modelo) # Breusch-Pagan...

# Ou seja, esse problema n?o temos... A proxima quest?o ? se o modelo
# est? bem especificado. Vejamos o que nos diz o teste Reset de Ramsey:
resettest(modelo)

# Ou seja, o modelo est? bem especificado. Outra pergunta, diz respeito a se
# o erro se distribui normalmente:
hist(resid(modelo)) # An?lise gr?fica...

# A an?lise formal:
shapiro.test(resid(modelo))

# Ou seja, o erro ? n?o-normal... Vejamos o numero de casos que temos:
dim(Duncan)

# Com 45 dados, os testes t n?o valem. Unica coisa que fizemos foi estimar
# bons par?metros. N?o temos subs?dios estat?sticos para testarmos suas
# hip?teses...

# Um exemplo mais complexo para regress?o m?ltipla

# Vejamos um exemplo de aplica????o real
# race composi????o racial em porcentagem de minorias
# fire inc?ndios por 100 unidades habitacionais
# theft roubo por 1000 habitantes
# age porcentagem de unidades habitacionais construidas antes de 1939
# volact novas pol?ticas para propriet?rios mais renova????es menos cancelamentos e n?o renova????es por 100 unidades habitacionais
# involact novas fair policies e renova????es por 100 unidades habitacionais
# renda renda familiar mediana

# We choose the involuntary market activity variable 
# (the number getting FAIR plan insurance) as the response 
# since this seems to be the best measure of those who are denied 
# insurance by others. It is not a perfect measure because some who are
# denied insurance may give up and others still may not try at all for 
# that reason. The voluntary market activity variable is not as relevant.

# vamos inserir um conjunto de dados

race = c(10,22.2,19.6,17.3,24.5,54,4.9,7.1,5.3,21.5,43.1,1.1,1,1.7,1.6,1.5,1.8,1,2.5,13.4,59.8,94.4,86.2,50.2,74.2,55.5,62.3,4.4,46.2,99.7,73.5,10.7,1.5,48.8,98.9,90.6,1.4,71.2,94.1,66.1,36.4,1,42.5,35.1,47.4,34,3.1)
fire = c(6.2,9.5,10.5,7.7,8.6,34.1,11,6.9,7.3,15.1,29.1,2.2,5.7,2,2.5,3,5.4,2.2,7.2,15.1,16.5,18.4,36.2,39.7,18.5,23.3,12.2,5.6,21.8,21.6,9,3.6,5,28.6,17.4,11.3,3.4,11.9,10.5,10.7,10.8,4.8,10.4,15.6,7,7.1,4.9)
theft = c(29,44,36,37,53,68,75,18,31,25,34,14,11,11,22,17,27,9,29,30,40,32,41,147,22,29,46,23,4,31,39,15,32,27,32,34,17,46,42,43,32,19,25,28,3,23,27)
age = c(60.4,76.5,73.5,66.9,81.4,52.6,42.6,78.5,90.1,89.8,82.7,40.2,27.9,7.7,63.8,51.2,85.1,44.4,84.2,89.8,72.7,72.9,63.1,83,78.3,79,48,71.5,73.1,65,75.4,20.8,61.8,78.1,68.6,73.4,2,57,55.9,67.5,58,15.2,40.8,57.8,11.4,49.2,46.6)
involact = c(0,0.1,1.2,0.5,0.7,0.3,0,0,0.4,1.1,1.9,0,0,0,0,0,0,0,0.2,0.8,0.8,1.8,1.8,0.9,1.9,1.5,0.6,0.3,1.3,0.9,0.4,0,0,1.4,2.2,0.8,0,0.9,0.9,0.4,0.9,0,0.5,1,0.2,0.3,0)
income = c(11744,9323,9948,10656,9730,8231,21480,11104,10694,9631,7995,13722,16250,13686,12405,12198,11600,12765,11084,10510,9784,7342,6565,7459,8014,8177,8212,11230,8330,5583,8564,12102,11876,9742,7520,7388,12842,11040,10332,10908,11156,13323,12960,11260,10080,11428,13731)

# formar uma base de dados com os dados
chicago = data.frame(race,age,fire,theft,involact,income)
rm(race, fire, theft, age, involact, income) # limpando o lixo...

# vamos obter um sum?rio do banco de dados
summary(chicago)

pairs(chicago, gap=0) # temos algumas rela????es...

# Vamos ent?o compor o modelo:
modelo=lm(involact~.,data=chicago)
summary(modelo)
plot(modelo, 1)
plot(modelo, 2)

# O modelo esta deixando um pouco a desejar... Vamos selecionar entao 
# as variaveis que sao mais relevantes usando a fun????o step (funciona
# como o stepwise do SPSS...):

modelo_step <- step(modelo)
modelo_step

# Ou seja, deu uma melhorada...
plot(modelo, which=1:4)

# Testando a hipotese de normalidade do erro...
shapiro.test(resid(modelo))

# O modelo esta bom quanto a normalidade do residuo...

# Heterocedasticidade:
gqtest (modelo) # Tambem e homocedastico...

# Multicolinearidade:
vif(modelo) # Ok...

# Correlações parciais...
library(car)
crPlots(modelo, ask=F)

# Teste de especificação de Ramsey:
resettest(modelo)

#############################
## Outros Modelos Lineares ##
#############################

## Regressao que passa pela Origem
# Para usarmos este modelo devemos ter expectativas fortes de que
# a priori, nosso modelo ira passar pela origem.
# Vamos supor que no modelo de prest?gio das profiss?es,
# nosso modelo passe pela origem (dado que a origem nao foi significa-
# tiva). Assim, na montagem do modelo, incluimos '-1' na formula...
# este eh o comando para regressao deste formato funcional:

modelo <- lm(prestige~-1+., data=Duncan)

# Vejamos agora o modelo...
modelo
summary(modelo)

# Note que o R2 subiu. Isso em geral acontece porque ele nao eh mais
# corrigido pela midia de y. O problema eh que este R2 nao pode ser comparado
# com o R2 de regressoes normais chamamos de R2 bruto...

## Regress?o Polinomial:
# Vamos montar um conjunto de dados sobre custo de produ????o:
Prod = c(1:10)
Val = c(193, 226, 240, 244, 257, 260, 274, 297, 350, 420)

# Vejamos o conjunto montado:
plot(Val~Prod) # Estes dados sao claramente nao-lineares...

# Vejamos o que acontece com um ajuste linear nos dados:
modelo <- lm(Val~Prod)
modelo
summary(modelo)

# Ou seja, os coeficientes sao significativos mas o erro, apresenta um 
# grave padrao:
plot(modelo, 1)

# Um teste formal para se o modelo foi bem especificado:
resettest(modelo)

# Ou seja, conforme esperado, o modelo 
# não foi bem especificado...
# Vamos então ajustar por uma quadrática:
modelo <- lm(Val~Prod+I(Prod^2))
summary(modelo)

# E realizando os outros testes:
plot(modelo, 1)
resettest(modelo)

# Novamente o modelo não é bom... Vejamos então uma cúbica:
modelo <- lm(Val~Prod+I(Prod^2)+I(Prod^3))
summary(modelo)

# Agora o modelo parece bom. Outros testes:
plot(modelo, 1)
resettest(modelo)

# Ou seja, o modelo correto para 
# estes dados é o modelo cúbico.

## Modelo para dados Exponenciais:
# Em geral, os outros modelos lineares 
# consistem em 'linearizarmos' outras
# relações entre os dados. As relações 
# são, naturalmente, lineares nos
# parametros e não nas variáveis. 
# Vejamos um modelo exponencial:

# Population of the United States
data(USPop) # dados para população nos EUA...

# O que tem nesse banco?
help("USPop")

summary(USPop)
# Ou seja, um banco normal com população x ano... 
# Vejamos então um gráfico:
plot(USPop)

# Um modelo que captura estes dados é:
modelo <- lm(population~year, data=USPop)
modelo
summary(modelo)
plot(modelo,1)

# Qual o problema deste modelo? O fato de ele ser não-linear 
# nas variáveis...
# Vejamos o modelo correto:
modelo <- lm(I(log(population))~year, data=USPop)
modelo
summary(modelo)

# The end...