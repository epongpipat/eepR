#' @title model_continuous_lasso
#' @concept model_continuous
#' @family continuous model wrappers
#' @param data data to be analyzed
#' @param y name/string of outcome to be predicted that is within the data
#'
#' @return lasso results
#' @export
#' @import dplyr
#' @importFrom glmnet cv.glmnet
#' @importFrom glmnet glmnet
#' @examples
#' data <- data.frame(y = mtcars$mpg, wt = mtcars$wt, hp = mtcars$hp)
#' model_continuous_lasso(data, "y")
model_continuous_lasso <- function(data, y) {
  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  cv_lasso <- cv.glmnet(x, y, alpha = 1)
  model <- glmnet(x, y, alpha = 1, lambda = cv_lasso$lambda.min)
  model$cv <- cv_lasso
  return(model)
}
