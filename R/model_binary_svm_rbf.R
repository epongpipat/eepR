require(xfun)
packages <- c("e1071", "dplyr")
xfun::pkg_attach(packages, message = F, install = T)

model_binary_svm_rbf <- function(data, y, kernel = "radial") {
  svm(eval(as.formula(paste(y, "~ ."))), data, kernel = kernel)
}
