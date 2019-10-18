#' @title model_continuous_ridge
#'
#' @param data data to be analyzed
#' @param y name/string of outcome to be predicted that is within the data
#'
#' @return ridge results
#' @export
#' @import glmnet dplyr
#' @examples
#' # to be added
model_continuous_ridge <- function(data, y) {
  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  cv_ridge <- cv.glmnet(x, y, alpha = 0)
  model <- glmnet(x, y, alpha = 0, lambda = cv_ridge$lambda.min)
  model$cv <- cv_ridge
  return(model)
}
