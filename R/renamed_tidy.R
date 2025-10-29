#' Title
#'
#' @param model 
#'
#' @return
#' @export
#'
#' @examples
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