#' renamed_tidy
#' @description Minor modification of the \code{tidy()} function that renames the columns to be more intuitive and adds the left-hand and operator columns for lm objects
#' @concept stats
#' @param model model fit from \code{lm()}
#'
#' @return data.frame
#' @export
#'
#' @examples renamed_tidy(lm(mpg ~ wt, data = mtcars))
renamed_tidy <- function(model) {
  df_tidy <- tidy(model)
  if (attributes(model)$class == 'lm') {
    df_tidy <- df_tidy %>%
      rename(rh = term,
             b = estimate,
             se = std.error,
             t = statistic,
             p = p.value) %>%
        mutate(lh = as.character(model[["terms"]][[2]]),
               op = as.character(model[["terms"]][[1]])) %>%
        select(lh, op, rh, b, se, t, p)
  } else if (attributes(model)$class == 'htest') {
    df_tidy <- df_tidy %>%
      rename(chisq = statistic,
             df = parameter,
             p = p.value)
  } else {
    stop(glue("not yet coded for work with the current class attribute ({attributes(model)$class})"))
  }
  return(df_tidy)
}
