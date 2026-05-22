#' @title model_categorical_glm
#' @concept model_categorical
#' @family categorical model wrappers
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#'
#' @return Fitted binomial GLM or multinomial model.
#' @export
#' @importFrom nnet multinom
#' @examples
#' x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
#' y <- iris$Species
#' model_categorical_glm(x, y)
model_categorical_glm <- function(x, y) {
  x <- as.matrix(x)
  y <- as.matrix(y)
  n_y <- length(unique(y))
  if (n_y == 2) {
    glm(y ~ x, family = "binomial")
  } else if (n_y > 2) {
    multinom(y ~ x)
  } else {
    stop("number of factors of y must be greater than 2")
  }
}
