#' compare_brains
#' @concept visualization
#' @concept neuroimaging
#' @param a first image to compare
#' @param b second image to compare
#' @param mask mask image
#' @param ci confidence interval for bland-altman plots (default: 0.95)
#' @param legend_title legend title (default: intensity)
#' @param out_path path to save image
#' @param out_width width of saved image in inches (default: 11)
#' @param out_height height of saved image in inches (default: 8.5)
#' @param ... additional parameters for \code{plot_brain()}
#' @return ggplot figure comparing two images
#' @export
#' @import patchwork
compare_brains <- function(a, b, mask, ci = 0.95, legend_title = 'Intensity', out_path = NULL, out_width = 14, out_height = 7, ...) {

  imgs <- list()
  imgs$a <- a
  imgs$b <- b
  imgs$mask <- mask
  imgs$diff <- imgs$b - imgs$a

  df <- data.frame(a = imgs$a[imgs$mask != 0 & imgs$a != 0 & imgs$b != 0],
                   b = imgs$b[imgs$mask != 0 & imgs$a != 0 & imgs$b != 0]) |>
    mutate(diff = b - a,
           mean = (a + b) / 2)

  p <- list()
  p$a <- plot_brain(imgs$a, legend_title = legend_title, bg_color = 'white', text_color = 'black', ...)
  p$a[[1]] <- p$a[[1]] + labs(title = 'A')
  p$b <- plot_brain(imgs$b, legend_title = legend_title, bg_color = 'white', text_color = 'black', ...) + plot_annotation(title = 'B')
  p$b[[1]] <- p$b[[1]] + labs(title = 'B')
  p$diff <- plot_brain(imgs$diff,
                       fill_mid = 'black',
                       fill_low = 'blue',
                       fill_high = 'red',
                       fill_limits = c(-1, 1),
                       legend_position = NULL,
                       legend_title = legend_title,
                       bg_color = 'white',
                       text_color = 'black', ...)
  p$diff[[1]] <- p$diff[[1]] + labs(title = 'Difference (B-A)')
  p$compare_brains <- wrap_plots(list(p$a, p$b, p$diff), ncol = 1)

  p$cor <- plot_cor('a', 'b', df) +
    geom_abline(intercept = 0, slope = 1, linetype = 'dashed')
  p$ba <- plot_bland_altman('a', 'b', df, ci = ci) +
    labs(subtitle = lm2apa(lm(diff ~ 1, df)) |> str_replace(', 95%', '<br>95%'))
  p$stats <- wrap_plots(list(p$cor, p$ba), ncol = 1)
  p$combined <- (p$compare_brains | p$stats) +
    plot_layout(widths = c(2, 1))

  if (!is.null(out_path)) {
    ggsave(filename = out_path, plot = p$combined, width = out_width, height = out_height, units = 'in')
  }

  return(p$combined)

}
