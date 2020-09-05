#' @title model_categorical_glm
#' @concept model_categorical
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#'
#' @return
#' @export
#' @import dplyr nnet
#' @examples
model_categorical_glm <- function(x, y) {
  x <- as.matrix(x)
  y <- as.matrix(y)
  n_y <- unique(y) %>% length()
  if (n_y == 2) {
    glm(y ~ x, family = "binomial")
  } else if (n_y > 2) {
    multinom(y ~ x)
  } else {
    stop("number of factors of y must be greater than 2")
  }
}

