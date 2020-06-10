## Dados exercício
prim <- c(2, 2.5, 2.9, 3.3, 4.1, 4.3, 7, 13)
analf <- c(17.5, 18.5, 19.5, 22.2, 26.5, 16.6, 36.6, 38.4)

plot(analf~prim)

prim - mean(prim)
analf - mean(analf)

(prim - mean(prim))/sd(prim)
(analf - mean(analf))/sd(analf)

(prim - mean(prim))/sd(prim)*(analf - mean(analf))/sd(analf)

sum((prim - mean(prim))/sd(prim)*(analf - mean(analf))/sd(analf))

cor(prim, analf)

dat <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/tab21bm.csv', skip = 1)
head(dat)

library(tidyverse)
dat <- dat %>%
  select(-N) %>%
  rename(estciv = Estado.Civil,
         idade = Anos,
         reg = Região.de.Procedência)

boxplot(idade~estciv, data=dat)

mod <- aov(idade~estciv, data=dat)
anova(mod)

TukeyHSD(mod)

boxplot(idade~reg, data=dat)

mod <- aov(idade~reg, data=dat)
anova(mod)

TukeyHSD(mod)
plot(TukeyHSD(mod))

dat <- read.csv('https://raw.githubusercontent.com/umbertomig/cap-pesquisa-experimental/master/bancos_de_dados/voteincome.csv')
head(dat)

dat$vote <- factor(dat$vote, labels = c('Não Votou', 'Votou'))
dat$education <- factor(dat$education, 
                        labels = c('Fundamental',
                                   'Médio',
                                   'Superior',
                                   'Pós'))
dat$female <- factor(dat$female, labels = c('Não', 'Sim'))
head(dat)

## Estado x Voto
tab <- table(dat$state, dat$vote)
round(prop.table(tab, 1), 4)*100

# Observado
chisq.test(tab)$observed

# Esperado
chisq.test(tab)$expected

# Resíduo
chisq.test(tab)$residual

chisq.test(tab)$statistic

## Educação x Voto
tab <- table(dat$education, dat$vote)
tab
round(prop.table(tab, 1), 4)*100

# Observado
chisq.test(tab)$observed

# Esperado
chisq.test(tab)$expected

# Resíduo
chisq.test(tab)$residual

chisq.test(tab)$statistic

## Idade x Voto
boxplot(age~vote, data=dat)

mod <- aov(age~vote, data=dat)

summary(mod)

## Idade x Renda
plot(income~age, data=dat)
