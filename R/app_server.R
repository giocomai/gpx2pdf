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
                             author = input$author,
                             date = input$date, 
                             track_points_sf = list_sf_r$track_points_sf(),
                             tracks_sf = list_sf_r$tracks_sf(), 
                             map_style = input$map_style,
                             api_key = golem::get_golem_options("api_key"))
  
  mod_download_report_odt_server("download_report_odt_ui_1",
                                 track_title = input$track_title, 
                                 url = input$url,
                                 author = input$author,
                                 date = input$date, 
                                 track_points_sf = list_sf_r$track_points_sf(),
                                 tracks_sf = list_sf_r$tracks_sf(), 
                                 map_style = input$map_style,
                                 api_key = golem::get_golem_options("api_key"))
  
  mod_download_miniature_server(id = "download_miniature_ui_1", 
                                track_points_sf = list_sf_r$track_points_sf(),
                                tracks_sf = list_sf_r$tracks_sf())
  
  
  
}
