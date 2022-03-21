
# ** User Interface ------------------------------------------------------------





## ** Menu do dashboard --------------------------------------------------------

# Menu principal:
sidebar <- dashboardSidebar( # Begin: dashboardSidebar
  sidebarMenu( # End siderbarMenu

    # Menu de dados brutos:
    menuItem(
      text = "Visão Geral",
      tabName = "visao",
      icon = icon("table")
    ),

    # Menu de Deficits:
    menuItem(
      text = "Déficits",
      tabName = "deficits",
      icon = icon("money-bill")
    ),

    # Menu de Investimentos:
    menuItem(
      text = "Investimentos",
      tabName = "investimentos",
      icon = icon("dollar-sign")
    )
  ) # End siderbarMenu
) # End dashboardSidebar

body <- dashboardBody( # Begin dashboardBody:
  # Tema do dashboard definido anteriormente:
  temadashboard,
  # Realiza uma requisitção de dados no cubo-de-vendas:
  fluidPage(
    tags$hr(),
    column(
      width = 6,
      # tags$hr(),
      align = "left",
      checkboxGroupInput(
        inputId = "banco",
        label = h3("Banco de Dados:"),
        choices = list(
          "Água" = "agua",
          "Resíduos" = "residuos",
          "Drenagem" = "drenagem"
        ),
        selected = "agua"
      )
    ),
    column(
      width = 6,
      # tags$hr(),
      align = "left",
      radioButtons(
        inputId = "id_agrupamento",
        label = h3("Forma de Agrupamento:"),
        choices = list(
          "Brasil" = "brasil",
          "Estado" = "estado",
          "Região" = "regiao",
          "Município" = "municipio"
        ),
        selected = "brasil"
      ),
    ),
    tags$hr(),
  ),
  tags$hr(),
  column(
    width = 4,
    # tags$hr(),
    align = "left",
    textInput(
      inputId = "id_estado",
      label = h3("Estado:"),
      value = ""
    )
  ),
  column(
    width = 4,
    # tags$hr(),
    align = "left",
    textInput(
      inputId = "id_municipio",
      label = h3("Município:"),
      value = ""
    )
  ),
  column(
    width = 4,
    # tags$hr(),
    align = "left",
    sliderInput(
      inputId = "id_populacao",
      label = h3("População:"),
      min = 1,
      max = 6,
      value = c(1, 6)
    )
  ),
  column(
    width = 12,
    tags$hr(),
  ),
  #
  fluidPage( # Início fluidPage
    column(
      align = "center",
      actionButton(inputId = "query", label = "Gerar Tabela", icon("refresh")),
      width = 6
    ),
    column(
      align = "center",
      downloadButton("downloadData", "Download"),
      width = 6
    )
  ), # Fim fluidPage
  #
  tags$hr(),
  DTOutput(outputId = "banco") %>% withSpinner(color = "grey", size = 2),
  tags$hr()
) # Begin dashboardBody



# Interface de usuário:
ui <- dashboardPage(
  # Nome do projeto:
  header = header,
  # Layout / menu do dashboard:
  sidebar = sidebar,
  # Corpo do shinyapp:
  body = body
)

# ** Menu do dashboard ---------------------------------------------------------