#' print_header
#'
#' @return time
#' @export
#'
print_header <- function() {
  start_datetime <- Sys.time()
  cat('\n')
  cat(glue("date:\t\t{start_datetime}"), "\n")
  cat(glue("hostname:\t{system('echo ${HOSTNAME}', intern = TRUE)}"), '\n')
  cat(glue("user:\t\t{system('echo ${USER}', intern = TRUE)}"), '\n\n')
  return(start_datetime)
}

#' print_footer
#'
#' @param start_datetime start time from `print_header()`
#'
#' @return
#' @export
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
#'
#' @param msg error message to print
#'
#' @return
#' @importFrom crayon red
#' @export
error_msg <- function(msg) {
  stop(glue("{red('[ERROR]')}\t{msg}"), '\n')
}

#' warning_msg
#'
#' @param msg warning message to print
#'
#' @return
#' @importFrom crayon yellow
#' @export
warning_msg <- function(msg) {
  warning(glue("{yellow('[WARN]')}\t{msg}"), '\n')
}

#' warning_msg
#'
#' @param msg info message to print
#'
#' @return
#' @export
info_msg <- function(msg) {
  cat(glue("[INFO]\t{msg}"), '\n')
}

