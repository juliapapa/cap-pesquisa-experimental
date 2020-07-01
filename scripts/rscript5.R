## Preliminares
Pinf <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/pinf.csv')
vinc <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/voteincome.csv')
data(USArrests)
Chile <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/Chile.csv')
Duncan <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/Duncan.csv')
Anscombe <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/Anscombe.csv')
turnout <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/turnout.csv')
sanction <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/sanction.csv')

#########################
## Teste de Hip?teses: ##
#########################
# Vamos agora para o que interessa: Nossa primeira hip?tese:

# Grafico:
Pinf$y <- factor(Pinf$y, 
                 levels = c("Very Low",
                            "Fairly Low", 
                            "Average", 
                            "Fairly High", 
                            "Very High"))
mosaicplot(y~collegeDegree, data=Pinf)

# exercício: organize os níveis de y

# Suposição: existe uma relação entre escolaridade e informação política.
# Hipótese: quanto maior a escolaridade mais interesse por política.
attach(Pinf)

# Para testa-la, vamos escreve-la como uma tabela:
thip1 <- table(collegeDegree,y)
thip1

# Em propor????o teriamos:
prop.table(thip1,2) # Pelo total-linha logicamente...

# Ou seja, cresce a propor????o de interessados por pol?tica quando aumentamos a
# escolaridade. Dai:

# Logica do teste:
# Hipotese nula: Nao ha relação entre escolaridade e interesse por pol?tica;
# Hip?tese alternativa: h? rela????o;
# Teste para o caso: Duas categ?ricas: teste de Qui-Quadrado:
chisq.test(thip1)

# Algo que podemos querer observar: residuos:
chisq.test(thip1)$residuals

# Outra coisa: valores observados e esperados:
chisq.test(thip1)$observed
chisq.test(thip1)$expected

# Todos os componentes do nosso teste:
summary(thip1)

# Ou seja, como o p-valor ? baix?ssimo, aceitamos a hip?tese alternativa.

## Segundo teste:
boxplot(age~y, data=Pinf)

# Suposi????o: existe uma rela????o entre idade e informa????o pol?tica.
# Hip?tese: quanto maior a idade mais interesse por pol?tica.

# Podemos proceder de duas formas: ou segmentamos a vari?vel idade e 
# fazemos um teste de Qui-Quadrado, ou fazemos o que chamamos de
# Analise de Vari?ncia (ANOVA). O primeiro fica de exerc?cio.
# O segundo vai sair agora:

# Hip?tese nula: A m?dia de idade ? a mesma em todos os grupos.
# Hip?tese alternativa: em pelo menos um grupo a m?dia de idade ? 
# diferente.
minha_anova <- aov(age~y, data=Pinf)
minha_anova

# Agora para vermos nossa estat?stica de interesse:
anova(minha_anova)

# Se quisermos identificar o subgrupo onde isso acontece:
TukeyHSD(minha_anova)

# Graficamente temos:
plot(TukeyHSD(minha_anova))

# Uma hip?tese subjacente ? ANOVA ? que a vari?ncia entre os grupos ?
# homog?nea. Chamamos isso de homocedasticidade. Para testar se isso ?
# verdadeiro:

# H_zero: é igual (homocedasticidade)
# H_a: é diferente (heterocedasticidade)

bartlett.test(age~y, data=Pinf)

# Ou seja, heterocedasticidade...
# Como n?o temos uma das hipoteses corretas, devemos usar o operador:
oneway.test(age~y, data=Pinf)

# Ou seja, as m?dias entre os grupos n?o s?o iguais... definitivamente

# Rejeitamos a hipotese nula.

## Outro teste...
mosaicplot(education~vote, data=vinc)

# E agora nossa tabela fica:
tabela <- xtabs(~vote+education, data=vinc)
tabela

chisq.test(tabela)

# E o mosaico:
mosaicplot(female~vote, data=vinc)

tabela <- xtabs(~vote+female, data=vinc)
chisq.test(tabela)

# Suposi????o: Existe uma rela????o entre voto, sexo e educa????o.
# Pela analise do grafico, sexo n?o ? um bom controle.
# Saindo sexo, temos uma hip?tese: educa????o influencia na atitude de votar.

# Hip?tese nula: escolaridade n?o influencia no voto
# Hip. Alternativa: Escolaridade influencia no voto.

# Que teste que precisamos para o caso?

# Resposta:
chisq.test(tabela) # Hipotese nula nao serviu...

# exercício
tab <- table(Chile$education, Chile$vote)
mosaicplot(tab)
chisq.test(tab)

