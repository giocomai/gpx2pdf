#' file_input UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_file_input_ui <- function(id, label = "Upload a gpx file"){
  ns <- NS(id)
  tagList(
    fileInput(
      inputId = ns("file_input"),
      label = label
    )
  )
}
    
#' file_input Server Functions
#'
#' @noRd 
mod_file_input_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    user_file <- reactive({
      # If no file is selected, don't do anything
      validate(need(input$file_input, message = FALSE))
      input$file_input
    })
    
    track_points_sf <- reactive({
      if (fs::path_ext(user_file()$name) == "gpx") {
        sf::st_read(user_file()$datapath,
                    layer = "track_points")
      } else {
        # do nothing
        warning("File must be a gpx")
      }
    })
    
    tracks_sf <- reactive({
      if (fs::path_ext(user_file()$name) == "gpx") {
        sf::st_read(user_file()$datapath,
                    layer = "tracks")
      } else {
        # do nothing
        warning("File must be a gpx")
      }
    })

    
    return(list(
      track_points_sf = track_points_sf,
      tracks_sf = tracks_sf
      ))
  })
}
    
## To be copied in the UI
# mod_file_input_ui("file_input_ui_1")
    
## To be copied in the server
# mod_file_input_server("file_input_ui_1")
