#' tidy_es
#' @description a modification of the renamed tidy command to adds the effect
#' size (confidence intervals for the regression coefficient and adjusted R^2)
#' @concept stats
#' @param model model fit from \code{lm()}, \code{lmerTest::lmer()}, or \code{lme4::lmer()}
#' @param ci confidence interval (0, 1)
#' @return data.frame
#' @export
#' @examples
#' # example: lm
#' tidy_es(lm(salary ~ yrs.since.phd, carData::Salaries))
#'
#' # example: lmer
#' tidy_es(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy))
tidy_es <- function(model, ci = 0.95) {
  if (attributes(model)$class == 'lm') {
    return(tidy_es_lm(model, ci = ci))
  } else if (attributes(model)$class %in% c('lmerModLmerTest', 'lmerMod')) {
    return(tidy_es_lmer(model, ci = ci))
  } else {
    stop(sprintf("class attribute must be lm, lmerMod, or lmerModLmerTest (class: %s)", attributes(model)$class))
  }
}

#' tidy_es_lm
#' @description a modification of the renamed tidy command that adds the effect
#' size (confidence intervals for the regression coefficient and adjusted R^2)
#' @concept stats
#' @param model model fit from \code{lm()}
#' @param ci confidence interval (0, 1)
#' @return data.frame
#' @export
#' @import dplyr
#' @importFrom effectsize F_to_eta2_adj
#' @importFrom broom tidy
#' @importFrom glue glue
#' @examples tidy_es_lm(lm(salary ~ yrs.since.phd, carData::Salaries))
tidy_es_lm <- function(model, ci = 0.95) {
  if (attributes(model)$class != 'lm') {
    stop(glue("attribute must be lm (attribute: {attributes(model)$class})"))
  }

  df_tidy <- renamed_tidy(model)

  b_ci <- confint(model, level = ci)
  colnames(b_ci) <- c('b_ci_ll', 'b_ci_ul')
  df_tidy <- cbind(df_tidy, b_ci)
  rownames(df_tidy) <- NULL

  r_sq_adj <- t_to_eta2_adj(df_tidy$t, df_error = model$df.residual, ci = ci) %>%
    select(-CI)
  colnames(r_sq_adj) <- c('r_sq_adj', 'r_sq_adj_ci_ll', 'r_sq_adj_ci_ul')
  df_tidy <- cbind(df_tidy, r_sq_adj)

  df_tidy <- df_tidy %>%
    select(lh, op, rh, b, se, t, p, r_sq_adj, everything())

  return(df_tidy)
}


#' tidy_es_lmer

#' @description a modification of the renamed tidy command that adds the effect
#' size (confidence intervals for the regression coefficient and adjusted R^2)
#' @concept stats
#' @param model model output from \code{lmerTest::lmer()} or \code{lme4::lmer()}
#' @param ci confidence interval (default: 0.95)
#' @returns data.frame
#' @export
#' @import dplyr
#' @importFrom effectsize t_to_eta2_adj
#' @examples
#' tidy_es_lmer(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy))
tidy_es_lmer <- function(model, ci = 0.95) {

  if (!attributes(model)$class %in% c('lmerModLmerTest', 'lmerMod')) {
    stop(sprintf("class attribute must be lmerMod or lmerModLmerTest (class: %s)", attr(model, 'class')))
  }

  # coefficients
  model_summary <- summary(model)
  df_coef <- as.data.frame(model_summary$coefficients)
  colnames(df_coef) <- c('b', 'se', 'df', 't', 'p')
  df_coef$lh <- as.character(model_summary[["call"]]$formula)[2]
  df_coef$op <- as.character(model_summary[["call"]]$formula)[1]
  df_coef$rh <- rownames(df_coef)
  rownames(df_coef) <- NULL

  # ci
  df_ci <- as.data.frame(confint(model, level = ci, oldNames = FALSE))
  colnames(df_ci) <- c('b_ci_ll', 'b_ci_ul')
  df_ci$rh <- rownames(df_ci)

  # r^2 (adjusted)
  df_r_sq <- as.data.frame(t_to_eta2_adj(df_coef$t, df_error = df_coef$df, ci = ci)) |>
    select(-CI)
  colnames(df_r_sq) <- c('r_sq_adj', 'r_sq_adj_ci_ll', 'r_sq_adj_ci_ul')
  df_r_sq$rh <- df_coef$rh

  # combine
  df <- left_join(df_coef, df_ci, by = 'rh') |>
    left_join(df_r_sq, by = 'rh') |>
    select(lh, op, rh, b, se, df, t, p, r_sq_adj, b_ci_ll, b_ci_ul, r_sq_adj_ci_ll, r_sq_adj_ci_ul)

  return(df)

}
