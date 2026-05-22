#' cor2apa
#' @description converts \code{cor.test()} model to APA format string
#' @concept stats
#' @param m model from \code{cor.test()}
#' @param level specify confidence level (default: 0.95). note: level should match the confidence level used in \code{cor.test()}. this argument does not actually update the confidence interval range, but only the reported confidence interval level
#' @param digits round statistics to specified digit
#' @param format specify format (default: html) (options: html, plain)
#'
#' @returns
#' @export
#'
#' @examples cor2apa(cor.test(carData::Salaries$yrs.since.phd, carData::Salaries$salary), format = 'plain')
#' @importFrom broom tidy
#' @importFrom scales scientific
#' @importFrom glue glue
cor2apa <- function(m, level = 0.95, digits = 3, format = 'html') {

  cor_tidy <- tidy(m)

  r <- round(cor_tidy[['estimate']], 3)
  df_r <- cor_tidy[['parameter']]
  if (format == 'html') {
    r_stat_str <- glue("<i>r</i>({df_r}) = {r}")
  } else if (format == 'plain') {
    r_stat_str <- glue("r({df_r}) = {r}")
  }

  p <- cor_tidy[['p.value']]
  if (p < .001) {
    p_str <- scientific({cor_tidy[['p.value']]})
  } else {
    p_str <- sprintf(glue('%.{digits}f'), p)
  }
  if (format == 'html') {
    p_str <- glue("<i>p</i> = {p_str}")
  } else if (format == 'plain') {
    p_str <- glue("p = {p_str}")
  }

  ci_ll <- cor_tidy[['conf.low']]
  if (abs(ci_ll) < .001) {
    ci_ll <- scientific(ci_ll, digits = digits)
  } else {
    ci_ll <- sprintf(glue('%.{digits}f'), ci_ll)
  }

  ci_ul <- cor_tidy[['conf.high']]
  if (abs(ci_ul) < .001) {
    ci_ul <- scientific(ci_ul, digits = digits)
  } else {
    ci_ul <- sprintf(glue('%.{digits}f'), ci_ul)
  }
  ci_str <- glue("{level*100}% CI [{ci_ll}, {ci_ul}]")

  stat_str <- glue("{r_stat_str}, {p_str}, {ci_str}")

  return(stat_str)

}
