#' tidy_es
#' @description a modification of the renamed tidy command to adds the effect
#' size (confidence intervals for the regression coefficient and adjusted R^2)
#' @concept stats
#' @family model summary helpers
#' @param model model fit from \code{lm()}, \code{lmerTest::lmer()}, \code{lme4::lmer()}, or \code{multcomp::glht()}
#' @param ci confidence interval (0, 1)
#' @return data.frame
#' @export
#' @examples
#' # example: lm
#' tidy_es(lm(salary ~ yrs.since.phd, carData::Salaries))
#'
#' # example: lmer
#' tidy_es(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy))
#'
#' # example: glht
#' model_fit <- lm(salary ~ rank + discipline, carData::Salaries)
#' c <- rbind(
#'   AssocProf_minus_AsstProf = c(0, 1, 0, 0),
#'   Prof_minus_AsstProf      = c(0, 0, 1, 0),
#'   Prof_minus_AssocProf     = c(0, -1, 1, 0)
#' )
#' model_fit_cope_t <- multcomp::glht(model_fit, c)
#' tidy_es(model_fit_cope_t)
tidy_es <- function(model, ci = 0.95) {
  if (inherits(model, 'glht')) {
    return(tidy_es_cope_t(model, ci = ci))
  } else if (inherits(model, 'lm')) {
    return(tidy_es_lm(model, ci = ci))
  } else if (inherits(model, 'lmerModLmerTest') || inherits(model, 'lmerMod')) {
    return(tidy_es_lmer(model, ci = ci))
  } else {
    stop(sprintf("class attribute must be glht, lm, lmerMod, or lmerModLmerTest (class: %s)", paste(class(model), collapse = ", ")))
  }
}

#' tidy_es_lm
#' @description a modification of the renamed tidy command that adds the effect
#' size (confidence intervals for the regression coefficient and adjusted R^2)
#' @concept stats
#' @family model summary helpers
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
#' @family model summary helpers
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
  df_ci <- as.data.frame(confint(model, level = ci, signames = FALSE))
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


#' tidy_es_cope_t
#' @description a modification of the tidy command that adds the effect
#' size (confidence intervals for the contrast coefficient and adjusted R^2)
#' for linear hypothesis testing contrasts (t-test) using glht
#' @concept stats
#' @family model summary helpers
#' @family contrast or COPE helpers
#' @param model contrast model from \code{multcomp::glht()}
#' @param ci confidence interval (0, 1)
#' @return data.frame
#' @export
#' @import dplyr
#' @importFrom effectsize t_to_eta2_adj
#' @importFrom multcomp glht
#' @examples
#' model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
#' c <- gen_contrast_ss(model_fit, x = "rank")[-1, ]
#' model_fit_cope_t <- multcomp::glht(model_fit, c)
#' tidy_es_cope_t(model_fit_cope_t)
tidy_es_cope_t <- function(model, ci = 0.95) {
  if (!inherits(model, "glht")) {
    stop("model must be a glht object")
  }

  sum_model <- summary(model)
  underlying_model <- model$model

  lh <- NA_character_
  op <- NA_character_
  if (!is.null(underlying_model)) {
    formula_val <- tryCatch(formula(underlying_model), error = function(e) NULL)
    if (!is.null(formula_val)) {
      lh <- as.character(formula_val)[2]
      op <- as.character(formula_val)[1]
    }
  }

  b <- sum_model$test$coefficients
  se <- sum_model$test$sigma
  t <- sum_model$test$tstat
  p <- sum_model$test$pvalues
  rh <- names(b)

  b_ci <- as.data.frame(confint(model, level = ci)$confint)
  b_ci_ll <- b_ci$lwr
  b_ci_ul <- b_ci$upr

  df <- rep(model$df, length(b))
  if ((is.null(model$df) || length(model$df) == 0 || model$df == 0) &&
      (inherits(underlying_model, "lmerMod") || inherits(underlying_model, "lmerModLmerTest"))) {
    df <- tryCatch({
      sapply(1:nrow(model$linfct), function(i) {
        lmerTest::contest1D(underlying_model, L = model$linfct[i, ])$df
      })
    }, error = function(e) {
      rep(NA_real_, length(b))
    })
  }

  r_sq_adj <- tryCatch({
    res <- effectsize::t_to_eta2_adj(t, df_error = df, ci = ci)
    if ("CI" %in% colnames(res)) {
      res <- res[, !colnames(res) %in% "CI", drop = FALSE]
    }
    res
  }, error = function(e) {
    data.frame(
      r_sq_adj = rep(NA_real_, length(t)),
      r_sq_adj_ci_ll = rep(NA_real_, length(t)),
      r_sq_adj_ci_ul = rep(NA_real_, length(t))
    )
  })
  colnames(r_sq_adj) <- c('r_sq_adj', 'r_sq_adj_ci_ll', 'r_sq_adj_ci_ul')

  df_out <- data.frame(
    lh = rep(lh, length(b)),
    op = rep(op, length(b)),
    rh = rh,
    b = as.vector(b),
    se = as.vector(se),
    df = as.vector(df),
    t = as.vector(t),
    p = as.vector(p),
    r_sq_adj,
    b_ci_ll = as.vector(b_ci_ll),
    b_ci_ul = as.vector(b_ci_ul)
  )

  df_out <- df_out %>%
    select(lh, op, rh, b, se, df, t, p, r_sq_adj, b_ci_ll, b_ci_ul, r_sq_adj_ci_ll, r_sq_adj_ci_ul)

  return(df_out)
}


