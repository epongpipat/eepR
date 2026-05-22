#' @title rename_colnames
#' @description rename column names
#' @family column name helpers
#' @param data data.frame to be renamed
#' @param new_colnames a vector of new column names
#'
#' @return data.frame with the new column names
#' @export
#'
#' @examples
#' rename_colnames(
#'   data.frame(a = 1:3, b = 4:6),
#'   c("participant_id", "score")
#' )
rename_colnames <- function(data, new_colnames) {
  colnames(data) <- new_colnames
  return(data)
}