## Vejamos outro teste de hip?tese...
# Como sempre come?amos pela an?lise gr?fica
plot(Murder~Assault, data=USArrests)
plot(Murder~Rape, data=USArrests)
plot(Assault~Rape, data=USArrests)
plot(Murder~UrbanPop, data=USArrests) 

# Suposi????o: as vari?veis escolhidas est?o correlacionadas.
# Hip?tese: quando eu aumento uma delas as outras aumentam.

# A correla????o entre elas ?:
cor(USArrests)

# Pergunta: como afirmar que estas correla????es s?o validas?
# Com infer?ncia!

attach(USArrests)
# Hip?tese nula: Correla????o entre UrbanPop e Murder ? igual a zero
# Hip?tese alternativa: ? diferente de 0.
cor.test(UrbanPop, Murder)
cor.test(UrbanPop, Murder, method="spearman")
cor.test(UrbanPop, Murder, method="kendall")

# Todos os p-valores foram alt?ssimos,
# ou seja, aqui temos um caso onde nossa hip?tese n?o foi corroborada.
# Exerc?cio: teste os outros casos: Murder com Assault, Assault com Rape e
# Rape com Murder... (3 min)
cor.test(Murder, Assault)
cor.test(Rape, Assault)
cor.test(Murder, Rape)

# Evitando tumulto...
detach(USArrests)

## Testes para as m?dias:
# Hip?tese:
boxplot (age~vote, data=vinc)

# Ou seja, se h? diferen?a entre a m?dia de idade do sujeito que vota em
# compara????o do que o que n?o vota.
# Hip?tese: h? diferen?a.

# H_zero: n?o h? diferen?a
# H_a: h? diferen?a

t.test(age~vote, data=vinc)

# E agora? Qual a nossa conclus?o? Depende do nosso alfa.
# Se nosso nivel de significancia ? .10, a hip?tese ? valida.
# Se menor, a hip?tese n?o ? valida...

# Se quisermos reformular a hip?tese:
# H_zero: n?o h? diferen?a
# H_a: diferen?a de idade positiva (quem vota ? mais velho)

t.test(age~vote, data=vinc, alternative="less")

# O uso ? o seguinte:
# Se a m?dia no primeiro grupo for maior, usamos alternative="greater";
# se a m?dia no segundo for maior, alternative="less".

## Teste de variancias:

## Teste para as veri?ncias:
# ? importante saber se a vari?ncia se comporta de modo igual nos niveis
# principalmente porque isso ajuda a dar poder a um teste, por exemplo, de
# diferen?a de m?dias. Vamos motivar com dados:
boxplot(income~vote, data=turnout)

# Ou seja, a variabilidade de ambos parece ser bem diferente...
# So...
# H_zero: razao da variabilidade = 1
# H_a: razao diferente de 1

var.test(income~vote, data=turnout)

# Ou seja, a vari??ncia do segundo eh maior que a dor primeiro...
attach(turnout)
var(income[vote==0])
var(income[vote==1])
detach(turnout)

## Teste para m?dia com vari??ncia desigual:
# Vamos testar a hip?tese, para os dados acima, de que h? diferen?a na renda
# com rela????o ao voto. Da?:
boxplot (income~vote, data=turnout)

# H_zero: n?o h? diferen?a
# H_a: diferen?a positiva (quem vota tem mais renda)

# Como j? sabemos que a vari?ncia ? desigual:
t.test(income~vote, data=turnout, alternative="less", var.equal=F)

# Repare na diferen?a, principalmente no intervalo de confian?a:
t.test(income~vote, data=turnout, alternative="less", var.equal=T)

# Ou seja, quanto mais informa????o, maior a precis?o.

## Teste de normalidade:
# At? aqui, no teste para as m?dias supomos que a distribui????o dos dados ?
# normal. Isso deve tamb?m ser checado. O teste usado ? o shapiro.test(...)
# Um grafico para isso:
attach(turnout)

qqnorm(income[vote==0])
qqline(income[vote==0], col=2)

qqnorm(income[vote==1])
qqline(income[vote==1], col=2)

# Se fossem normais, ficariam em cima da linha...

# H_zero: ? normal
# H_a: n?o ? normal

shapiro.test(income[vote==0])
shapiro.test(income[vote==1])

detach(turnout)
# Ou seja, nenhum dos dois s?o normais.

# Exerc?cio: fa?a isso para este conjunto de dados (3 min):
boxplot (age~vote, data=vinc)

# Resposta:
attach(vinc)
qqnorm(age[vote==0]); qqline(age[vote==0], col=4)
qqnorm(age[vote==1]); qqline(age[vote==1], col=4)
shapiro.test(age[vote==0])
shapiro.test(age[vote==1])
detach(vinc)

# S? por quest?o de honra, vamos 'criar' um conjunto de dados normais
meus_dados = rnorm(2000, mean=5, sd=7)
hist(meus_dados) # T? bonito...
boxplot(meus_dados)

