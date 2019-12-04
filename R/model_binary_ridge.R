#' @title model_binary_ridge
#' @description predict binary outcome using ridge regression
#' @param data clean data.frame of all variables to be used
#' @param y name of binary outcome within the data.frame to be predicted
#'
#' @return ridge model results
#' @export
#' @import glmnet dplyr
#' @examples
#' # to be added
model_binary_ridge <- function(data, y) {
  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  cv_ridge <- cv.glmnet(x, y, family = "binomial", alpha = 0)
  glmnet(x, y, family = "binomial", alpha = 0, lambda = cv_ridge$lambda.min)
}
