
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
  fluidPage(
    tags$hr(),
    column(
      width = 4,
      tags$hr(),
      align = "left",
    checkboxGroupInput(
      inputId = "banco",
      label = h6("Selecione o Banco de Dados para Visualizar:"),
      choices = list(
        "Água" = 1,
        "Resíduos" = 2,
        "Drenagem" = 3
      ),
      selected = 1
    ),
    column(
      width = 4,
      tags$hr(),
      align = "left",
      radioButtons(inputId = "Agrupamento",
                   label = h6("Qual agrupamento deseja visualizar?"),
                   choices = list(
                     "Brasil" = 1,
                     "Estado" = 2,
                     "Regiao" = 3,
                     "Municipio" = 4
                   ),
                   selected = 4
      ),
    ),
    tags$hr(),
    ),
    tags$hr(),
    column(
      width = 4,
      tags$hr(),
      align = "left",
      checkboxGroupInput(
        inputId = "id_municipio",
        label = h3("Município:"),
        selected = "todos",
        choices = list(
          "Todos" = "todos",
          "ID" = "S"
        )
      )
    ),
    column(
      width = 4,
      tags$hr(),
      align = "left",
      checkboxGroupInput(
        inputId = "id_estado",
        label = h3("Estado:"),
        selected = "todos",
        choices = list(
          "Todos" = "todos",
          "ID" = "S"
        )
      )
    ),
    column(
      width = 4,
      tags$hr(),
      align = "left",
      sliderInput(inputId = "id_populacao",
                  label = h3("População:"),
                  min = 1,
                  max = 6,
                  value = c(1, 6)),
    ),
    DTOutput(outputId = "banco") %>% withSpinner(color = "grey", size = 2),
    tags$hr(),
    downloadButton("downloadData", "Download"),
    tags$hr()
  )
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
