#' stop_if_e
#' @family path helpers
#'
#' @param file file path to check
#'
#' @return Invisibly returns \code{NULL}; errors if \code{file} exists.
#' @export
#'
#' @examples
#' stop_if_e(file.path(tempdir(), "missing-file.txt"))
stop_if_e <- function(file) {
  if (file.exists(file)) {
    stop(sprintf("file (%s) already exists", file))
  }
}
