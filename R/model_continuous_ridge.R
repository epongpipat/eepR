#' @title model_continuous_ridge
#' @concept model_continuous
#' @family continuous model wrappers
#' @param data data to be analyzed
#' @param y name/string of outcome to be predicted that is within the data
#'
#' @return ridge results
#' @export
#' @import dplyr
#' @importFrom glmnet cv.glmnet
#' @importFrom glmnet glmnet
#' @examples
#' data <- data.frame(y = mtcars$mpg, wt = mtcars$wt, hp = mtcars$hp)
#' model_continuous_ridge(data, "y")
model_continuous_ridge <- function(data, y) {
  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  cv_ridge <- cv.glmnet(x, y, alpha = 0)
  model <- glmnet(x, y, alpha = 0, lambda = cv_ridge$lambda.min)
  model$cv <- cv_ridge
  return(model)
}
