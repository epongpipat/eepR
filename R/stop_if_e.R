#' stop_if_e
#'
#' @param file
#'
#' @return
#' @export
#'
#' @examples
stop_if_e <- function(file) {
  if (file.exists(file)) {
    stop(sprintf("file (%s) already exists", file))
  }
}
