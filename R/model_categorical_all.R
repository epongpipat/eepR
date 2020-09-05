#' @title model_categorical_all
#' @concept model_uber
#' @param x features used in prediction
#' @param y outcome to predict
#'
#' @return
#' @export
#' @import tibble
#' @examples
model_categorical_all <- function(x, y) {
  tribble(~model_name, ~model,
          "glm", model_categorical_glm(x, y),
          "ridge", model_categorical_ridge(x, y),
          "lasso", model_categorical_lasso(x, y),
          "elastic_net", model_categorical_elastic_net(x, y),
          "svm", model_categorical_svm(x, y))
}
