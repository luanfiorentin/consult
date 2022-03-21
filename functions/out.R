
out <- function(db) {
  db %>%
    slice_sample(.data = ., n = 50) %>%
    datatable(
      .,
      caption = "Amostra de dados filtrados:",
      style = "bootstrap", # Arranja os dados com botão do lado da variável
      class = "cell-border stripe", # Contornos na tabela
      extensions = c("Responsive", "Buttons"), # Gera colunas somente na página gráfica
      rownames = FALSE, # Remove numeração das linhas
      options = list(
        pageLength = 10,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        dom = "Bfrtip", # Define posição do botão para baixar dados
        buttons = c("copy", "excel"), # Define quais botões devem aparecer
        initComplete = JS( # Define cores das caixas de títulos das variáveis
          "function(settings, json) {",
          "$(this.api().table().header()).css({'background-color': 'black', 'color': 'white'});",
          "}"
        ),
        searching = FALSE, # Define caixa geral de buscas na tabela
        searchHighlight = FALSE
      )
    )
}