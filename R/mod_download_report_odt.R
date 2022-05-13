#' download_report UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_download_report_odt_ui <- function(id){
  ns <- NS(id)
  tagList(
    downloadButton(outputId = ns("report"),
                   label = "Crea odt")
  )
}

#' download_report Server Functions
#'
#' @noRd 
mod_download_report_odt_server <- function(id,
                                           track_title,
                                           url,
                                           author,
                                           date,
                                           track_points_sf,
                                           tracks_sf, 
                                           map_style,
                                           file_name = stringr::str_c("report-",
                                                                      as.character(as.integer(Sys.time())),
                                                                      ".odt"),
                                           api_key){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$report <- downloadHandler(
      
      filename = file_name,
      content = function(file) {
        tempReport <- file.path(tempdir(),
                                "report_odt.Rmd")
        file.copy(app_sys("app/www/report_odt.Rmd"),
                  tempReport,
                  overwrite = TRUE)
        
        if (track_title=="") {
          track_title <- "Track"
        }
        
        params <- list(track_points_sf = track_points_sf,
                       tracks_sf = tracks_sf, 
                       track_title = track_title,
                       url = url,
                       author = author, 
                       date = date,
                       map_style = map_style, 
                       api_key = api_key)
        
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
# mod_download_report_odt_ui("download_report_odt_ui_1")

## To be copied in the server
# mod_download_report_odt_server("download_report_odt_ui_1")