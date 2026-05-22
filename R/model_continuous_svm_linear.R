#' @title model_continuous_svm_linear
#' @description model continuous linear support vector machine
#' @concept model_continuous
#' @family continuous model wrappers
#' @param data clean data.frame of predictors and outcome to be analyzed
#' @param y continuous outcome name within the data.frame
#'
#' @return linear svm model
#' @export
#' @importFrom e1071 svm
#' @examples
#' data <- data.frame(y = mtcars$mpg, wt = mtcars$wt, hp = mtcars$hp)
#' model_continuous_svm_linear(data, "y")
model_continuous_svm_linear <- function(data, y) {
 x <- data %>% select(-y) %>% as.matrix()
 y <- data %>% select(y) %>% as.matrix()

 model <- svm(x = x, y = y, kernel = "linear", type = "eps-regression")
 model$w <- t(model$coefs) %*% model$SV
 return(model)
}
