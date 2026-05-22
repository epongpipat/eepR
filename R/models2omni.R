#' models2omni
#'
#' @description model(s) into a single omnibus table. Uses \code{broom::glance()} and adds extra columns of extra model attributes
#' @concept stats
#' @family model summary helpers
#' @param models a single model or a list of models
#' @param attribute name of attribute list to turn in columns (default: 'extra_info')
#' @return data.frame of extra_info of model attributes and glance
#' @export
#'
#' @importFrom broom glance
#' @importFrom dplyr bind_rows
#' @examples
#' m1 <- lm(salary ~ yrs.since.phd, carData::Salaries)
#' attr(m1, 'extra_info') <- list(m = 1, another_key = 'another_value')
#' models2omni(m1)
models2omni <- function(models, attribute = 'extra_info') {

  # checks
  if (!is.null(attr(models, 'class'))) {
    models <- list(models)
  }

  lapply(models, function(m) {
    df1 <- data.frame(attr(m, attribute))
    df2 <- glance(m)
    df <- cbind(df1, df2)
    rownames(df) <- NULL
    return(df)
  }) |>
    bind_rows()

}
