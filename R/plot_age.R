#' plot_age
#' @concept visualization
#' @param data input data.frame
#' @param var_y y-axis variable to plot
#' @param var_x x-axis variable to plot
#' @param y_lab y-axis label
#' @param x_lab x-axis label
#'
#' @return ggplot figure of y-axis variable and age
#' @export
#' @import ggplot2
#' @import dplyr
#' @examples
plot_age <- function(data, y_var, x_var = 'age', y_lab = NULL, x_lab = 'Age') {
  fig <- ggplot(data, aes(x = eval(as.name(x_var)), y = eval(as.name(y_var)))) +
    geom_point() +
    geom_smooth(method = 'lm', color = 'black') +
    scale_x_continuous(breaks = seq(from = 0, to = 100, by = 10)) +
    theme_minimal() +
    labs(x = glue("\n{x_lab}"))
  if (is.null(y_lab)) {
    fig <- fig + labs(y = glue("{y_var}\n"))
  } else {
    fig <- fig + labs(y = glue("{y_lab}\n"))
  }
  return(fig)
}
