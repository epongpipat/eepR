#' @title check_out_path
#' @description \preformatted{
#' checks to see if output file exists.
#'
#' 1. STOP WITH ERROR if output file exists, overwrite set to FALSE and warn_only set to FALSE
#' 2. WARN if output file exists, overwrite set to FALSE and warn_only set to TRUE
#' 3. WARN if output file exists and overwrite set to TRUE
#' }
#' @concept r_helper
#' @param out_path path to output file
#' @param overwrite booleon to overwrite the output path (default: FALSE)
#' @param warn_only boolean to warn instead of stop if file exists and overwrite set to FALSE (default: FALSE)
#'
#' @return
#' @importFrom glue glue
#' @export
#' @examples
#'
check_out_path <- function(out_path, overwrite = FALSE, warn_only = FALSE) {
  if (file.exists(out_path) & overwrite == FALSE & warn_only == FALSE) {
    stop(glue('output file already exists and overwrite set to FALSE: {out_path}'))
  } else if (file.exists(out_path) & overwrite == FALSE & warn_only == TRUE) {
    warning(glue('output file already exists and overwrite set to FALSE: {out_path}'))
  } else if (file.exists(out_path) & overwrite == TRUE) {
    warning(glue('overwriting, output file already exists and overwrite set to TRUE: {out_path}'))
  }
}
