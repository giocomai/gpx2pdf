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
    fluidPage(
      waiter::useWaiter(),
      waiter::waiterOnBusy(),
      h1("gpx2pdf"),
      mod_file_input_ui("file_input_ui_1",
                        label = "Carica un file gpx"),
      shiny::textInput(inputId = "track_title",
                       label = "Inserisci titolo del percorso",
                       value = "Percorso",
                       width = "100%"),
      shiny::textInput(inputId = "url",
                       label = "Inserisci link da trasformare in QR", 
                       value = "https://archiviomemoria.ecomuseovalledeilaghi.it/",
                       width = "100%"),
      shiny::textInput(inputId = "author",
                       label = "Inserisci autore",
                       value = "Archivio delle Memoria - Ecomuseo della Valle dei Laghi",
                       width = "100%"),
      shiny::textInput(inputId = "date",
                       label = "Inserisci data",
                       value = Sys.Date() %>% stringr::str_extract(pattern = "[[:digit:]]+") %>% as.integer()),
      shiny::selectInput(inputId = "map_style",
                       label = "Seleziona tipo di mappa",
                       choices = c(rosm::osm.types(),
                                   "OpenTopoMap",
                                   "Thunderforest_outdoor_API")),
      mod_download_report_ui("download_report_ui_1"),
      mod_download_report_odt_ui("download_report_odt_ui_1"),
      mod_download_miniature_ui("download_miniature_ui_1")
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

