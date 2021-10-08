#' Create a data frame with distance elevation pairs based on track points
#'
#' @param track_points_sf An sf object, typically generated with `read_track_points()`
#'
#' @return A data frame with two columns, distance and elevation.
#' @export
#'
#' @examples
create_distance_elevation_df <- function(track_points_sf) {
  dist_df <- sf::st_distance(track_points_sf)
  
  
  distance_v <- purrr::map_dbl(.x = 1:(nrow(track_points_sf)-1),
                               .f = function(i) {
                                 sf::st_distance(track_points_sf %>% slice(i),
                                                 track_points_sf %>% slice(i+1))
                               })
  
  tibble::tibble(distance = c(0, cumsum(distance_v)),
                 elevation = track_points_sf$ele) 
}


#' Create a data frame with distance elevation pairs based on track points
#'
#' @param distance_elevation_df A data frame, typically generated with `create_distance_elevation_df()`
#'
#' @return A data frame with two columns, distance and elevation.
#' @export
#'
#' @examples
create_labels_df <- function(distance_elevation_df) {
  distance_elevation_df %>% 
    dplyr::mutate(point_id = row_number()-1) %>% 
    dplyr::left_join(y = track_points_sf %>%
                       sf::st_drop_geometry() %>% 
                       dplyr::select(point_id = track_seg_point_id,
                                     name), 
                     by = "point_id") %>% 
    tidyr::drop_na() %>% 
    dplyr::mutate(id = dplyr::row_number())
}

