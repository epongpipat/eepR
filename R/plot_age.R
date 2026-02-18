#' plot_age
#'
#' @param data 
#' @param var_y 
#' @param var_x 
#' @param y_lab 
#'
#' @return
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
