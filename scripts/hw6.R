## Baixar o arquivo e ler os dados
library(readxl)
library(tidyverse)

dat <- read_csv(url('https://brasil.io/dataset/covid19/caso_full/?format=csv')) %>%
  data.frame()

head(dat)
tail(dat)

## Descritivas
table(dat$place_type)

## Limpar banco

## tratar dados
dat <- dat %>%
  select(epiWeek = epidemiological_week, # selecionar vars
         date, state, city, codmun = city_ibge_code,
         place_type, newCases = new_confirmed,
         newDeaths = new_deaths,
         pop = estimated_population_2019) %>%
  filter(place_type == 'city')

head(dat)
dim(dat)

# 1. criar a estat de casos acumulados (por munic)
# 2. calcular taxas por município

dat <- dat %>%
  group_by(codmun) %>%
  summarize(
    city = first(city),
    state = first(state),
    pop = first(pop),
    cumCases = sum(newCases),
    cumDeaths = sum(newDeaths)) %>%
  mutate(caseRate = (cumCases/pop)*100000,
         morbRate = (cumDeaths/pop)*100000,
         deathRate = (cumDeaths/cumCases)*100)
  

  
  