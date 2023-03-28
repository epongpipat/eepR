
#' check_in_paths
#' @concept r_helper
#' @param paths paths to check
#'
#' @return
#' @export
#' @importFrom glue glue
#' @examples
check_in_paths <- function(paths) {
  if (length(paths) == 0) {
    stop('no input paths found')
  }
  for (i in 1:length(paths)) {
    if (!file.exists(paths[[i]])) {
      stop(glue("path does not exist ({paths[[i]]})"))
    }
  }
}

#' check_out_paths
#' @concept r_helper
#' @param paths paths to check
#' @param overwrite boolean
#'
#' @return
#' @export
#' @importFrom glue glue
#' @examples
check_out_paths <- function(paths, overwrite = 0) {
  if (length(paths) == 0) {
    stop('no output paths found')
  }
  for (i in 1:length(paths)) {
    if (file.exists(paths[[i]]) & overwrite == 0) {
      stop(glue("path already exists and overwrite set to 0 ({paths[[i]]})"))
    } else if (file.exists(paths[[i]]) & overwrite == 1) {
      warning(glue("overwriting, paths already exists and overwrite set to 1 ({paths[[i]]})"))
    }
  }
}
