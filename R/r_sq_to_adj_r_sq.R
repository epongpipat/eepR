#' @title r_sq_to_adj_r_sq
#' @param r_sq r-squared (r^2) value
#' @param n number of subjects/rows
#' @param n_p number of parameters
#'
#' @return adjusted r-squared (r^2) value
#' @export
#'
#' @examples
#' # to be added
r_sq_to_adj_r_sq <- function(r_sq, n, n_p) {
  adj_r_sq <- 1 - (1 - r_sq) * ((n - 1) / (n - n_p))
  return(adj_r_sq)
}
