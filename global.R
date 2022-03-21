
#  -----------------------------------------------------------------------------
# Organização do ambiente
# ------------------------------------------------------------------------------

# Removendo objetos criados:
rm(list = ls())





#  -----------------------------------------------------------------------------
# Pacotes
# ------------------------------------------------------------------------------

# Testa se o pacote pacman está instalado:
if (!require("pacman")) install.packages("pacman")

# Pacotes exigidos:
pacman::p_load(
  # Pacote para manipulação:
  "tidyverse",
  "lubridate",
  "stringr",
  "readxl",
  "shiny",
  "shinydashboard",
  "dashboardthemes",
  "shinycssloaders",
  "shinyWidgets",
  "shinyTime",
  "DT",
  "readxl",
  "janitor"
)





#  -----------------------------------------------------------------------------
# Carrega dados
# ------------------------------------------------------------------------------







#  -----------------------------------------------------------------------------
# Limite de tamanho do arquivo
# ------------------------------------------------------------------------------

# Tamanho máximo do arquivo a ser carregado é 300 MB:
options(shiny.maxRequestSize = 500 * 1024^2)





#  -----------------------------------------------------------------------------
# Tema do dashboard
# ------------------------------------------------------------------------------

# Tema do shinydashboard:
temadashboard <- shinyDashboardThemes(theme = c(
  "grey_dark",
  "blue_gradient",
  "grey_light",
  "purple_gradient",
  "poor_mans_flatly",
  "flat_red"
)[3])





#  -----------------------------------------------------------------------------
# Título do dashboard
# ------------------------------------------------------------------------------

# Nome do Projeto:
header <- dashboardHeader(
  title = "NomeDoProjeto"
)





#  -----------------------------------------------------------------------------
# Funções
# ------------------------------------------------------------------------------

# Função de saída de dados:
source("functions/out.R")

# Função de leitura do banco de dados:
source("functions/funcao_agua.R")
source("functions/funcao_drenagem.R")
source("functions/funcao_residuos.R")

agua <- read_db_wr(sheet = "BaseMun_AA")
drenagem <- read_db_dr(sheet = "ESTADOS")
residuos <- read_db_rs(sheet = "Estados")
