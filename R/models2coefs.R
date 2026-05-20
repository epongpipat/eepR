#' models2coefs
#'
#' @description combines model(s) into a single coefficients table. Uses \code{tidy_es()} and adds extra columns of extra model attributes
#' @concept stats
#' @param model a single model or a list of models
#' @param attribute name of attribute list to turn in columns (default: 'extra_info')
#' @return data.frame of extra_info of model attributes, renamed tidy, and effect size
#' @export
#'
#' @examples
#' m1 <- lm(salary ~ yrs.since.phd, carData::Salaries)
#' attr(m1, 'extra_info') <- list(m = 1, another_key = 'another_value')
#' models2coefs(m1)
#' @importFrom dplyr bind_rows
models2coefs <- function(models, attribute = 'extra_info') {

  # checks
  if (!is.null(attr(models, 'class'))) {
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
