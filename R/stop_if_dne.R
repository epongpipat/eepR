#' stop_if_dne
#'
#' @param file
#'
#' @return
#' @export
#'
#' @examples
stop_if_dne <- function(file) {
  if (!file.exists(file)) {
    stop(sprintf("file (%s) does not exist", file))
  }
}
