#' @title model_continuous_lasso
#'
#' @param data data to be analyzed
#' @param y name/string of outcome to be predicted that is within the data
#'
#' @return lasso results
#' @export
#' @import glmnet dplyr
#' @examples
#' # to be added
model_continuous_lasso <- function(data, y) {
  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  cv_lasso <- cv.glmnet(x, y, alpha = 1)
  glmnet(x, y, alpha = 1, lambda = cv_lasso$lambda.min)
  model$cv <- cv_lasso
  return(model)
}
