#' @title model_categorical_svm
#' @concept model_categorical
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#' @param kernel
#'
#' @return
#' @export
#' @import e1071 dplyr
#' @examples
model_categorical_svm <- function(y, x, kernel = "linear") {
  x <- as.matrix(x)
  y <- as.factor(y)
  svm(y = y, x = x, kernel = kernel)
}
