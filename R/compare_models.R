#' @title compare_models
#'
#' @param model_1 a model to compare
#' @param model_2 the other model to compare
#'
#' @return comparison of the two models
#' @export
#' @import tibble broom
#' @examples
#' data <- carData::Salaries
#' model_1 <- lm(salary ~ yrs.since.phd * rank, data)
#' model_2 <- lm(salary ~ yrs.since.phd * rank * sex, data)
#' compare_models(model_1, model_2)
compare_models <- function(model_1, model_2) {

  # ensure sample matches
  n_1 <- length(model_1$residuals)
  n_2 <- length(model_2$residuals)
  if (n_1 != n_2) {
    stop("samples sizes do not match. n1 = ", n_1, ", n2 = ", n_2)
  }

  # swap order to ensure 1 is the reduced model
  n_terms_1 <- length(tidy(model_1)$term)
  n_terms_2 <- length(tidy(model_2)$term)
  if (n_terms_1 > n_terms_2) {
    model_1_orig <- model_1
    model_1 <- model_2
    model_2 <- model_1_orig
  }

  # ensure models are nested
  terms_1 <- tidy(model_1)$term
  terms_2 <- tidy(model_2)$term
  n_terms_1 <- length(terms_1)
  n_terms_2 <- length(terms_2)
  n_terms_check <- length(terms_1[terms_1 %in% terms_2])
  if (n_terms_1 != n_terms_check) {
    stop("models are not nested")
  } else if (n_terms_1 == n_terms_2) {
    stop("models have the same number of terms")
  }

  formula_1 <- paste(model_1$call)[[2]]
  formula_2 <- paste(model_2$call)[[2]]
  n <- n_1
  sse_1 <- sum(model_1$residuals^2)
  sse_2 <- sum(model_2$residuals^2)
  n_p_1 <- length(model_1$coefficients)
  n_p_2 <- length(model_2$coefficients)
  df_r <- n_p_2 - n_p_1
  df_res_1 <- n - n_p_1
  df_res_2 <- n - n_p_2
  ssr <- sse_1 - sse_2
  r_sq <- ssr / sse_1
  adj_r_sq <- r_sq_to_adj_r_sq(r_sq, n, n_p_2)
  f <- (ssr / df_r) / (sse_2 / df_res_2)
  #f <- (r_sq / df_r) / ((1 - r_sq) / df_res_2)
  p <- pf(f, df_r, df_res_2, lower.tail = F)

  tibble(model = c(1, 2),
         formula = c(formula_1, formula_2),
         n,
         n_p = c(n_p_1, n_p_2),
         sse = c(sse_1, sse_2),
         ssr = c(NA, ssr),
         df_r = c(NA, df_r),
         df_residual = c(df_res_1, df_res_2),
         f_statistic = c(NA, f),
         r_sqaure = c(NA, r_sq),
         adj_r_squared = c(NA, adj_r_sq),
         p.value = c(NA, p)
  )
}
