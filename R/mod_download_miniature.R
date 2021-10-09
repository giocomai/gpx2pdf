#' download_miniature UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_download_miniature_ui <- function(id){
  ns <- NS(id)
  tagList(
    downloadButton(outputId = ns("miniature"),
                   label = "Scarica miniatura")
  )
}
    
#' download_miniature Server Functions
#'
#' @noRd 
mod_download_miniature_server <- function(id, track_points_sf, tracks_sf){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    
    output$miniature <- downloadHandler(
      
      filename = "miniatura.png",
      content = function(file) {
        ggplot2::ggsave(
          filename = file,
          plot = create_miniature(track_points_sf = track_points_sf,
                                  tracks_sf = tracks_sf,
                                  title = "Traccia GPX",
                                  font_family = "Roboto Condensed"),
          type = "cairo",
          width = 400,
          height = 400,
          units = "px"
        )
      }
    )
    
  })
}
    
## To be copied in the UI
# mod_download_miniature_ui("download_miniature_ui_1")
    
## To be copied in the server
# mod_download_miniature_server("download_miniature_ui_1")
