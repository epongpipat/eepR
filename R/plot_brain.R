#' plot_brain
#' @concept neuroimaging
#' @concept visualization
#' @param data 3D brain data
#' @param indices slices index of i, j, and k to plot
#' @param legend_position position of the legend can be bottom or NULL (default)
#' @param ... extra options to pass to `plot_brain_slice`
#'
#' @return ggplot2 figure of all three directions (i, j, k)
#' @export
#'
#' @examples
plot_brain <- function(data, indices = NULL, legend_position = NULL, ...) {

  # checks
  if (is.null(indices)) {
    indices <- dim(data)/2
  }

  # main
  p <- list()
  p$i <- plot_brain_slice(extract_brain_slice(data, dir = 'i', slice = indices[1]), ...)
  p$j <- plot_brain_slice(extract_brain_slice(data, dir = 'j', slice = indices[2]), ...)
  p$k <- plot_brain_slice(extract_brain_slice(data, dir = 'k', slice = indices[3]), ...)
  p$brain <- wrap_plots(p, nrow = 1) +
    plot_layout(guides = 'collect')

  if (is.null(legend_position)) {
    p$brain <- p$brain
  } else if (legend_position == 'bottom') {
    p$brain <- p$brain + plot_annotation(theme = move_legend_to_btm())
  }

  return(p$brain)

}
