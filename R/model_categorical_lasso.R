#' @title model_categorical_lasso
#' @concept model_categorical
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#'
#' @return lasso results
#' @export
#' @import glmnet dplyr
#' @examples
#' # to be added
model_categorical_lasso <- function(x, y) {
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
  cv <- cv.glmnet(x, y, family = family, alpha = 1)
  model <- glmnet(x, y, family = family, alpha = 1, lambda = cv$lambda.min)
  return(model)
}
