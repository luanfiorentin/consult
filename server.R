
#  -----------------------------------------------------------------------------
# Begin: Server
# ------------------------------------------------------------------------------





# Processamento dos dados:
server <- function(input, output, session) { # Begin: Server
        #

        output$banco <- renderDataTable({
                agua %>%
                        out()
        })

        output$downloadData <- downloadHandler(
                filename = function() {
                        "BaseDeDados.xlsx"
                },
                content = function(file) {
                        writexl::write_xlsx(data, path = file)
                }
        )

        #
} # End: Server





#  -----------------------------------------------------------------------------
# End: Server
# ------------------------------------------------------------------------------