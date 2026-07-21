#' lm_cope_t
#' @description
#' perform a contrast over parameter estimate (COPE) \emph{t}-test
#' @concept stats
#'
#' @param model_fit model fitted using \code{lm()}
#' @param c contrast matrix
#'
#' @return data.frame with columns term, b, se, t, and p
#' @family lm_cope
#' @export
#' @importFrom MASS ginv
#' @examples
#' model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
#' c <- rbind(
#'   AssocProf_minus_AsstProf = c(0, 1, 0, 0),
#'   Prof_minus_AsstProf      = c(0, 0, 1, 0),
#'   Prof_minus_AssocProf     = c(0, -1, 1, 0)
#' )
#' lm_cope_t(model_fit, c)
lm_cope_t <- function(model_fit, c) {
  # check model
  if (!inherits(model_fit, "lm")) {
    stop("model_fit must be a model fitted using lm")
  }

  # obtain from model
  B <- coefficients(model_fit)
  X <- model.matrix(model_fit)
  e <- residuals(model_fit)
  df_r <- nrow(X) - ncol(X)
  mse <- (t(e) %*% e) / df_r
  mse <- mse[1, 1]

  # check dims
  if (ncol(c) != ncol(X)) {
    stop(sprintf(
      "number of columns of the COPE matrix (c) and design matrix (X) must be equal (c: %d, X: %d)",
      ncol(c), ncol(X)
    ))
  }

  # t-contrast
  cB <- c %*% B
  se <- as.matrix(sqrt(diag((c %*% MASS::ginv(t(X) %*% X) %*% t(c)) * mse)))
  t <- cB / se
  p <- ifelse(t > 0,
    2 * pt(t, df_r, lower = FALSE),
    2 * pt(t, df_r, lower = TRUE)
  )

  # table
  coef_table <- data.frame(
    term = rownames(c),
    b = cB,
    se = se,
    t = t,
    p = p
  )

  return(coef_table)
}


#' lm_cope_F
#' @description
#' perform a contrast over parameter estimate (COPE) \emph{F}-test
#' @concept stats
#'
#' @param model_fit model fitted using \code{lm()}
#' @param c contrast matrix
#' @param label label for the contrast term
#'
#' @return data.frame with columns term, ss, df, ms, F, and p
#' @family lm_cope
#' @export
#' @importFrom MASS ginv
#' @examples
#' model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
#' c <- rbind(
#'   c(0, 1, 0, 0),
#'   c(0, 0, 1, 0)
#' )
#' lm_cope_F(model_fit, c, label = "rank")
lm_cope_F <- function(model_fit, c, label) {
  # check model
  if (!inherits(model_fit, "lm")) {
    stop("model_fit must be a model fitted using lm")
  }

  # obtain from model
  B <- as.matrix(coefficients(model_fit))
  X <- model.matrix(model_fit)
  df_r <- nrow(X) - ncol(X)
  e <- residuals(model_fit)
  mse <- (t(e) %*% e) / df_r
  mse <- mse[1, 1]

  # check dims
  if (ncol(c) != ncol(X)) {
    stop(sprintf(
      "number of columns of the COPE matrix (c) and design matrix (X) must be equal (c: %d, X: %d)",
      ncol(c), ncol(X)
    ))
  }

  # F-contrast
  cB <- c %*% B
  c_orig <- diag(nrow = dim(B), ncol = dim(B))
  rownames(c_orig) <- colnames(X)
  covB <- (c_orig %*% ginv(t(X) %*% X) %*% t(c_orig)) * mse
  F <- t(cB) %*% ginv(nrow(c) * c %*% covB %*% t(c)) %*% cB

  # p-value
  df_n <- nrow(c)
  p <- pf(F, df_n, df_r, lower.tail = FALSE)

  # table
  anova_table <- data.frame(
    term = label,
    ss = F * mse * df_n,
    df = df_n,
    ms = F * mse,
    "F" = F,
    "p" = p
  )

  return(anova_table)
}
