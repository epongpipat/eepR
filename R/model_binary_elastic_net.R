require(xfun)
packages <- c("glmnet", "doParallel", "foreach", "future", "dplyr", "furrr")
xfun::pkg_attach(packages, message = F, install = T)
registerDoParallel(cores = availableCores()-1)
plan(multiprocess)
model_binary_elastic_net <- function(data, y) {

  data <- df_clean
  y <- "female"

  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  a <- seq(0.0001, 0.9999, 0.0001)

  func_cv <- function(a) {
    cv <- cv.glmnet(x, y, family = "binomial", nfold = 10, parallel = TRUE, alpha = a)
    data.frame(cvm = cv$cvm[cv$lambda == cv$lambda.1se], lambda.1se = cv$lambda.1se, alpha = a)
  }

  tic()
  df_model <- tibble(a) %>%
    .[1:100,] %>%
    mutate(cv_model = future_map(a, func_cv))
  toc()

  tic()
  search <- foreach(i = a[1:100], .combine = rbind) %dopar% {
    cv <- cv.glmnet(x, y, family = "binomial", nfold = 10, parallel = TRUE, alpha = i)
    data.frame(cvm = cv$cvm[cv$lambda == cv$lambda.1se], lambda.1se = cv$lambda.1se, alpha = i)
  }
  toc()

  cv_elastic_net <- search[search$cvm == min(search$cvm), ]
  glmnet(x, y, family = "binomial", lambda = cv_elastic_net$lambda.1se, alpha = cv_elastic_net$alpha)
}
