predict_binary_probability <- function(model, x) {

  # determine class (model type)
  class <- model %>% attributes %>% .$class

  # elastic net
  if (any(str_detect(class, "glmnet"))) {
    predict <- predict(df_model$model_lasso[[1]], df_model$data_x[[1]], type = "response") %>% as_tibble()

  # svm
  } else if (any(str_detect(class, "svm"))) {
    predict <- predict(df_model$model_svm_linear[[1]], df_model$data[[1]], probability = TRUE) %>%
      attributes() %>%
      .$probabilities %>%
      as_tibble()

  # glm
  } else if (any(str_detect(class, "glm"))) {
    predict <- predict.glm(model)

  # not supported
  } else {
    stop(paste0("Class (", class, ") is not supported"))
  }

  predict %>% unlist() %>% as.numeric()
}
