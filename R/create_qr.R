#' Create qr code from URL
#'
#' @param url A url to be transformed into a QR code
#'
#' @return A ggplot object
#' @export
#'
#' @examples
#'
#' create_qr("https://archiviomemoria.ecomuseovalledeilaghi.it")
create_qr <- function(url) {
  qrencoder::qrencode(to_encode = url) %>% 
    as.data.frame() %>% 
    dplyr::mutate(y = dplyr::row_number()) %>% 
    tidyr::pivot_longer(cols = dplyr::contains("V"),
                        names_to = "x",
                        values_to = "z") %>% 
    dplyr::mutate(x = stringr::str_remove(string = x,
                                          "V") %>%
                    as.numeric()) %>% 
    ggplot2::ggplot(mapping = ggplot2::aes(x = x,
                                           y = y,
                                           fill = as.character(z))) +
    ggplot2::geom_tile(width=1) +
    ggplot2::scale_fill_manual(values = c("white","black")) +
    ggplot2::theme_void() +
    ggplot2::theme(legend.position = "none",
                   panel.grid.major = ggplot2::element_blank(),
                   panel.grid = ggplot2::element_blank())
}