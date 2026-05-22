#' @title model_categorical_ridge
#' @concept model_categorical
#' @family categorical model wrappers
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#'
#' @return Fitted ridge regression model from \code{glmnet}.
#' @export
#' @importFrom glmnet glmnet
#' @importFrom glmnet cv.glmnet
#' @examples
#' x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
#' y <- iris$Species
#' model_categorical_ridge(x, y)
model_categorical_ridge <- function(x, y) {
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

  cv <- cv.glmnet(x, y, family = family, alpha = 0)
  model <- glmnet(x, y, family = family, alpha = 0, lambda = cv$lambda.min)

  return(model)
}
