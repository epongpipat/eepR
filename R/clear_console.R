clear_console <- function(ask = F) {
  if (ask == T) {
    ask_var <- readline(prompt="Clear console? [T/F] ")
    if (as.logical(ask_var) == F) {
      stop("console was not cleared")
    }
  }

  cat("\014")
}
