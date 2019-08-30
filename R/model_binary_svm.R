require(xfun)
packages <- c("e1071", "dplyr")
xfun::pkg_attach(packages, message = F, install = T)

model_binary_svm <- function(data, y, kernel = "linear") {
  svm(eval(as.formula(paste(y, "~ ."))), data)
}
