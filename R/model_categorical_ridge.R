#' @title model_categorical_ridge
#' @concept model_categorical
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#'
#' @return
#' @export
#' @import glmnet dplyr
#' @examples
model_categorical_ridge <- function(y, x) {
  x <- as.matrix(x)
  y <- as.matrix(y)
  n_y <- unique(y) %>% length()

  if (n_y == 2) {
    family <- "binomial"
  } else if (n_y > 2) {
    family <- "multinomial"
  } else {
    stop("number of factors of y must be greater than 2")
  }

  cv <- cv.glmnet(x, y, family = family, alpha = 0)
  model <- glmnet(x, y, family = family, alpha = 0, lambda = cv$lambda.min)

  return(model)
}
