#' plot_brain
#' @concept neuroimaging
#' @concept visualization
#' @param data 3D brain data
#' @param indices slices index of i, j, and k to plot
#' @param legend_position position of the legend can be bottom or NULL (default)
#' @param bg_color background color (default: black)
#' @param text_color text color (default: white)
#' @param out_path path to save image (default: NULL)
#' @param out_width width to saved image in inches (default: 11)
#' @param out_height height of saved image in inches (default: 8.5)
#' @param ... extra options to pass to `plot_brain_slice()`
#'
#' @return ggplot2 figure of all three directions (i, j, k)
#' @export
#'
#' @examples
plot_brain <- function(data, indices = NULL, legend_position = NULL, bg_color = 'black', text_color = 'white',
                       out_path = NULL, out_width = 12, out_height = 3, ...) {

  # checks
  if (is.null(indices)) {
    indices <- dim(data)/2
  }

  # main
  plot_theme <- theme(plot.background = element_rect(fill = bg_color, color = bg_color),
                      panel.background = element_rect(fill = bg_color, color = bg_color),
                      panel.grid.major = element_line(color = bg_color),
                      panel.grid.minor = element_line(color = bg_color),
                      text = element_text(color = text_color))

  p <- list()
  p$i <- plot_brain_slice(extract_brain_slice(data, dir = 'i', slice = indices[1]), ...) +
    plot_theme
  p$j <- plot_brain_slice(extract_brain_slice(data, dir = 'j', slice = indices[2]), ...) +
    plot_theme
  p$k <- plot_brain_slice(extract_brain_slice(data, dir = 'k', slice = indices[3]), ...)  +
    plot_theme
  p$brain <- wrap_plots(p, nrow = 1) +
    plot_layout(guides = 'collect') +
    plot_theme

  if (is.null(legend_position)) {
    p$brain <- p$brain
  } else if (legend_position == 'bottom') {
    p$brain <- p$brain + plot_annotation(theme = move_legend_to_btm())
  }

  if (!is.null(out_path)) {
    ggsave(filename = out_path, plot = p$brain, width = out_width, height = out_height)
  }

  return(p$brain)

}
