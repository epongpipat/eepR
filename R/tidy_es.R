#' tidy_eep
#' @description a modification of the tidy command
#'
#' @param model model fit from lm()
#' @param ci confidence interval (0, 1)
#'
#' @return data.frame
#' @export
#' @import dplyr
#' @importFrom effectsize F_to_eta2_adj 
#' @importFrom broom tidy
#' @importFrom glue glue
#' @examples tidy_eep(salary ~ yrs.since.phd, carData::Salaries)
tidy_eep <- function(model, ci = 0.95) {
  if (attributes(model)$class != 'lm') {
    stop(glue("attribute must be lm (attribute: {attributes(model)$class})"))
  }
  
  df_tidy <- tidy(model) %>%
    rename(rh = term,
           b = estimate,
           se = std.error,
           t = statistic,
           p = p.value)
  
  b_ci <- confint(model, level = ci)
  colnames(b_ci) <- c('b_ci_ll', 'b_ci_ul')
  df_tidy <- cbind(df_tidy, b_ci)
  rownames(df_tidy) <- NULL
  
  r_sq_adj <- F_to_eta2_adj(df_tidy$t^2, df = 1, df_error = model$df.residual, ci = ci) %>%
    select(-CI)
  colnames(r_sq_adj) <- c('r_sq_adj', 'r_sq_adj_ci_ll', 'r_sq_adj_ci_ul')
  df_tidy <- cbind(df_tidy, r_sq_adj)
  
  df_tidy <- df_tidy %>%
    select(rh, b, se, t, p, r_sq_adj, everything())
  
  return(df_tidy)
}