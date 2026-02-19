#' get_lm_multicollinearity
#' @concept stats
#' @param model fitted model from \code{lm()}
#'
#' @return
#' @export
#' @import dplyr broom
#' @examples get_lm_multicollinearity(lm(salary ~ yrs.since.phd + yrs.service, carData::Salaries))
get_lm_multicollinearity <- function(model) {
  X <- model.matrix(model)
  tolerance <- list()
  vif <- list()
  for (i in 2:ncol(X)) {
    tmp <- list()
    tmp$x <- colnames(X)[-c(1, i)]
    tmp$y <- colnames(X)[i]
    tmp$formula <- glue("{tmp$y} ~ {paste0(tmp$x, collapse = '+')}")
    print(tmp$formula)
    tmp$model <- lm(eval(as.formula(tmp$formula)), model$model)
    tolerance[tmp$y] <- as.numeric(1 - glance(tmp$model)[['r.squared']])
    vif[tmp$y] <- as.numeric(1 / tolerance[[tmp$y]])
  }

  df_multicollinearity <- cbind(tolerance, vif) %>%
    as.data.frame() %>%
    rownames_to_column("term") %>%
    mutate(tolerance = as.numeric(tolerance),
           vif = as.numeric(vif))

  return(df_multicollinearity)
}
