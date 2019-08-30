predict_binary_probability <- function(model, x) {
  # model <- df_pred$model[[2]]
  class <- model %>% attributes %>% .$class
  # str_detect(class, "glm")
  if (any(str_detect(class, "glmnet"))) {
    predict <- predict.glmnet(model, as.matrix(x))
  } else if (any(str_detect(class, "svm"))) {
    predict <- predict(model)
  } else if (any(str_detect(class, "glm"))) {
    predict <- predict.glm(model)
  }

  predict %>% unlist() %>% as.numeric()
}
