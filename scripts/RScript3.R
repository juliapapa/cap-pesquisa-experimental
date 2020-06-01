## Operadores condicionais

# Condicional binário
# ifelse(condição_de_teste, faz_se_verdadeiro, faz_se_falso)
n = 4
ifelse(n>2, n^2, n/5)

n = 1
ifelse(n>2, n^2, n/5)

n = 2
ifelse(n>2, n^2, n/5)

## não preciso interagir com a condição
n = 2
ifelse(n>2, 'maior que dois', 'menor ou igual a dois')

## genero: operação vetorizada
gen <- c(0,0,0,1,1,0,1,1,1,0)
ifelse(gen == 1, 'Fem', 'Masc')

## genero: operação vetorizada
gen <- c(0,0,2,1,1,2,1,1,1,0)
ifelse(gen == 1, 'Fem', ifelse(gen == 0, 'Masc', 'Não masc nem fem'))

## regiões
# 1: RM
# 2: Capital
# 3: Interior
# 4: Estrangeiro
reg <- c(1,2,3,1,2,3,4,4,1,2,3,3,2,1,4,1)
ifelse(reg==1, 'RM', ifelse(reg==2, 'Capital', ifelse(reg==3, 'Interior', 'Estrangeiro')))

## regiões
# 1: RM
# 2: Capital
# 3: Interior
# 4: Estrangeiro
reg = 1

# Sintaxe:
# if (cond1_teste) {
#   codigo_rodar_cond1_verdadeira
# } else if (cond2_teste) {
#   codigo_rodar_cond2_verdadeira
# } else { ## Quando qualquer outra condição for inválida.
#   codigo_rodar_qdo_resto_falso
# }
reg=2
if (reg == 1) {
  print('O sujeito mora na RM!')
} else {
  print('O sujeito não mora na RM!')
}

## regiões
# 1: RM
# 2: Capital
# 3: Interior
# 4: Estrangeiro
# qualquer outra coisa: numero invalido!
reg = 20
if(reg==1) {
  print('RM')
} else if (reg==2) {
  print('Capital')
} else if (reg==3) {
  print('Interior')
} else if (reg==4) {
  print('Estrangeiro')
} else {
  print('Numero inválido!')
}

reg = 6
if(reg==1) {
  print('RM')
} else if (reg==2) {
  print('Capital')
} else if (reg==3) {
  print('Interior')
} else if (reg==4) {
  print('Estrangeiro')
} else {
  print('Numero inválido!')
}

## Criar funções
# nome_da_funcao <- function(para1, para2, para3, ...) {
#   codigo_que_vc_quer_executar
#   return(alguma_coisa_que_a_func_quer_retornar)
# }
nome_reg <- function(reg) {
  if(reg==1) {
    return('RM')
  } else if (reg==2) {
    return('Capital')
  } else if (reg==3) {
    return('Interior')
  } else if (reg==4) {
    return('Estrangeiro')
  }
  return('Numero inválido!')
}

# Ex: faça a função virar vetorizada
reg <- c(1,2,3,1,2,3,4,4,1,2,3,3,2,1,4,1, 50, 20, 22)
nome_reg2 <- function(reg_vec) {
  return(ifelse(reg_vec==1, 'RM', 
                ifelse(reg_vec==2, 'Capital',
                       ifelse(reg_vec==3, 'Interior',
                              ifelse(reg_vec == 4, 'Estrangeiro', 'Numero Invalido')))))
}
nome_reg2(reg)

## controle de fluxo

# while
i = 1
while(TRUE) {
  print(i)
  print('i é menor que dez!')
  print(i^10)
  i = i+1
  if(i == 50) return('Acabei!')
}

# for
for (i in 1:10) {
  print(i)
  print(i^5)
}

# crie uma função que:
# A. receba o seguinte vetor
reg <- c(1,2,3,1,2,3,4,4,1,2,3,3,2,1,4,1, 50, 20, 22)
# B. retorne, para cada elemento do vetor, o seguinte:
# 1: RM
# 2: Capital
# 3: Interior
# 4: Estrangeiro
# qualquer outra coisa: numero invalido!
# C. Não use ifelse!
nome_reg3 <- function(rv) {
  print('Entrei na função!')
  aux <- character()
  pos = 1
  for (i in rv) {
    cat('A pos = ', pos, 'E o i = ', i, '\n')
    aux[pos] = nome_reg(i)
    pos = pos+1
  }
  print('Acabei o for!')
  return(aux)
}
nome_reg3(reg)

# 1,2,3,4,5,6,7
# 1 = extremamente nacionalista
# 7 = extremamente não-nacionalista
v <- c(1,2,3,1,2,3,7,6,5,4,5,2,99)

