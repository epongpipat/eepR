predict_binary_probability <- function(model, x) {

  # determine class (model type)
  class <- model %>% attributes %>% .$class

  # elastic net
  if (any(str_detect(class, "glmnet"))) {
    predict <- predict(model, x, type = "response") %>% as_tibble()

  # svm
  } else if (any(str_detect(class, "svm"))) {
    predict <- predict(model, x, probability = TRUE) %>%
      attributes() %>%
      .$probabilities %>%
      as_tibble()

  # glm
  } else if (any(str_detect(class, "glm"))) {
    predict <- predict.glm(model, x)

  # not supported
  } else {
    stop(paste0("Class (", class, ") is not supported"))
  }

  predict %>% unlist() %>% as.numeric()
}