#' tidy_es_cope_F
#' @description a modification of the tidy command that adds the effect
#' size (confidence intervals for the adjusted R^2) for linear hypothesis
#' testing contrasts (joint F-test) using glht
#' @concept stats
#' @family model summary helpers
#' @family contrast or COPE helpers
#' @param model contrast model from \code{multcomp::glht()}
#' @param label label for the contrast term (default: joined contrast names)
#' @param ci confidence interval (0, 1)
#' @return data.frame
#' @export
#' @import dplyr
#' @importFrom effectsize F_to_eta2_adj
#' @importFrom multcomp glht
#' @examples
#' model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
#' c <- gen_contrast_ss(model_fit, x = "rank")[-1, ]
#' model_fit_cope_F <- multcomp::glht(model_fit, c)
#' tidy_es_cope_F(model_fit_cope_F, label = "rank")
tidy_es_cope_F <- function(model, label = NULL, ci = 0.95) {
  if (!inherits(model, "glht")) {
    stop("model must be a glht object")
  }

  sum_model <- summary(model, test = multcomp::Ftest())
  underlying_model <- model$model

  lh <- NA_character_
  op <- NA_character_
  if (!is.null(underlying_model)) {
    formula_val <- tryCatch(formula(underlying_model), error = function(e) NULL)
    if (!is.null(formula_val)) {
      lh <- as.character(formula_val)[2]
      op <- as.character(formula_val)[1]
    }
  }

  if (is.null(label)) {
    label <- paste(rownames(model$linfct), collapse = ", ")
  }

  fstat <- sum_model$test$fstat[1, 1]
  df_num <- sum_model$test$df[1]
  df_den <- sum_model$test$df[2]
  p_val <- sum_model$test$pvalue[1, 1]
  ss <- sum_model$test$SSH[1, 1]
  ms <- ss / df_num

  if ((is.null(model$df) || length(model$df) == 0 || model$df == 0) &&
      (inherits(underlying_model, "lmerMod") || inherits(underlying_model, "lmerModLmerTest"))) {
    contest_res <- tryCatch({
      lmerTest::contest(underlying_model, L = model$linfct, joint = TRUE)
    }, error = function(e) NULL)
    if (!is.null(contest_res)) {
      df_num <- contest_res$NumDF[1]
      df_den <- contest_res$DenDF[1]
      fstat <- contest_res$`F value`[1]
      p_val <- contest_res$`Pr(>F)`[1]
      ss <- contest_res$`Sum Sq`[1]
      ms <- contest_res$`Mean Sq`[1]
    }
  }

  r_sq_adj <- tryCatch({
    res <- effectsize::F_to_eta2_adj(fstat, df = df_num, df_error = df_den, ci = ci)
    if ("CI" %in% colnames(res)) {
      res <- res[, !colnames(res) %in% "CI", drop = FALSE]
    }
    res
  }, error = function(e) {
    data.frame(
      r_sq_adj = NA_real_,
      r_sq_adj_ci_ll = NA_real_,
      r_sq_adj_ci_ul = NA_real_
    )
  })
  colnames(r_sq_adj) <- c('r_sq_adj', 'r_sq_adj_ci_ll', 'r_sq_adj_ci_ul')

  df_out <- data.frame(
    lh = lh,
    op = op,
    rh = label,
    ss = as.vector(ss),
    df = as.vector(df_num),
    ms = as.vector(ms),
    F = as.vector(fstat),
    p = as.vector(p_val),
    r_sq_adj
  )

  return(df_out)
}
