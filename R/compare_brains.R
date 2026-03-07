#' compare_brains
#'
#' @param a first image to compare
#' @param b second image to compare
#' @param mask mask image
#' @param ci confidence interval for bland-altman plots (default: 0.95)
#' @param legend_title
#' @return
#' @export
#' @import patchwork
compare_brains <- function(a, b, mask, ci = 0.95, legend_title = NULL) {

  imgs <- list()
  imgs$a <- a
  imgs$b <- b
  imgs$diff <- imgs$b - imgs$a

  df <- data.frame(a = imgs$a[imgs$mask != 0 & imgs$a != 0 & imgs$b != 0],
                   b = imgs$b[imgs$mask != 0 & imgs$a != 0 & imgs$b != 0]) |>
    mutate(diff = b - a,
           mean = (a + b) / 2)

  p <- list()
  p$a <- plot_brain(imgs$a, legend_title = legend_title) + plot_annotation(title = 'A')
  p$b <- plot_brain(imgs$b, legend_title = legend_title) + plot_annotation(title = 'B')
  p$diff <- plot_brain(imgs$diff,
                       fill_mid = 'white',
                       fill_low = 'blue',
                       fill_high = 'red',
                       fill_limits = c(-1, 1),
                       legend_position = NULL,
                       legend_title = legend_title) + plot_annotation(title = 'Difference')
  p$compare_brains <- wrap_plots(list(p$a, p$b, p$diff), ncol = 1)

  p$cor <- plot_cor('a', 'b', df) +
    geom_abline(intercept = 0, slope = 1, linetype = 'dashed')

  p$ba <- plot_bland_altman('a', 'b', df, ci = ci)

  p$combined <- p$compare_brains | (p$cor / p$ba)
  return(p$combined)

}
