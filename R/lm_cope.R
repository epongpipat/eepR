#' lm_cope_t
#' @description
#' perform a contrast over parameter estimate (COPE) \emph{t}-test
#' @concept stats
#'
#' @param model_fit model fitted using \code{lm()}
#' @param c contrast matrix
#' @param ci confidence interval (default: 0.95)
#'
#' @return data.frame with columns term, b, se, t, p, b_ci_ll, b_ci_ul, r_sq_adj, r_sq_adj_ci_ll, and r_sq_adj_ci_ul
#' @family lm_cope
#' @export
#' @importFrom MASS ginv
#' @importFrom effectsize t_to_eta2_adj
#' @examples
#' model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
#' c <- rbind(
#'   AssocProf_minus_AsstProf = c(0, 1, 0, 0),
#'   Prof_minus_AsstProf      = c(0, 0, 1, 0),
#'   Prof_minus_AssocProf     = c(0, -1, 1, 0)
#' )
#' lm_cope_t(model_fit, c)
lm_cope_t <- function(model_fit, c, ci = 0.95) {
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

  # confidence intervals for contrast coefficient
  critical_t <- qt((1 - ci) / 2, df = df_r, lower.tail = FALSE)
  b_ci_ll <- cB - critical_t * se
  b_ci_ul <- cB + critical_t * se

  # effect sizes
  r_sq_adj <- effectsize::t_to_eta2_adj(as.vector(t), df_error = df_r, ci = ci)
  r_sq_adj$CI <- NULL
  names(r_sq_adj) <- c('r_sq_adj', 'r_sq_adj_ci_ll', 'r_sq_adj_ci_ul')

  # table
  coef_table <- data.frame(
    term = rownames(c),
    b = as.vector(cB),
    se = as.vector(se),
    t = as.vector(t),
    p = as.vector(p),
    b_ci_ll = as.vector(b_ci_ll),
    b_ci_ul = as.vector(b_ci_ul),
    r_sq_adj
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
#' @param ci confidence interval (default: 0.95)
#'
#' @return data.frame with columns term, ss, df, ms, F, p, r_sq_adj, r_sq_adj_ci_ll, and r_sq_adj_ci_ul
#' @family lm_cope
#' @export
#' @importFrom MASS ginv
#' @importFrom effectsize F_to_eta2_adj
#' @examples
#' model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
#' c <- rbind(
#'   c(0, 1, 0, 0),
#'   c(0, 0, 1, 0)
#' )
#' lm_cope_F(model_fit, c, label = "rank")
lm_cope_F <- function(model_fit, c, label, ci = 0.95) {
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
  F_val <- t(cB) %*% ginv(nrow(c) * c %*% covB %*% t(c)) %*% cB

  # p-value
  df_n <- nrow(c)
  p <- pf(F_val, df_n, df_r, lower.tail = FALSE)

  # effect sizes
  r_sq_adj <- effectsize::F_to_eta2_adj(as.vector(F_val), df = df_n, df_error = df_r, ci = ci)
  r_sq_adj$CI <- NULL
  names(r_sq_adj) <- c('r_sq_adj', 'r_sq_adj_ci_ll', 'r_sq_adj_ci_ul')

  # table
  anova_table <- data.frame(
    term = label,
    ss = as.vector(F_val * mse * df_n),
    df = df_n,
    ms = as.vector(F_val * mse),
    "F" = as.vector(F_val),
    "p" = as.vector(p),
    r_sq_adj
  )

  return(anova_table)
}
