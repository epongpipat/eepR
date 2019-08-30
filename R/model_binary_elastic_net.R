require(xfun)
packages <- c("glmnet", "doParallel", "foreach", "future", "dplyr")
xfun::pkg_attach(packages, message = F, install = T)
registerDoParallel(cores = availableCores()-1)
model_binary_elastic_net <- function(data, y) {
  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  a <- seq(0.0001, 0.9999, 0.0001)
  search <- foreach(i = a, .combine = rbind) %dopar% {
    cv <- cv.glmnet(x, y, family = "binomial", nfold = 10, parallel = TRUE, alpha = i)
    data.frame(cvm = cv$cvm[cv$lambda == cv$lambda.1se], lambda.1se = cv$lambda.1se, alpha = i)
  }
  cv_elastic_net <- search[search$cvm == min(search$cvm), ]
  glmnet(x, y, family = "binomial", lambda = cv_elastic_net$lambda.1se, alpha = cv_elastic_net$alpha)
}
