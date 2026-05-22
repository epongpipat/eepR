unscale <- function(x) {
  X <- as.matrix(x)
  if (is.null(attr(x,"scaled:center"))) {
    M <- rep(0, ncol(X))
  } else {
    M <- attr(x,"scaled:center")
  }

  if (is.null(attr(x,"scaled:scale"))) {
    S <- rep(1, ncol(X))
  } else {
    S <- attr(x,"scaled:scale")
  }

  Y <- NULL
  for (j in 1:ncol(X)) {
    Y <- cbind(Y, X[, j] * S[j] + M[j])
  }
  return(Y)
}


unscale <- function(x) {
  # 1. Extract attributes before they are lost
  M <- attr(x, "scaled:center")
  S <- attr(x, "scaled:scale")

  # 2. Convert to matrix safely
  # data.matrix handles data frames better than as.matrix for numeric conversion
  X <- data.matrix(x)

  # 3. Standardize parameters (Center = 0, Scale = 1 if missing)
  # We use as.numeric() on M and S to strip any names they might carry
  if (is.null(M)) M <- rep(0, ncol(X)) else M <- as.numeric(M)
  if (is.null(S)) S <- rep(1, ncol(X)) else S <- as.numeric(S)

  # 4. Perform the inverse math
  # We use t() for reliable vectorization across columns
  Y <- t(t(X) * S + M)

  # 5. Final Cleanup: Ensure attributes are NULL
  # Re-assigning to matrix strips extra attributes except dim/dimnames
  Y <- matrix(as.vector(Y), nrow = nrow(X), ncol = ncol(X))
  colnames(Y) <- colnames(X)

  return(Y)
}

unscale(scale(carData::Salaries[, c(3)]))
unscale(scale(carData::Salaries[, c(3, 4)]))
x3 <- carData::Salaries[, c(3, 4)] |> dplyr::mutate(yrs.service = scale(yrs.service))
unscale(x3)

unscale_min_max <- function(x) {
  X <- as.matrix(x)
  if (is.null(attr(x,"scaled:min"))) {
    min <- rep(0, ncol(X))
  } else {
    min <- attr(x,"scaled:min")
  }

  if (is.null(attr(x,"scaled:max"))) {
    max <- rep(0, ncol(X))
  } else {
    max <- attr(x,"scaled:max")
  }

  Y <- NULL
  for (j in 1:ncol(X)) {
    y <- X[, j] * (max[j] - min[j]) + min[j]
    Y <- cbind(Y, y)
  }
  return(Y)
}