qqnorm(meus_dados); qqline(meus_dados, col=2) # T? lindo...

# H_zero: ? normal
# H_a: n?o ? normal

shapiro.test(meus_dados)

# Este teste n?o ? muito bom, mas para conjuntos de dados menores que 5000
# observa????es ele funciona legal.

## Testes n?o param?tricos (n?o normais)
# Usados para quando n?o temos distribui????es normais.
# Na pr?tica, n?o param?tricos significa livre de distribui????o...

# Para nossos exemplos acima, encontramos que a distribui????o normal n?o ? uma
# boa... Vamos ent?o usar teste de Wilcoxon:
boxplot (income~vote, data=turnout)

# H_zero: a estat?stica de posto apontam para a igualdade de m?dias
# H_a: apontam para diferen?a das m?dias
wilcox.test(income~vote, data=turnout)

# Ou seja, n?o adianta teimar, as m?dias s?o diferentes...

## Anova n?o param?trica: Kruskal-Wallis
# Relembrando do nosso conjunto de dados acima referido:
boxplot(y~age, data=Pinf)

# H_zero: N?o h? diferen?a na m?dia de idade quando controlamos o interesse
# por pol?tica;
# H_a: H? diferen?a de idade
kruskal.test(age~y, data=Pinf)

# Ou seja, H_a ? o que manda...

##########################
## An?lise de Regress?o ##
##########################

x = c(0,1,1,3,4,5,5,6,6,7,8,8,9,9,10,11,12)
y = c(21,20,19,21,24,22,27,27,26,26,25,28,27,29,26,30,29)
plot(x,y,col = 10,pch=16,xlab="vari?vel explicativa", ylab="vari?vel explicada",
     main="Qual a melhor reta que ajusta estes dados?")

#######################################
## Regress?o Linear - Duas Vari?veis ##
#######################################

# Uma das solu????es para este problema ? dada
# pela Regress?o Linear. Vejamos uma regress?o para estes
# dados:

modelo <- lm(y~x)
# Onde 'lm' significa 'linear model', o comando para regress?o
# linear e y~x significa y em fun????o de x... Vejamos os resultados:

modelo # D? o resultado da regress?o...

summary(modelo) # Faz os testes preliminares.

# fa?amos os gr?ficos para ficar mais intuitivo:

plot(y~x)
abline(modelo) # Plota a reta ajustada...

# O comando 'lm' significa Linear Model e chama a fun????o para fazer a
# regress?o. O parametro ~ informa o console que a vari?vel 'y' ser?
# explicada pela vari?vel 'x'. O comando 'abline' plota a reta com
# o modelo no grafico de dispers?o.

# Quase t?o importante quanto os dados em si s?o os res?duos. 
# Uma primeira hip?tese para eles ? que se distrbuem normalmente.
# Vejamos se isso ? verdade:

boxplot(resid(modelo)) # ? mais-ou-menos sim?trico... isso ? bom...
hist(resid(modelo)) ## ? quase uma normal...

qqnorm(resid(modelo))
qqline(resid(modelo))
# Este ? o grafico QQ-Norm. Ele, juntamente com o comando qqline, s?o usados
# para observarmos se o formato da distribui????o ? normal... Quanto mais na
# reta, mais normal.

# Um teste formal de normalidade, j? abordado ? o shapiro.test:
shapiro.test(resid(modelo)) #H_0: Os dados s?o normais...

# Portanto o res?duo ? normal. O shapiro entretanto ? um teste
# qua chamamos de assint?tico, ou seja, ele ? mais consistente a
# medida que aumentamos a quantidade de dados que dispomos... Em
# geral, a maior parte dos testes estat?sticos tem esta propriedade...

# Para usarmos uma plotagem da an?lise do modelo que seja padr?o do R,
# usamos a fun????o plot(modelo) e obtemos alguns gr?ficos de interesse:
par("mfrow"=c(2,2)) # quatro gr?ficos na mesma tela...
plot(modelo, 1:4) # O R faz at? seis. Os quatro primeiros s?o mais importantes...
par("mfrow"=c(1,1)) # volta as janelas gr?ficas ao normal...

# O primeiro gr?fico ? o res?duo contra os valores ajustados do modelo.
# Ele nos d? uma id?ia de quanto nosso ajuste ? ou n?o razo?vel. Ou seja,
# podemos por ele observar se o modelo est? bem especificado, se ocorreu
# heterocedasticidade, entre outros...
# O segundo ? o qqnorm... Nos d? a id?ia de se o dado se distribui normal-
# mente ou n?o.
# O terceiro ? equivalente ao primeiro mas com dados padronizados. Neste,
# o ideal ? que os dados sejam uma faixa meio bagun?ada entre o zero e o
# 2 no y...
# O quarto nos d? uma id?ia de alavancagem, ou seja, o quanto os dados est?o
# distantes da rera ajustada e, eventualmente, 'puxando' seu valor em alguma
# dire????o...

