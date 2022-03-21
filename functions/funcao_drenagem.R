
read_db_dr <- function(
  path = "dados/DEFICIT_DRENAGEM_2020_R1_v2.xlsx",
  sheet = "ESTADOS"){
  
  if(sheet %in% c("BRASIL", "REGIÃO","ESTADOS",                        
                  "FAIXA POPULACIONAL","dados_populacao",
                  "Faixa_Populacional_estado_forms","Faixa_Populacional_Estado",
                  "RM_nao_capital","RM_capital")){
    data <- readxl::read_xlsx(path, sheet = sheet)
    data <- data %>% janitor::clean_names()
  } else{
    print('Planilha nao localizada')
    data <- NULL
  }
  return(data)
}

#### Filtragem Banco de dados

filter_db_dr <- function(
  sheet="ESTADOS",
  UF = c("AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT",
         "PA","PB","PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO"),
  regiao = c("Norte","Nordeste","Sudeste","Sul","Centro-Oeste"),
  faixa = c(1,2,3,4,5,6),
  RM = c("RM - Região Metropolitana do Vale do Rio Cuiabá",
         "RM - Região Metropolitana do Sertão",
         "RM - Região Metropolitana do Vale do Paraíba",
         "RM - Região Metropolitana de Palmeira dos Índios",
         "RM - Região Metropolitana do Médio Sertão",
         "RM - Região Metropolitana do Agreste",
         "RM - Região Metropolitana de Caetés",
         "RM - Região Metropolitana da Zona da Mata",
         "RM - Região Metropolitana do São Francisco",
         "RM - Região Metropolitana do Agreste",
         "RM - Região Metropolitana do Vale do Paraíba",
         "RM - Região Metropolitana de Feira de Santana",
         "RIDE - Região Administrativa Integrada de Desenvolvimento do Polo",
         "RM - Região Metropolitana de Sobral",
         "RM - Região Metropolitana do Cariri",
         "RM - Região Metropolitana do Sudoeste Maranhense",
         "RM - Região Metropolitana do Vale do Piancó",
         "RM - Região Metropolitana de Campina Grande",
         "RM - Região Metropolitana de Esperança",
         "RM - Região Metropolitana de Guarabira",
         "RM - Região Metropolitana de Patos",
         "RM - Região Metropolitana de Barra de Santa Rosa",
         "RM - Região Metropolitana de Cajazeiras",
         "RM - Região Metropolitana do Vale do Mamanguape",
         "RM - Região Metropolitana de Araruna",
         "RM - Região Metropolitana de Itabaiana",
         "RM - Região Metropolitana de Sousa",
         "RM - Região Metropolitana de Santarém",
         "RM - Região Metropolitana de Central",
         "RM - Região Metropolitana do Sul do Estado",
         "RM - Região Metropolitana do Gurupi",
         "RM - Região Metropolitana do Vale do Aço",
         "AGLO - Aglomeração Urbana de Piracicaba",
         "RM - Região Metropolitana de Sorocaba",
         "RM - Região Metropolitana de Ribeirão Preto",
         "RM - Região Metropolitana de Campinas",
         "AGLO - Aglomeração Urbana de Franca",
         "RM - Região Metropolitana do Vale do Paraíba e Litoral Norte",
         "RM - Região Metropolitana da Baixada Santista",
         "AGLO - Aglomeração Urbana de Jundiaí",
         "RM - Região Metropolitana de Campo Mourão",
         "RM - Região Metropolitana de Umuarama",
         "RM - Região Metropolitana de Londrina",
         "RM - Região Metropolitana de Cascavel",
         "RM - Região Metropolitana de Maringá",
         "RM - Região Metropolitana de Apucarana",
         "RM - Região Metropolitana de Toledo",
         "RM - Região Metropolitana da Serra Gaúcha",
         "AGLO - Aglomeração Urbana do Sul",
         "AGLO - Aglomeração Urbana do Litoral Norte",
         "RM - Região Metropolitana do Extremo Oeste",
         "RM - Região Metropolitana do Alto Vale do Itajaí",
         "RM - Região Metropolitana do Contestado",
         "RM - Região Metropolitana de Chapecó",
         "RM - Região Metropolitana do Vale do Itajaí",
         "RM - Região Metropolitana do Norte/Nordeste Catarinense",
         "RM - Região Metropolitana Carbonífera",
         "RM - Região Metropolitana de Tubarão",
         "RM - Região Metropolitana da Foz do Rio Itajaí",
         "RM - Região Metropolitana de Lages",
         "RIDE - Região Integrada de Desenvolvimento do Distrito
                  Federal e Entorno",
         "RM - Região Metropolitana de Maceió",
         "RM - Região Metropolitana de Goiânia",
         "RM - Região Metropolitana de Salvador",
         "RM - Região Metropolitana de Fortaleza",
         "RIDE - Região Integrada de Desenvolvimento da Grande Teresina",
         "RM - Região Metropolitana da Grande São Luís",
         "RM - Região Metropolitana de João Pessoa",
         "RM - Região Metropolitana do Recife",
         "RM - Região Metropolitana de Natal",
         "RM - Região Metropolitana de Macapá",
         "RM - Região Metropolitana de Manaus",
         "RM - Região Metropolitana de Belém",
         "RM - Região Metropolitana da Capital",
         "RM - Região Metropolitana de Palmas",
         "RM - Região Metropolitana da Grande Vitória",
         "RM - Região Metropolitana de Belo Horizonte",
         "RM - Região Metropolitana do Rio de Janeiro",
         "RM - Região Metropolitana de São Paulo",
         "RM - Região Metropolitana de Curitiba",
         "RM - Região Metropolitana de Porto Alegre",
         "RM - Região Metropolitana de Florianópolis",
         "RM - Região Metropolitana de Aracaju"
  )
){
  data <- read_db_dr(sheet = sheet)
  if (sheet == 'BRASIL') {
    print('Nao e possivel filtrar a base BRASIL')
    data <- read_db_dr(sheet = 'BRASIL')
  } else if(sheet == "REGIÃO"){
    data <- data %>% 
      filter(regiao %in% regiao)
  } else if(sheet == "ESTADOS"){
    data <- data %>% 
      filter(sigla %in% UF)
  } else if(sheet == "FAIXA POPULACIONAL"){
    data <- data %>% 
      filter(faixa %in% faixa)
  } else if(sheet == "Faixa_Populacional_Estado"){ # colocar sigla
    data <- data %>% 
      filter((faixa %in% faixa) & (sigla %in% UF))
  } else if(sheet == "RM_nao_capital"){ # foi alterado o nome da primeira coluna 
    data <- data %>% 
      filter((regiao_metropolitana %in% RM)&(sigla %in% UF)) #Padronizado UF para Sigla
  } else if(sheet == "RM_capital"){ # foi alterado o nome da primeira coluna 
    data <- data %>% 
      filter((regiao_metropolitana %in% RM)&(sigla %in% UF)) #Padronizado UF para Sigla
  }
  return(data)
}

