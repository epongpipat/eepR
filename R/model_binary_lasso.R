require(xfun)
packages <- c("glmnet", "dplyr")
xfun::pkg_attach(packages, message = F, install = T)

model_binary_lasso <- function(data, y) {
  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  cv_lasso <- cv.glmnet(x, y, family = "binomial", alpha = 1)
  glmnet(x, y, family = "binomial", alpha = 1, lambda = cv_lasso$lambda.min)
}
