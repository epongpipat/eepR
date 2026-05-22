#' @title model_categorical_lasso
#' @concept model_categorical
#' @family categorical model wrappers
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#'
#' @return lasso results
#' @export
#' @import glmnet dplyr
#' @importFrom glmnet cv.glmnet
#' @importFrom glmnet glmnet
#' @examples
#' x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
#' y <- iris$Species
#' model_categorical_lasso(x, y)
model_categorical_lasso <- function(x, y) {
  x <- as.matrix(x)
  y <- as.matrix(y)
  n_y <- length(unique(y))
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
