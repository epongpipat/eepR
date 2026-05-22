scale_min_max <- function(x) {
  X <- as.matrix(x)
  Y <- apply(X, 2, function(x) {
    (x - min(x)) / (max(x) - min(x))
  })
  attr(Y, "scaled:min") <- apply(X, 2, min)
  attr(Y, "scaled:max") <- apply(X, 2, max)
  return(Y)
}

scale_unit_vector <- function(x) {
  X <- as.matrix(x)
  Y <- apply(X, 2, function(x) {
    scale(x, center = TRUE, scale = sd(x) * sqrt(length(x) - 1))
  })
  attr(Y, "scaled:center") <- apply(X, 2, mean)
  attr(Y, "scaled:scale") <- apply(X, 2, function(x) {
    sd(x) * sqrt(length(x) - 1)
  })
  return(Y)
}

