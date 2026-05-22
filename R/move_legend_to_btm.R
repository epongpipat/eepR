#' move_legend_to_btm
#' @concept visualization
#' @family plotting helpers
#' @param learn logical, whether to print the equivalent ggplot2 theme code
#' @returns ggplot2 theme object
#' @export
#'
#' @examples
#' plot_cor("wt", "mpg", mtcars) + move_legend_to_btm()
move_legend_to_btm <- function(learn = FALSE) {
  cmd='theme(
    legend.position = "bottom",
    legend.title.position = "top",
    legend.title.align = 0.5
  )'
  if (learn) {
    # cat('[CMD]\n')
    cat(cmd, '\n')
  }
  theme(
    legend.position = "bottom",
    legend.title.position = "top",
    legend.title.align = 0.5
  )
  # eval(cmd)
}

