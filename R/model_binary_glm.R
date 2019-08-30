model_binary_glm <- function(data, y) {
  glm(eval(as.formula(paste(y, "~ ."))), data, family = "binomial")
}

