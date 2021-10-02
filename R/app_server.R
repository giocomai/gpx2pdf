#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {

  list_sf_r <- mod_file_input_server("file_input_ui_1")
  
  mod_download_report_server(id = "download_report_ui_1",
                             track_title = input$track_title, 
                             url = input$url,
                             track_points_sf = list_sf_r$track_points_sf(),
                             tracks_sf = list_sf_r$tracks_sf())
  
}
