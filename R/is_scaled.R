#' is_centered
#' @concept data_wrangle
#' @param x a numeric vector or matrix
#' @param eps small error tolerance of being close enough to zero (default: 1e-8)
#'
#' @returns vector of logicals
#' @export
#'
#' @examples
#' is_centered(scale(c(1, 2, 2, 3, 3, 3)))
is_centered <- function(x, eps = 1e-8) {
  X <- as.matrix(x)
  Y <- apply(X, 2, function(x) {
    ifelse(mean(x) - 0 < eps, TRUE, FALSE)
  })
  return(Y)
}

#' is_z_scored
#' @concept data_wrangle
#' @param x a numeric vector or matrix
#' @param eps small error tolerance of being close enough to zero (default: 1e-8)
#'
#' @returns vector of logicals
#' @export
#'
#' @examples
#' is_z_scored(scale(c(1, 2, 2, 3, 3, 3)))
is_z_scored <- function(x, eps = 1e-8) {
  X <- as.matrix(x)
  Y <- apply(X, 2, function(x) {
    ifelse((mean(x) - 0) < eps & (sd(x) - 1) < eps, TRUE, FALSE)
  })
  return(Y)
}

#' is_ss1
#' @concept data_wrangle
#' @param x a numeric vector or matrix
#' @param eps small error tolerance of being close enough to zero (default: 1e-8)
#'
#' @returns vector of logicals
#' @export
#'
#' @examples
#' x <- c(1, 2, 2, 3, 3, 3)
#' is_ss1(scale(x) / sqrt(length(x)))
is_ss1 <- function(x, eps = 1e-8) {
  X <- as.matrix(x)
  Y <- apply(X, 2, function(x) {
    sum(x^2) - 1 < eps
  })
  return(Y)
}

#' is_scaled
#' @concept data_wrangle
#' @param x a numeric vector or matrix
#' @param type type of scaling to check for. Options are: "centered" (or "mean_centered"), "z_scored" (or "z"), and "ss1". Default is "z".
#' @param eps small error tolerance of being close enough to zero (default: 1e-8)
#'
#' @returns vector of logicals
#' @export
#'
#' @examples
#' is_scaled(scale(c(1, 2, 2, 3, 3, 3)))
is_scaled <- function(x, type = 'z', eps = 1e-8) {
  # checks
  valid_opts <- c("centered", "mean_centered", "z_scored", "z", "ss1")
  if (!type %in% valid_opts) {
    stop(paste("invalid type. type must be one of:", paste(valid_opts, collapse = ", ")))
  }

  # main
  if (type == "centered" | type == "mean_centered") {
    return(is_centered(x = x, eps = eps))
  } else if (type == "z_scored" | type == "z") {
    return(is_z_scored(x = x, eps = eps))
  } else if (type == "ss1") {
    return(is_ss1(x = x, eps = eps))
  }
}
