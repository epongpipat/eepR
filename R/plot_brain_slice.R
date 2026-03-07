#' plot_brain_slice
#' @concept visualization
#' @concept neuroimaging
#' @param df brain slice data (output of `plot_brain_slice`)
#' @param title title of plot (default: NULL)
#' @param fill_limits limits of the fill
#' @param fill_low color of the lowest limit (default: black)
#' @param fill_mid color of the midpoint. assigning a color automatically using `scale_fill_gradient2` rather `scale_fill_gradient`
#' @param fill_midpoint midpoint value (default: 0)
#' @param fill_high color of the highest limit (default: white)
#' @param legend_position position of the legend (default: NULL). can also be 'bottom'
#' @param legend_title title of fill legend (default: NULL)
#' @param slice_label_offset slice label offset (default: 0.25)
#' @import ggplot2
#' @return
#' @export
#'
plot_brain_slice <- function(df,
                             title = NULL,
                             fill_limits = 'min_max',
                             fill_low = 'black',
                             fill_mid = NULL,
                             fill_midpoint = 0,
                             fill_high = 'white',
                             legend_position = NULL,
                             legend_title = NULL,
                             slice_label_offset = 0.25
) {

  # checks
  if (is.numeric(fill_limits) & length(fill_limits) == 2) {
    fill_limits <- fill_limits
  } else if (fill_limits == 'min_max') {
    fill_limits <- c(attr(df, 'extra_info')$min, attr(df, 'extra_info')$max)
  } else {
    stop(sprintf("invalid fill_limits (%s). fill_limits must be min_max or two numbers", fill_limits))
  }

  # main
  p <- ggplot(df, aes(x, y, fill = value)) +
    geom_tile() +
    coord_fixed()
  if (is.null(fill_mid)) {
    p <- p + scale_fill_gradient(low = fill_low, high = fill_high, limits = fill_limits)
  } else if (!is.null(fill_mid)){
    p <- p + scale_fill_gradient2(low = fill_low, high = fill_high, midpoint = fill_midpoint, mid = fill_mid, limits = fill_limits)
  }
  p <- p +
    annotate("text",
             x = min(df$x) + slice_label_offset * sd(df$x),
             y = max(df$y) - slice_label_offset * sd(df$y),
             label = glue("{attr(df, 'extra_info')$dir} = {attr(df, 'extra_info')$slice}"),
             color = 'white') +
    theme_void() +
    labs(title = title)

  if (!is.null(legend_title)) {
    p <- p +
      labs(fill = legend_title)
  }

  if (is.null(legend_position)) {
    p <- p
  } else if (legend_position == 'bottom') {
    p <- p + move_legend_to_btm()
  }

  return(p)
}
