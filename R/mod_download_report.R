#' download_report UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_download_report_ui <- function(id){
  ns <- NS(id)
  tagList(
    downloadButton(outputId = ns("report"),
                   label = "Crea pdf")
  )
}
    
#' download_report Server Functions
#'
#' @noRd 
mod_download_report_server <- function(id,
                                       track_title,
                                       url,
                                       author,
                                       track_points_sf,
                                       tracks_sf){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$report <- downloadHandler(
      
      filename = "report.pdf",
      content = function(file) {
        tempReport <- file.path(tempdir(),
                                "report.Rmd")
        file.copy(app_sys("app/www/report.Rmd"),
                  tempReport,
                  overwrite = TRUE)
        
        if(track_title=="") {
          track_title <- "Track"
        }
        
        params <- list(track_points_sf = track_points_sf,
                       tracks_sf = tracks_sf, 
                       title = track_title,
                       url = url,
                       author = author)
        
        rmarkdown::render(tempReport,
                          output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )
      }
    )
  })
}
    
## To be copied in the UI
# mod_download_report_ui("download_report_ui_1")
    
## To be copied in the server
# mod_download_report_server("download_report_ui_1")
