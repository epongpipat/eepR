#' @title model_continous_elastic_net
#'
#' @param data data to be analyzed
#' @param y name/string of outcome to be predicted that is within the data
#'
#' @return elastic net results
#' @export
#' @import glmnet doParallel foreach future dplyr furrr
#' @examples
#' # to be added
model_continous_elastic_net <- function(data, y) {

  registerDoParallel(cores = availableCores()-1)
  plan(multiprocess)

  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  a <- seq(0.0001, 0.9999, 0.0001)

  func_cv <- function(a) {
    cv <- cv.glmnet(x, y, nfold = 10, parallel = TRUE, alpha = a)
    data.frame(cvm = cv$cvm[cv$lambda == cv$lambda.1se], lambda.1se = cv$lambda.1se, alpha = a)
  }

  df_model <- tibble(a) %>%
    .[1:100,] %>%
    mutate(cv_model = future_map(a, func_cv))

  search <- foreach(i = a[1:100], .combine = rbind) %dopar% {
    cv <- cv.glmnet(x, y, nfold = 10, parallel = TRUE, alpha = i)
    data.frame(cvm = cv$cvm[cv$lambda == cv$lambda.1se], lambda.1se = cv$lambda.1se, alpha = i)
  }

  cv_elastic_net <- search[search$cvm == min(search$cvm), ]
  glmnet(x, y, lambda = cv_elastic_net$lambda.1se, alpha = cv_elastic_net$alpha)
}
