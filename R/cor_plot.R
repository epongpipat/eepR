#' @title cor_plot
#'
#' @param data data to create a heat map from
#'
#' @return
#' @export
#' @import dplyr stringr tibble ggplot2
#' @examples
#' cor_plot(mtcars)
cor_plot <- function(data) {
  cor_long(data) %>%
    ggplot(., aes(var_1, var_2, fill = val)) +
    geom_raster() +
    theme_minimal() +
    labs(x = NULL,
         y = NULL,
         fill = "Correlation") +
    scale_fill_distiller(palette = "RdBu", values = c(-1, 1)) +
    theme(axis.text.x = element_text(hjust = 1, angle = 45))
}
