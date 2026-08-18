#' lm2apa
#' @description converts \code{lm()} model to APA format string
#' @concept stats
#' @family model2apa
#' @param m model from \code{lm()}
#' @param terms specify terms to print in APA format (default: all)
#' @param level specify confidence level (default: 0.95)
#' @param digits specify digit to round statistics (default: 3)
#' @param format specify format (default: html) (options: html, plain)

#' @returns Character string with APA-formatted linear model results.
#' @export
#' @examples lm2apa(lm(mpg ~ wt, data = mtcars), format = 'plain')
#' @importFrom broom tidy
#' @importFrom broom glance
#' @importFrom scales scientific
#' @importFrom glue glue
#' @importFrom effectsize t_to_eta2_adj
#' @importFrom dplyr select
lm2apa <- function(m, terms = 'all', level = 0.95, digits = 3, format = 'html') {

  model_tidy <- tidy(m)

  # checks
  if (level <= 0 | level >= 1) {
    stop(glue("invalid level ({level}). must be within > 0 and < 1"))
  }

  format_valid <- c('plain', 'html')
  if (!format %in% format_valid) {
    stop(glue("not a valid format ({format}). must be either: {paste0(format_valid, collapse = ', ')}"))
  }


  model_ci <- confint(m, level = level)
  colnames(model_ci) <- c('ci_ll', 'ci_ul')
  model_tidy <- cbind(model_tidy, model_ci)
  stat_str <- NULL

  if (terms != 'all') {
    model_tidy <- model_tidy |>
      filter(term %in% terms)
  }

  if (nrow(model_tidy) == 0) {
    stop('there are no valid terms')
  }

  # df_stat_str <- model_tidy |>
    # select(term)
  for (i in 1:nrow(model_tidy)) {
    tmp <- list()

    tmp$b <- model_tidy[[i, 'estimate']]
    tmp$b_formatted <- format_numeric(tmp$b, digits = digits, format = format)
    if (format == 'html') {
      tmp$b_str <- glue("<i>b</i> = {tmp$b_formatted}")
    } else if (format == 'plain') {
      tmp$b_str <- glue("b = {tmp$b_formatted}")
    }


    tmp$df <- glance(m)[['df.residual']]
    tmp$t <- model_tidy[[i, 'statistic']]
    tmp$t_formatted <- format_numeric(tmp$t, digits = digits, format = format)
    if (format == 'html') {
      tmp$t_str <- glue("<i>t</i>({tmp$df}) = {tmp$t_formatted}")
    } else if (format == 'plain') {
      tmp$t_str <- glue("t({tmp$df}) = {tmp$t_formatted}")
    }


    tmp$p <- model_tidy[[i, 'p.value']]
    tmp$p_formatted <- format_numeric(tmp$p, digits = digits, format = format)
    if (format == 'html') {
      tmp$p_str <- glue("<i>p</i> = {tmp$p_formatted}")
    } else if (format == 'plain') {
      tmp$p_str <- glue("p = {tmp$p_formatted}")
    }

    tmp$ci_ll <- format_numeric(model_tidy[[i, 'ci_ll']], digits = digits, format = format)
    tmp$ci_ul <- format_numeric(model_tidy[[i, 'ci_ul']], digits = digits, format = format)

    tmp$ci_str <- glue("{level*100}% CI [{tmp$ci_ll}, {tmp$ci_ul}]")

    r_sq_adj_val <- t_to_eta2_adj(tmp$t, tmp$df)[[1]]
    tmp$r_sq_adj <- format_numeric(r_sq_adj_val, digits = digits, format = format)
    if (format == 'html') {
      tmp$r_sq_adj_str <- glue('<i>R<sup>2</sup><sub>Adj.</sub></i> = {tmp$r_sq_adj}')
    } else if (format == 'plain') {
      tmp$r_sq_adj_str <- glue('Adjusted R-Squared = {tmp$r_sq_adj}')
    }



    tmp$stat_str <- glue("{tmp$b_str}, {tmp$t_str}, {tmp$p_str}, {tmp$ci_str}, {tmp$r_sq_adj_str}")
    names(tmp$stat_str) <- model_tidy[[i, 'term']]
    # df_stat_str$stat_str[i] <- tmp$stat_str
    stat_str <- c(stat_str, tmp$stat)

  }

  return(stat_str)
}

