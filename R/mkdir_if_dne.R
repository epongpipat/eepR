#' @title mkdir_if_dne
#' @concept r_helper
#' @description recursively create directories if it does not exist
#' @param dir
#'
#' @return
#' @export
#'
#' @examples
mkdir_if_dne <- function(dir, recursive = TRUE) {
  if(!dir.exists(dir)) {
    dir.create(dir, recursive = recursive)
  }
}
