#' mkdir_if_dne
#'
#' @param dir
#'
#' @return
#' @export
#'
#' @examples
mkdir_if_dne <- function(dir) {
  if(!dir.exists(dir)) {
    dir.create(dir, recursive = T)
  }
}
