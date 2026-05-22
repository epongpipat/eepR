#' @title mkdir_if_dne
#' @concept r_helper
#' @description recursively create directories if it does not exist
#' @family path helpers
#' @param dir directory path to create if missing
#' @param recursive logical, whether to create parent directories
#'
#' @return Invisibly returns \code{NULL}; creates \code{dir} if needed.
#' @export
#'
#' @examples
#' out_dir <- file.path(tempdir(), "eepR-example-dir")
#' mkdir_if_dne(out_dir)
#' dir.exists(out_dir)
mkdir_if_dne <- function(dir, recursive = TRUE) {
  if(!dir.exists(dir)) {
    dir.create(dir, recursive = recursive)
  }
}
