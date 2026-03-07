#' plot_cor
#'
#' @concept visualization
#' @param x x variable
#' @param y y variable
#' @param data data that contains the x and y variables
#'
#' @return ggplot2 figure with correlation statistics
#' @export
#' @import ggplot2
#' @examples
#' plot_cor('yrs.service', 'yrs.since.phd', carData::Salaries)
plot_cor <- function(x, y, data) {
  data[, 'x'] <- data[, x]
  data[, 'y'] <- data[, y]
  p <- ggplot(data, aes(x, y)) +
    geom_point(alpha = 0.05) +
    geom_smooth(method = 'lm', color = 'black') +
    theme_minimal() +
    labs(title = 'Correlation',
         x = 'A',
         y = 'B',
         subtitle = cor2apa(cor.test(data$x, data$y)))
  return(p)
}
