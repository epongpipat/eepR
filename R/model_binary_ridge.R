require(xfun)
packages <- c("glmnet", "dplyr")
xfun::pkg_attach(packages, message = F, install = T)

model_binary_ridge <- function(data, y) {
  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  cv_ridge <- cv.glmnet(x, y, family = "binomial", alpha = 0)
  glmnet(x, y, family = "binomial", alpha = 0, lambda = cv_ridge$lambda.min)
}
