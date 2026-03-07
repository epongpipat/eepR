#' @title model_continuous_svm_linear
#' @description model continuous linear support vector machine
#' @concept model_continuous
#' @param data clean data.frame of predictors and outcome to be analyzed
#' @param y continuous outcome name within the data.frame
#'
#' @return linear svm model
#' @export
#' @importFrom e1071 svm
#' @examples
#' # to be added
model_continuous_svm_linear <- function(data, y) {
 x <- data %>% select(-y) %>% as.matrix()
 y <- data %>% select(y) %>% as.matrix()

 model <- svm(x = x, y = y, kernel = "linear", type = "eps-regression")
 model$w <- t(model$coefs) %*% model$SV
 return(model)
}
