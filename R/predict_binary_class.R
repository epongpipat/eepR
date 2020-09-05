predict_binary_class <- function(probability) {
  ifelse(probability > 0.5, 1, 0)
}
