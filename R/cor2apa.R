#' cor2apa
#' @description converts \code{cor.test()} model to APA format string
#' @concept stats
#' @family model2apa
#' @param m model from \code{cor.test()}
#' @param level specify confidence level (default: 0.95). note: level should match the confidence level used in \code{cor.test()}. this argument does not actually update the confidence interval range, but only the reported confidence interval level
#' @param digits round statistics to specified digit
#' @param format specify format (default: html) (options: html, plain)
#'
#' @returns Character string with APA-formatted correlation results.
#' @export
#' @examples cor2apa(cor.test(carData::Salaries$yrs.since.phd, carData::Salaries$salary), format = 'plain')
#' @importFrom broom tidy
#' @importFrom scales scientific
#' @importFrom glue glue
cor2apa <- function(m, level = 0.95, digits = 3, format = 'html') {

  cor_tidy <- tidy(m)

  r_formatted <- format_numeric(cor_tidy[['estimate']], digits = digits, format = format)
  df_r <- cor_tidy[['parameter']]
  if (format == 'html') {
    r_stat_str <- glue("<i>r</i>({df_r}) = {r_formatted}")
  } else if (format == 'plain') {
    r_stat_str <- glue("r({df_r}) = {r_formatted}")
  }

  p_val <- cor_tidy[['p.value']]
  p_formatted <- format_numeric(p_val, digits = digits, format = format)
  if (format == 'html') {
    p_str <- glue("<i>p</i> = {p_formatted}")
  } else if (format == 'plain') {
    p_str <- glue("p = {p_formatted}")
  }

  ci_ll <- format_numeric(cor_tidy[['conf.low']], digits = digits, format = format)
  ci_ul <- format_numeric(cor_tidy[['conf.high']], digits = digits, format = format)
  ci_str <- glue("{level*100}% CI [{ci_ll}, {ci_ul}]")

  stat_str <- glue("{r_stat_str}, {p_str}, {ci_str}")

  return(stat_str)

}
