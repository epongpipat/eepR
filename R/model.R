#' model
#' @concept model_uber
#' @param x
#' @param y
#' @param pkg
#' @param fun
#' @param args
#'
#' @return
#' @export
#'
#' @examples
model <- function(x, y, pkg, fun, args = NULL, id = NULL) {

  if (is.null(args)) {
    args <- list()
  }

  if (!is.list(args)) {
    stop("args is not a list")
  }

  if (!is.null(id)) {
    x <- x[, -id]
    y <- y[, -id]
  }

  args$x <- x
  args$y <- y
  fun_name <- glue("{pkg}::{fun}")
  do.call(eval(parse(text = fun_name)), args)

}
