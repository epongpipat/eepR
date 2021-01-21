#' @title tryCatch2
#' @concept r_helper
#' @param expr
#'
#' @return
#' @export
#'
#' @examples
tryCatch2 <- function(expr) {
  tryCatch({
    expr
  }, error = function(e) {
    print(e)
  })
}
