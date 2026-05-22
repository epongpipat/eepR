#' @title tryCatch2
#' @concept r_helper
#' @family error helpers
#' @param expr expression to evaluate with error printing
#'
#' @return result of \code{expr}, or printed error if \code{expr} fails
#' @export
#'
#' @examples
#' tryCatch2(1 + 1)
#' tryCatch2(stop("example error"))
tryCatch2 <- function(expr) {
  tryCatch({
    expr
  }, error = function(e) {
    print(e)
  })
}
