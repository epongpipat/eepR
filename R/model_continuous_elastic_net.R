#' @title model_continuous_elastic_net
#' @param data data to be analyzed
#' @param y name/string of outcome to be predicted that is within the data
#' @param alpha_list vector of alpha to cross-validate (default: seq(0.0001, 0.9999, 0.0001))
#' @return elastic net results
#' @export
#' @import glmnet doParallel foreach future dplyr furrr
#' @examples
#' # to be added
model_continuous_elastic_net <- function(data, y, alpha_list = seq(0.0001, 0.9999, 0.0001)) {

  registerDoParallel(cores = availableCores()-1)
  plan(multiprocess)

  x <- data %>% select(-y) %>% as.matrix()
  y <- data %>% select(y) %>% as.matrix()
  a <- alpha_list

  # perform cv.glmnet for each alpha
  # to obtain table of optimal lambda for each alpha
  func_cv <- function(a) {
    cv <- cv.glmnet(x, y, nfold = 10, parallel = TRUE, alpha = a)
    data.frame(cvm = cv$cvm[cv$lambda == cv$lambda.1se], lambda.1se = cv$lambda.1se, alpha = a)
  }

  df_model <- tibble(a) %>%
    mutate(cv_model = future_map(a, func_cv)) %>%
    unnest()

  # obtain the lowest cvm (mean cross-validated error)
  cv_elastic_net <- df_model[df_model$cvm == min(df_model$cvm), ]

  # run final model using the lambda and alpha from the lowest cvm
  model <- glmnet(x, y, lambda = cv_elastic_net$lambda.1se, alpha = cv_elastic_net$alpha)

  # append useful information
  model$alpha <- cv_elastic_net$alpha
  model$cv <- df_model
  return(model)
}
