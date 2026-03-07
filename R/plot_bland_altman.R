#' plot_bland_altman
#' @concept visualization
#' @param a first variable in comparison
#' @param b second variable in comparison
#' @param data data of the variables
#' @param ci confidence interval (default: 0.95)
#' @param txt_offset text offset for labels (default: 0.25)
#'
#' @return
#' @export
#' @import ggplot2
#' @importFrom ggtext element_markdown
#' @examples
#' # note: not the best example, since it should be conceptually similar metrics
#' plot_bland_altman('yrs.since.phd', 'yrs.service', carData::Salaries)
plot_bland_altman <- function(a, b, data, ci = 0.95, txt_offset = 0.25) {
  z_thr <- abs(qnorm((1-ci)/2))
  data$diff <- data[, b] - data[, a]
  data$mean <- (data[, a] + data[, b]) / 2
  txt_x <- max(data$mean) - txt_offset * sd(data$mean)
  p <- ggplot(data, aes(mean, diff)) +
    geom_point(alpha = 0.05) +
    geom_hline(yintercept = 0) +
    geom_hline(yintercept = c(-z_thr * sd(data$diff), z_thr * sd(data$diff)), linetype = 'dashed', color = 'red') +
    geom_hline(yintercept = mean(data$diff), linetype = 'dashed') +
    annotate("text", y = (mean(data$diff) + txt_offset * sd(data$diff)), x = txt_x, label = "Mean") +
    annotate("text", y = (z_thr * sd(data$diff) + txt_offset * sd(data$diff)), x = txt_x, label = sprintf("+%sSD", round(z_thr, 2))) +
    annotate("text", y = (-z_thr * sd(data$diff) + txt_offset * sd(data$diff)), x = txt_x, label = sprintf("-%sSD", round(z_thr, 2))) +
    labs(title = 'Bland-Altman',
         x = 'Mean',
         y = 'Difference (B - A)',
         subtitle = lm2apa(lm(diff ~ 1, data))) +
    theme_minimal() +
    theme(plot.subtitle = element_markdown())
  return(p)
}
