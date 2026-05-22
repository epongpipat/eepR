#' stop_if_dne
#' @family path helpers
#'
#' @param file file path to check
#'
#' @return Invisibly returns \code{NULL}; errors if \code{file} does not exist.
#' @export
#'
#' @examples
#' stop_if_dne(tempdir())
stop_if_dne <- function(file) {
  if (!file.exists(file)) {
    stop(sprintf("file (%s) does not exist", file))
  }
}
