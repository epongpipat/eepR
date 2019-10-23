#' @title append_suffix_to_colnames
#' @description add a string to end of all the column names
#' @param data data.frame that contains the column names to change with a suffix
#' @param suffix string to add to the end of all of the column names of the data.frame
#'
#' @return data.frame with new column names with suffix string appended to the column names
#' @export
#'
#' @examples
#' # to be added
append_suffix_to_colnames <- function(data, suffix) {
  colnames(data) <- paste0(colnames(data), suffix)
  return(data)
}
