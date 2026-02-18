#' cor2apa
#' @description converts `cor.test` model to APA format string
#' @param m model from `cor.test()`
#' @param digits round statistics to specified digit
#' @returns
#' @export
#'
#' @examples cor.test()
#' @importFrom broom tidy
#' @importFrom scales scientific
#' @importFrom glue glue
cor2apa <- function(m, digits = 3) {
  # cor_fit <- cor.test(df_post$pos, df_post$cog)
  cor_tidy <- tidy(m)
  
  r_stat_str <- glue("r({cor_tidy[['parameter']]}) = {round(cor_tidy[['estimate']], 3)}")
  
  p <- cor_tidy[['p.value']]
  if (p < .001) {
    p_str <- scientific({cor_tidy[['p.value']]})
  } else {
    p_str <- sprintf(glue('%.{digits}f'), p)
  }
  p_str <- glue("p = {p_str}")

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
  
  ci_str <- glue("95% CI [{ci_ll}, {ci_ul}]")
  stat_str <- glue("{r_stat_str}, {p_str}, {ci_str}")
  return(stat_str)
}
