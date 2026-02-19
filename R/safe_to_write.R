#' safe_to_write
#'
#' @param f path to file
#' @param overwrite logical, whether to overwrite if file already exists (default: FALSE)
#'
#' @returns logical, whether it is safe to write to the file
safe_to_write <- function(f, overwrite = FALSE) {
  if (file.exists(f) & !overwrite) {
    warning(sprintf("skipping, file already exists and overwrite is set to FALSE (%s)", f))
    write <- FALSE
  } else if (file.exists(f) & overwrite) {
    warning(sprintf("overwriting, file already exists but overwrite is set to TRUE (%s)", f))
    write <- TRUE
  } else {
    write <- TRUE
  }
  return(write)
}
