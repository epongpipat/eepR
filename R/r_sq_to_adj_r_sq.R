#' @title r_sq_to_adj_r_sq
#' @description Convert r-squared ($R^2$) to adjusted r-squared ($R^2_{Adj.}$).
#' @concept stats
#' @param r_sq r-squared ($R^2$) value
#' @param n number of subjects/rows
#' @param n_p number of parameters
#'
#' @return adjusted r-squared ($R^2_{Adj.}}) value
#' @export
#'
#' @examples
#' r_sq_to_adj_r_sq(.5, 100, 5)
r_sq_to_adj_r_sq <- function(r_sq, n, n_p) {
  adj_r_sq <- 1 - (1 - r_sq) * ((n - 1) / (n - n_p))
  return(adj_r_sq)
}
