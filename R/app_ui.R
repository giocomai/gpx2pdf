#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    fluidPage(
      h1("gpx2pdf"),
      mod_file_input_ui("file_input_ui_1",
                        label = "Carica un file gpx"),
      shiny::textInput(inputId = "track_title",
                       label = "Inserisci titolo del percorso"),
      shiny::textInput(inputId = "url",
                       label = "Inserisci link da trasformare in QR"),
      mod_download_report_ui("download_report_ui_1")

    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    golem::favicon(ext = "png"),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'gpx2pdf'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

