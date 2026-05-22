#' model
#' @concept model_uber
#' @family model wrappers
#' @param x features/predictors passed to the modeling function
#' @param y outcome passed to the modeling function
#' @param pkg package name that contains the modeling function
#' @param fun modeling function name
#' @param args named list of additional arguments passed to the modeling function
#' @param id optional column name or index to drop from both \code{x} and \code{y}
#'
#' @return Fitted model returned by the requested modeling function.
#' @export
#'
#' @examples
#' x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
#' y <- iris["Species"]
#' model(x, y, pkg = "e1071", fun = "svm", args = list(kernel = "linear"))
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
