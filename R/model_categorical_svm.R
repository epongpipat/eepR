#' @title model_categorical_svm
#' @concept model_categorical
#' @family categorical model wrappers
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#' @param kernel SVM kernel passed to \code{e1071::svm()}
#'
#' @return Fitted SVM model from \code{e1071::svm()}.
#' @export
#' @importFrom e1071 svm
#' @examples
#' x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
#' y <- iris$Species
#' model_categorical_svm(x, y)
model_categorical_svm <- function(x, y, kernel = "linear", ...) {
  x <- as.matrix(x)
  y <- as.factor(y)
  svm(y = y, x = x, kernel = kernel, ...)
}
