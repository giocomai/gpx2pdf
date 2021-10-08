#' Create miniature preview of the track
#'
#' @param track_points_sf 
#' @param tracks_sf 
#'
#' @return
#' @export
#'
#' @examples
create_miniature <- function(track_points_sf,
                             tracks_sf,
                             title = "GPX track",
                             font_family = "sans") {
  ggplot2::ggplot() +
    ggplot2::geom_sf(data = tracks_sf) +
    ggplot2::geom_sf(data = track_points_sf %>% 
                       dplyr::filter(is.na(name)==FALSE)) +
    ggplot2::theme_void() +
    ggplot2::labs(title = title) +
    ggplot2::theme(plot.title = ggplot2::element_text(family = font_family,
                                                      hjust = 0.5,
                                                      face = "bold"))
  # ggsave(width = 360, height = 360, units = "px", filename = "miniature.png")
  
}