#' get_lm_multicollinearity
#' @concept stats
#' @param model fitted model from `lm()`
#'
#' @return
#' @export
#' @import dplyr broom
#' @examples
get_lm_multicollinearity <- function(model) {
  X <- model.matrix(model)
  tolerance <- list()
  vif <- list()
  for (i in 2:ncol(X)) {
    temp_x <- colnames(X)[-c(1, i)]
    temp_y <- colnames(X)[i]
    temp_formula <- glue("{temp_y} ~ {paste0(temp_x, collapse = '+')}")
    print(temp_formula)
    temp_model <- lm(eval(as.formula(temp_formula)), df)
    tolerance[temp_y] <- as.numeric(1 - glance(temp_model)[['r.squared']])
    vif[temp_y] <- as.numeric(1 / tolerance[[temp_y]])
  }

  df_multicollinearity <- cbind(tolerance, vif) %>%
    as.data.frame() %>%
    rownames_to_column("term") %>%
    mutate(tolerance = as.numeric(tolerance),
           vif = as.numeric(vif))

  return(df_multicollinearity)
}
