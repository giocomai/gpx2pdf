#' download QR UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_download_qr_ui <- function(id){
  ns <- NS(id)
  tagList(
    downloadButton(outputId = ns("qr"),
                   label = "Scarica QR")
    # ,
    # shiny::numericInput(inputId = NS(id, "qr_download_size"),
    #                     label = "Dimensione in pixel del QR code (se scaricato separatamente)",
    #                     value = 1024,
    #                     max = 4096,
    #                     min = 32),
    # shiny::selectInput(inputId = NS(id, "qr_format"),
    #                    label = "Seleziona formato del codice QR (se scaricato separatamente)",
    #                    choices = c(".png",
    #                                ".svg"))
  )
}

#' download_qr Server Functions
#'
#' @noRd 
mod_download_qr_server <- function(id, url){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    
    output$qr <- downloadHandler(
      
      filename = paste0("codice_qr", ".png"),
      content = function(file) {
        ggplot2::ggsave(
          filename = file,
          plot = create_qr(url),
          type = "cairo",
          width = 1024, #input$qr_size,
          height = 1024, #input$qr_size,
          units = "px",
          bg = "white"
        )
      }
    )
    
  })
}

## To be copied in the UI
# mod_download_qr_ui("download_qr_ui_1")

## To be copied in the server
# mod_download_qr_server("download_qr_ui_1")
