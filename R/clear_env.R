clear_env <- function(ask = F) {
  if (ask == T) {
    ask_var <- readline(prompt="Clear console? [T/F] ")
    if (as.logical(ask_var) == F) {
      stop("environment was not cleared")
    }
  }

  rm(list = ls(envir = .GlobalEnv), envir = .GlobalEnv)
}
