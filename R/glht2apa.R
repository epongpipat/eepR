#' glht2apa
#' @description converts \code{glht()} contrast model to APA format string
#' @concept stats
#' @family model2apa
#' @param m model from \code{multcomp::glht()}
#' @param terms specify terms to print in APA format (default: all)
#' @param level specify confidence level (default: 0.95)
#' @param digits specify digit to round statistics (default: 3)
#' @param format specify format (default: html) (options: html, plain)
#' @param test statistical test for \code{glht} models. Options are "t" (default) for t-tests (multiple comparisons/pairwise contrasts) and "F" for joint F-tests.
#'
#' @returns Character string with APA-formatted results.
#' @export
#' @importFrom scales scientific
#' @importFrom glue glue
#' @importFrom effectsize F_to_eta2_adj t_to_eta2_adj
glht2apa <- function(m, terms = 'all', level = 0.95, digits = 3, format = 'html', test = c('t', 'F')) {
  test <- match.arg(test)

  # Check validation of level and format
  if (level <= 0 || level >= 1) {
    stop(glue("invalid level ({level}). must be within > 0 and < 1"))
  }

  format_valid <- c('plain', 'html')
  if (!format %in% format_valid) {
    stop(glue("not a valid format ({format}). must be either: {paste0(format_valid, collapse = ', ')}"))
  }

  if (test == 'F') {
    # F-test logic
    if (inherits(m, "summary.glht")) {
      fitcs <- m
    } else if (inherits(m, "glht")) {
      fitcs <- summary(m, test = multcomp::Ftest())
    } else {
      stop("model must be a glht or summary.glht object")
    }

    F_stat <- as.vector(fitcs$test$fstat)[1]
    df1 <- fitcs$test$df[1]
    df2 <- fitcs$test$df[2]
    
    F_stat_str <- format_numeric(F_stat, digits = digits, format = format)
    if (format == 'html') {
      F_str <- glue("<i>F</i>({df1}, {df2}) = {F_stat_str}")
    } else if (format == 'plain') {
      F_str <- glue("F({df1}, {df2}) = {F_stat_str}")
    }

    p <- as.vector(fitcs$test$pvalue)[1]
    p_formatted <- format_numeric(p, digits = digits, format = format)
    if (format == 'html') {
      p_str <- glue("<i>p</i> = {p_formatted}")
    } else if (format == 'plain') {
      p_str <- glue("p = {p_formatted}")
    }

    rsq_adj <- F_to_eta2_adj(F_stat, df = df1, df_error = df2)[[1]]
    rsq_adj_val <- format_numeric(rsq_adj, digits = digits, format = format)
    if (format == 'html') {
      rsq_adj_str <- glue("<i>R<sup>2</sup><sub>Adj.</sub></i> = {rsq_adj_val}")
    } else if (format == 'plain') {
      rsq_adj_str <- glue("Adjusted R-Squared = {rsq_adj_val}")
    }

    return(glue("{F_str}, {p_str}, {rsq_adj_str}"))

  } else {
    # t-test logic
    if (inherits(m, "summary.glht")) {
      fitcs <- m
    } else if (inherits(m, "glht")) {
      fitcs <- summary(m)
    } else {
      stop("model must be a glht or summary.glht object")
    }

    stats_str <- NULL
    coefficients <- fitcs$test$coefficients
    term_names <- names(coefficients)

    # filter terms
    if (length(terms) == 1 && terms == 'all') {
      indices <- 1:length(coefficients)
    } else {
      indices <- which(term_names %in% terms)
      if (length(indices) == 0) {
        stop("there are no valid terms")
      }
    }

    # degrees of freedom
    df_r <- fitcs$df
    if (is.null(df_r) || length(df_r) == 0 || df_r == 0) {
      df_r <- tryCatch(fitcs$model$df.residual, error = function(e) NULL)
    }
    if (is.null(df_r) || length(df_r) == 0) {
      df_r <- NA_real_
    }

    # confidence intervals
    ci_obj <- confint(fitcs, level = level)

    for (i in indices) {
      b <- coefficients[i]
      b_formatted <- format_numeric(b, digits = digits, format = format)
      if (format == 'html') {
        b_str <- glue("<i>b</i> = {b_formatted}")
      } else if (format == 'plain') {
        b_str <- glue("b = {b_formatted}")
      }

      t_val <- fitcs$test$tstat[i]
      t_formatted <- format_numeric(t_val, digits = digits, format = format)
      if (format == 'html') {
        t_str <- glue("<i>t</i>({df_r}) = {t_formatted}")
      } else if (format == 'plain') {
        t_str <- glue("t({df_r}) = {t_formatted}")
      }

      p <- fitcs$test$pvalues[i]
      p_formatted <- format_numeric(p, digits = digits, format = format)
      if (format == 'html') {
        p_str <- glue("<i>p</i> = {p_formatted}")
      } else if (format == 'plain') {
        p_str <- glue("p = {p_formatted}")
      }

      rsq_adj <- t_to_eta2_adj(t_val, df_error = df_r)[[1]]
      rsq_adj_val <- format_numeric(rsq_adj, digits = digits, format = format)
      if (format == 'html') {
        rsq_adj_str <- glue("<i>R<sup>2</sup><sub>Adj.</sub></i> = {rsq_adj_val}")
      } else if (format == 'plain') {
        rsq_adj_str <- glue("Adjusted R-Squared = {rsq_adj_val}")
      }

      b_ll <- ci_obj$confint[i, 2]
      b_ul <- ci_obj$confint[i, 3]
      b_ll_str <- format_numeric(b_ll, digits = digits, format = format)
      b_ul_str <- format_numeric(b_ul, digits = digits, format = format)

      ci_str <- glue("{level*100}% CI [{b_ll_str}, {b_ul_str}]")

      tmp_str <- glue("{b_str}, {t_str}, {p_str}, {ci_str}, {rsq_adj_str}")
      stats_str <- c(stats_str, tmp_str)
    }

    names(stats_str) <- term_names[indices]
    return(stats_str)
  }
}
