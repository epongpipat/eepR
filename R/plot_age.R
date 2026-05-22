#' plot_age
#' @concept visualization
#' @family plotting helpers
#' @param data input data.frame
#' @param y_var y-axis variable to plot
#' @param x_var x-axis variable to plot
#' @param y_lab y-axis label
#' @param x_lab x-axis label
#'
#' @return ggplot figure of y-axis variable and age
#' @export
#' @import ggplot2
#' @import dplyr
#' @examples
#' data <- data.frame(age = c(20, 30, 40, 50), score = c(4, 6, 7, 9))
#' plot_age(data, y_var = "score")
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
