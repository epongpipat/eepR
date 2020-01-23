#' @title model_categorical_elastic_net
#' @concept model_categorical
#' @param y categorical outcome to predict
#' @param x features/predictors used in prediction of outcome
#'
#' @return elastic net results
#' @export
#' @import glmnet dplyr furrr doParallel foreach tidyr
#' @examples
#' # to be added
model_categorical_elastic_net <- function(y, x, alpha_list = seq(0.0001, 0.9999, 0.0001)) {

  if (n_y == 2) {
    family <- "binomial"
  } else if (n_y > 2) {
    family <- "multinomial"
  } else {
    stop("number of factors of y must be greater than 2")
  }

  registerDoParallel(cores = availableCores()-1)
  plan(multiprocess)

  func_cv <- function(a) {
    cv <- cv.glmnet(x, y, family = family, nfold = 10, parallel = TRUE, alpha = a)
    data.frame(cvm = cv$cvm[cv$lambda == cv$lambda.1se], lambda.1se = cv$lambda.1se, alpha = a)
  }

  cv <- tibble(a = alpha_list) %>%
    mutate(cv_model = future_map(a, func_cv)) %>%
    unnest(cv_model) %>%
    select(-a) %>%
    .[cv$cvm == min(cv$cvm),]

  model <- glmnet(x, y, family = family, lambda = cv$lambda.1se, alpha = cv$alpha)
  model$alpha <- cv$alpha
  return(model)

}
