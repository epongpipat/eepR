#' print_header
#' @family console messaging helpers
#'
#' @return time
#' @export
#'
#' @examples
#' start_time <- print_header()
print_header <- function() {
  start_datetime <- Sys.time()
  cat('\n')
  cat(glue("date:\t\t{start_datetime}"), "\n")
  cat(glue("hostname:\t{system('echo ${HOSTNAME}', intern = TRUE)}"), '\n')
  cat(glue("user:\t\t{system('echo ${USER}', intern = TRUE)}"), '\n\n')
  return(start_datetime)
}

#' print_footer
#' @family console messaging helpers
#'
#' @param start_datetime start time from `print_header()`
#'
#' @return Invisibly returns \code{NULL}; prints elapsed time.
#' @export
#'
#' @examples
#' start_time <- Sys.time()
#' print_footer(start_time)
print_footer <- function(start_datetime) {
  end_datetime <- Sys.time()
  cat("\n")
  cat(glue("date:\t\t{Sys.time()}"), '\n')
  cat(glue("hostname:\t{system('echo ${HOSTNAME}', intern = TRUE)}"), '\n')
  cat(glue("user:\t\t{system('echo ${USER}', intern = TRUE)}"), '\n')
  duration <- end_datetime - start_datetime
  duration <- as.numeric(duration, units = "secs")
  days <- floor(duration / 86400)
  duration <- duration %% 86400
  hours <- floor(duration / 3600)
  duration <- duration %% 3600
  minutes <- floor(duration / 60)
  seconds <- duration %% 60
  cat(glue("duration:\t{sprintf('%02d:%02d:%02d:%02.3f', days, hours, minutes, seconds)}"), '\n\n')
}

#' error_msg
#' @family console messaging helpers
#'
#' @param msg error message to print
#'
#' @return Invisibly returns \code{NULL}; prints a formatted error message.
#' @importFrom crayon red
#' @export
#'
#' @examples
#' try(error_msg("example error"))
error_msg <- function(msg) {
  stop(glue("{.console_msg_datetime()} {red('[ERROR]')}\t{msg}"), '\n')
}

#' warning_msg
#' @family console messaging helpers
#'
#' @param msg warning message to print
#'
#' @return Invisibly returns \code{NULL}; prints a formatted warning message.
#' @importFrom crayon yellow
#' @export
#'
#' @examples
#' warning_msg("example warning")
warning_msg <- function(msg) {
  warning(glue("{.console_msg_datetime()} {yellow('[WARN]')}\t{msg}"), '\n')
}

#' info_msg
#' @family console messaging helpers
#'
#' @param msg info message to print
#'
#' @return Invisibly returns \code{NULL}; prints a formatted info message.
#' @export
#'
#' @examples
#' info_msg("example info")
info_msg <- function(msg) {
  cat(glue("{.console_msg_datetime()} [INFO]\t{msg}"), '\n')
}

.console_msg_datetime <- function() {
  glue("[{format(Sys.time(), '%Y-%m-%d %H:%M:%S')}]")
}
