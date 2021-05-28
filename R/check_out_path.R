#' @title check_out_path
#' @description \preformatted{
#' checks to see if output file exists.
#'
#' 1. STOP WITH ERROR if output file exists, overwrite set to FALSE and skip to FALSE
#' 2. WARN AND SKIP to next in the for/while loop if output file exists, overwrite set to FALSE, and skip set to TRUE
#' 3. WARN if output file exists and overwrite set to TRUE
#' }
#' @concept r_helper
#' @param out_path path to output file
#' @param overwrite booleon to overwrite the output path (default: FALSE)
#' @param skip boolean to skip if used in a for/while loop (default: FALSE)
#'
#' @return
#' @importFrom glue glue
#' @export
#' @examples
#'
check_out_path <- function(out_path, overwrite = FALSE, skip = FALSE) {
  if (file.exists(out_path) & overwrite == FALSE & skip == FALSE) {
    stop(glue('output file already exists and overwrite set to FALSE: {out_path}'))
  } else if (file.exists(out_path) & overwrite == FALSE & skip == TRUE) {
    warning(glue('skipping, output file already exists and overwrite set to FALSE: {out_path}'))
    next()
  } else if (file.exists(out_path) & overwrite == TRUE) {
    warning(glue('overwriting, output file already exists and overwrite set to TRUE: {out_path}'))
  }
}
