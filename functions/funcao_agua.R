
read_db_wr <- function(path = "dados/BaseAbastecimentoAgua_2020_N2_condensado_v2.xlsx",
                       sheet = "BaseMun_AA") {
  if (sheet %in% c("BaseMun_AA", "Estados", "Regioes")) {
    if (sheet %in% c("Regioes")) {
      skip <- 1
    } else {
      skip <- 0
    }
    data <- readxl::read_xlsx(path, sheet = sheet, skip = skip)
    data <- data %>% janitor::clean_names()
  } else {
    print("Planilha nao localizada")
    data <- NULL
  }
  return(data)
}



filter_db_wr <- function(sheet = "Estados",
                         UF = c(
                           "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA", "MG", "MS", "MT",
                           "PA", "PB", "PE", "PI", "PR", "RJ", "RN", "RO", "RR", "RS", "SC", "SE", "SP", "TO"
                         ),
                         regiao = c("Norte", "Nordeste", "Sudeste", "Sul", "Centro-Oeste"),
                         municipios = c()) {
  data <- read_db_wr(sheet = sheet)
  if (sheet == "BaseMun_AA") {
    if (length(municipios) == 0) {
      data <- data %>%
        filter((regiao %in% regiao) &
          (sigla_uf %in% UF))
    } else {
      data <- data %>%
        filter((regiao %in% regiao) &
          (nome_do_municipio %in% municipios) &
          (sigla_uf %in% UF))
    }
  } else if (sheet == "Regioes") {
    data <- data %>%
      filter(regiao %in% regiao)
  } else if (sheet == "Estados") {
    data <- data %>%
      filter((sigla_estado %in% UF))
  }
  return(data)
}