# Vejamos outro modelo interessante:
# Quest?o: Ser? que a popula????o urbana influencia na taxa de criminalidade?
# Aparentemente, nossa intui????o nos diz que quanto maior a popula????o urbana,
# maior tamb?m ? a taxa de criminalidade.

# O modelo que eu vou propor ? Assault~UrbanPop. Ou seja, tentarmos explicar
# o numero de assaltos em fun????o da popula????o urbana no Estado em quest?o.
# Assim, para realizarmos o ajuste:
modelo <- lm(Assault~UrbanPop, data=USArrests)
modelo # Para ver se ficou bonito...

# Vejamos o modelo por dentro:
summary (modelo)

# Ou seja, o modelo nao esta muito bom... Vejamos a ANOVA:
anova (modelo)

# Uma pergunta que pode surgir: Ser? que o res?duo ? normal?
# Pelo histograma:
dev.off()
hist (resid(modelo)) # nao da para saber direito...

# Note que resid(modelo) ? um comando. Ele retorna os res?duos do modelo
# ajustado. Vejamos um gr?fico de QQ-Plot:
qqnorm (resid(modelo)); qqline(resid(modelo))

# Bom, ? mais-ou-menos normal voc? n?o acha? Vamos agora para um teste
# mais formal sobre o assunto:
shapiro.test(resid(modelo))

# ?, o res?duo ? normal. O que quer dizer que o teste t dos par?metros
# funciona corretamente.

# Vejamos como se comporta o res?duo graficamente:
plot(modelo, 1:4)

# Os gr?ficos evidenciam que temos em geral um bom modelo. O problema ?
# que o R2 ? baixo e o teste t dos par?metros foram n?o significativos.
# Isso quer dizer que o ajuste n?o ? dos melhores...

# Vejamos por ultimo, s? por desencargo de consci?ncia, um gr?fico dos dados:
plot(Assault~UrbanPop, data=USArrests)
abline(modelo)

# Digamos que quisessemos saber quais os valores encontrados no ajuste,
# que correspondem aos valores do modelo dada a vari?vel independente:
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

# O comando pretty que ? dado dentro do comando para criarmos
# o vetor de dados para que o R calcule as previs?es ? bem interessante.
# Ele basicamente encontra o padr?o de varia????o dos dados e monta um vetor
# que varia pr?ximo dos dados mas com padr?o bem ajeitado. Basta olharmos
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

# Agora plotando nossos dados no gr?fico:
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
plot(modelo, 1:4)

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
plot(modelo, 1:2)

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

# Correla????es parciais...
library(car)
crPlots(modelo, ask=F)

# Teste de especifica????o de Ramsey:
resettest(modelo)

# Ou seja, temos um modelo bom para colocarmos em um artigo...

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

# Ou seja, conforme esperado, o modelo n??o fora bem especificado...
# Vamos ent??o ajustar por uma quadr?tica:
modelo <- lm(Val~Prod+I(Prod^2))
summary(modelo)

# E realizando os outros testes:
plot(modelo, 1)
resettest(modelo)

# Novamente o modelo n??o ? bom... Vejamos ent??o uma c?bica:
modelo <- lm(Val~Prod+I(Prod^2)+I(Prod^3))
summary(modelo)

# Agora o modelo parece bom. Outros testes:
plot(modelo, 1)
resettest(modelo)

# Ou seja, o modelo correto para estes dados ? o modelo c?bico.
# Note que a teoria economica sobre o assunto j? era clara neste ponto...

## Modelo para dados Exponenciais:
# Em geral, os outros modelos lineares consistem em 'linearizarmos' outras
# rela????es entre os dados. As rela????es s??o, naturalmente, lineares nos
# parametros e n??o nas vari?veis. Vejamos um modelo exponencial:

# Population of the United States
data(USPop) # dados para popula????o nos EUA...

# O que tem nesse banco?
help("USPop")

summary(USPop)
# Ou seja, um banco normal com popula????o x ano... Vejamos ent??o um gr?fico:
plot(USPop)

# Um modelo que capta estes dados ?:
modelo <- lm(population~year, data=USPop)
modelo
summary(modelo)
plot(modelo,1)

# Qual o problema deste modelo? O fato de ele ser n??o-linear nas vari?veis...
# Vejamos o modelo correto:
modelo <- lm(I(log(population))~year, data=USPop)
modelo
summary(modelo)

# The end...