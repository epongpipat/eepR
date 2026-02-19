#' move_legend_to_btm
#' @concept visualization
#' @returns
#' @export
#'
#' @examples
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


