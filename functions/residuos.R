######## Função Residos sólidos: ###
## UTF-8
## Essa função é reposnsavel pela Leitura, interpretação e calculos do sistema
## Residuos solidos.

#### Bibliotecas necessarias:


library(dplyr)  
library(readxl)
library(janitor)
library(tidyverse) # sudo apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev


#### Leitura do banco de dados

read_db_rs <- function(
  path = "Data/BaseResiduos_VF_2022_01_31.xlsx",
  sheet = "Estados"){
  
  if(sheet %in% c("BaseRSVF","FP-Estados","Estados","Regioes","MetasPLANSAB",
                  "MetasPLANSAB2","FP-Regioes","UnDispFinRev","EncRecup",
                  "SufFin20","BaseRSV0","PopCenso2010","FP-MedDef","IndAutFin",
                  "RefIAF","ColSel","CR-SICalc","CR-SIVal","CSCalc","TG-MP" )){
    data <- read_xlsx(path, sheet = sheet)
    data <- data %>% clean_names()
  } else{
    print('Planilha nao localizada')
    data <- NULL
  }
  return(data)
}

#### Filtragem Banco de dados

filter_db_rs <- function(
  sheet="Estados",
  UF = c("AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT",
         "PA","PB","PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO"),
  Regiao = c("Norte","Nordeste","Sudeste","Sul","Centro-Oeste"),
  faixa = c(1,2,3,4,5,6),
  municipios = c(),
  RM = c()
){
  data <- read_db_rs(sheet = sheet)
  if (sheet %in% c('BaseRSVF','BaseRSV0','UnDispFinRev',
                   'CR-SICalc','CR-SIVal','CSCalc','TG-MP')) {
    if((length(municipios) == 0)& (length(RM) == 0) ){
      data <- data %>% 
        filter((regiao %in% Regiao)&
                 (sigla_uf %in% UF)&
                 (faixa_populacional %in% faixa))
    }else if((length(municipios) != 0)& (length(RM) == 0)){
      data <- data %>% 
        filter((regiao %in% Regiao)&
                 (sigla_uf %in% UF)&
                 (nome_do_municipio %in% municipios)&
                 (faixa_populacional %in% faixa))
    }else if((length(municipios) == 0)& (length(RM) != 0)){
      data <- data %>% 
        filter((regiao %in% Regiao)&
                (sigla_uf %in% UF)&
                (regiao_metropolitana_regiao_integrada_de_desenvolvimento_aglomeracao_urbana 
 %in% RM)&
   (faixa_populacional %in% faixa)
        )
      
    }else{
      data <- data %>% 
        filter((regiao %in% Regiao)&
                 (sigla_uf %in% UF)&
                 (regiao_metropolitana_regiao_integrada_de_desenvolvimento_aglomeracao_urbana 
                  %in% RM)&
                 (nome_do_municipio %in% municipios)&
                 (faixa_populacional %in% faixa)
        )
              
    }
  }else if(sheet == "FP-Estados"){
    data <- data %>% 
      filter((sigla_estado %in% UF)&
               (fp %in% faixa))
  } else if(sheet == "Estados"){
    data <- data %>% 
      filter((sigla_estado %in% UF))
  }else if(sheet == "Regioes"){
    data <- data %>% 
      filter((regioes %in% Regiao))
  }else if(sheet == "FP-Regioes"){
    data <- data %>% 
      filter((regiao %in% Regiao)&
               (fp_2 %in% faixa))
  }else if(sheet == "MetasPLANSAB"){
    data <- data %>% 
      filter((sigla_estado %in% UF))
  }else if(sheet == "MetasPLANSAB2"){
    data <- data %>% 
      filter((sigla_estado %in% UF))
  }else if(sheet == "EncRecup"){
    if(length(municipios) == 0){
      data <- data %>% 
        filter((uf %in% UF)&
                 (fp_municipio_localizacao %in% faixa)&
                 (regiao %in% Regiao))
    }else{
      data <- data %>% 
        filter((uf %in% UF)&
                 (fp_municipio_localizacao %in% faixa)&
                 (regiao %in% Regiao)&
                 (municipio_localizacao_udf %in% municipios))
    }
  }else if(sheet == "SufFin20"){
    if(length(municipios == 0)){
      data <- data %>% 
        filter((uf %in% UF))
    }else{
    data <- data %>% 
      filter((uf %in% UF)&
               (municipio %in% municipios))
    }
  }else if(sheet == "PopCenso2010"){
    if(length(municipios) == 0){
      data <- data
    } else{
    data <- data %>% 
      filter((nome_do_municipio %in% municipios))}
  }else if(sheet == "FP-MedDef"){
    data <- data %>% 
      filter((regiao %in% Regiao)&
               (faixa_populacional %in% faixa))
  }else if(sheet == "IndAutFin"){
    if(length(municipios) == 0 ){ 
      data <- data %>% 
        filter((uf %in% UF)&
                 (fp %in% faixa)&
                 (regiao %in% Regiao))
    }else{
      data <- data %>% 
        filter((uf %in% UF)&
                 (fp %in% faixa)&
                 (regiao %in% Regiao)&
                 (municipio %in% municipios))
    }
    
  }else if(sheet == "ColSel"){ # adicionar a sigla do estado
    data <- data %>% 
      filter((sigla_estado %in% UF))
  }
  return(data)
}


