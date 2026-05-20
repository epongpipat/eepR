#' models2coefs
#'
#' @param model a single model or a list of models
#' @param attribute name of attribute list to turn in columns (default: 'extra_info')
#' @return data.frame of extra_info of model attributes, renamed tidy, and effect size
#' @export
#'
#' @examples
#' m1 <- lm(salary ~ yrs.since.phd, carData::Salaries)
#' attr(m1, 'extra_info') <- list(m = 1, another_key = 'another_value')
#' tidy_extra_info(m1)
models2coefs <- function(models, attribute = 'extra_info') {

  # checks
  if (length(models) == 1) {
    models <- list(models)
  }

  lapply(models, function(m) {
    df1 <- data.frame(attr(m, attribute))
    df2 <- tidy_es(m)
    df <- cbind(df1, df2)
    rownames(df) <- NULL
    return(df)
  }) |>
    bind_rows()

}
