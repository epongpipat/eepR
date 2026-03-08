#' @title cor_plot
#' @concept visualization
#' @param data data to create a heat map from
#'
#' @return
#' @export
#' @importFrom lifecycle deprecate_warn
#' @examples
#' cor_plot(mtcars)
cor_plot <- function(data) {
  lifecycle::deprecate_warn("0.5.0", "cor_plot()", "plot_cor_heatmap()")
  plot_cor_heatmap(data)
}

#' @title plot_cor_heatmap
#' @concept visualization
#' @param data data to create a heat map from
#' @return ggplot figure
#' @export
#' @import dplyr stringr tibble ggplot2
#' @examples
#' plot_cor_heatmap(mtcars)
plot_cor_heatmap <- function(data) {
  cor_long(data) %>%
    ggplot(., aes(var_1, var_2, fill = r)) +
    geom_raster() +
    theme_minimal() +
    labs(x = NULL,
         y = NULL,
         fill = "Correlation") +
    scale_fill_distiller(palette = "RdBu", values = c(-1, 1)) +
    theme(axis.text.x = element_text(hjust = 1, angle = 45))
}

