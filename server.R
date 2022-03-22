
#  -----------------------------------------------------------------------------
# Begin: Server
# ------------------------------------------------------------------------------





# Processamento dos dados:
server <- function(input, output, session) { # Begin: Server

        # Tabela de saída em função da escolha do usuário:
        output$banco <- renderDataTable({
                # Condicional para selecionar o banco de dados:
                if (input$banco == "agua") {
                        tb <- agua
                } else if (input$banco == "drenagem") {
                        tb <- drenagem
                } else if (input$banco == "residuos") {
                        tb <- residuos
                }

                # Saída da condicional:
                tb %>% out()
        })

        output$downloadData <- downloadHandler(
                filename = function() {
                        "BaseDeDados.xlsx"
                },
                content = function(file) {
                        writexl::write_xlsx(tb, path = file)
                }
        )

        #
} # End: Server





#  -----------------------------------------------------------------------------
# End: Server
# ------------------------------------------------------------------------------