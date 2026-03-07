#' @title model_categorical_svm
#' @concept model_categorical
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#' @param kernel
#'
#' @return
#' @export
#' @importFrom e1071 svm
#' @examples
model_categorical_svm <- function(x, y, kernel = "linear", ...) {
  x <- as.matrix(x)
  y <- as.factor(y)
  svm(y = y, x = x, kernel = kernel, ...)
}
