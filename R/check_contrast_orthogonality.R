#' @title check_contrast_orthogonality
#' @description checks to make sure that a contrast of a factor is orthogonal.
#' @details checks to make sure that a contrast of a factor is orthogonal by ensuring
#' (1) sum of each contrast equals 0
#' and (2) sum of each product of each contrast pair equals 0
#' @param x contrast table/matrix
#' @concept stats
#' @return
#' @export
#'
#' @examples
#' contrast_example <- data.frame(c1 = c(1/3, 1/3, -2/3),
#'                                c2 = c(-1/2, 1/2, 0))
#' check_contrast_orthogonality(contrast_example)
check_contrast_orthogonality <- function(x) {
  x <- as.matrix(x)
  if (sum(colSums(x)) == 0) {
    cat('rule 1. sum of each contrast equals 0', '\u2713', '\n')
  } else {
    cat('rule 1. sum of each contrast equals 0', '\u274C', '\n')
    cat(colnames(x), '\n')
    cat(colSums(x), '\n\n')
  }

  sp <- t(x) %*% x
  sp[upper.tri(sp)] <- NA
  sp[diag(sp)] <- NA
  if (sum(sp[lower.tri(sp)]) == 0) {
    cat('rule 2. sum of products of contrast pairs equals 0', '\u2713', '\n')
  } else {
    cat('rule 2. sum of products of contrast pairs equals 0', '\u274C', '\n')
    print(as.matrix(sp))
  }
}
