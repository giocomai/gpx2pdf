#' Read tracks
#' 
#' Reads either tracks or routes as sf objects. If tracks is empty, it reads routes in its stead.
#'
#' @param path Path to gpx file.
#'
#' @return An sf object
#' @export
#'
#' @examples
read_tracks <- function(path) {
  if (fs::path_ext(path) == "gpx") {
    layers <- sf::st_layers(dsn = path)
    
    layers_df <- tibble::tibble(name = layers$name, 
                   features = layers$features) 
    
    if (layers_df$features[layers_df$name=="tracks"]) {
      sf <- sf::st_read(dsn = path,
                  layer = "tracks")
    } else if (layers_df$features[layers_df$name=="routes"]) {
      sf <- sf::st_read(dsn = path,
                        layer = "routes")
    } else {
      warning("Both tracks and routes layers are empty.")
      sf <- sf::st_read(dsn = path,
                        layer = "tracks")
    }
    return(sf)
  } else {
    # do nothing
    warning("File must be a gpx")
  }
}


#' Read track points
#' 
#' Reads either tracks points or route points as sf objects If tracks is empty, it reads routes in its stead.
#'
#' @param path Path to gpx file.
#'
#' @return An sf object
#' @export
#'
#' @examples
read_track_points <- function(path) {
  if (fs::path_ext(path) == "gpx") {
    layers <- sf::st_layers(dsn = path)
    
    layers_df <- tibble::tibble(name = layers$name, 
                                features = layers$features) 
    
    if (layers_df$features[layers_df$name=="track_points"]) {
      sf <- sf::st_read(dsn = path,
                        layer = "track_points")
    } else if (layers_df$features[layers_df$name=="route_points"]) {
      sf <- sf::st_read(dsn = path,
                        layer = "route_points")
    } else {
      warning("Both track points and route points layers are empty.")
      sf <- sf::st_read(dsn = path,
                        layer = "track_points")
    }
    return(sf)
  } else {
    # do nothing
    warning("File must be a gpx")
  }
}