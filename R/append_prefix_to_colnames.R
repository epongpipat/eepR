#' @title append_prefix_to_colnames
#' @description add a string to beginning of all the column names
#' @param data data.frame that contains the column names to change with a prefix
#' @param prefix string to add to the beginning of all of the column names of the data.frame
#'
#' @return data.frame with new column names with prefix string appended to the column names
#' @export
#'
#' @examples
#' # to be added
append_prefix_to_colnames <- function(data, prefix) {
  colnames(data) <- paste0(prefix, colnames(data))
  return(data)
}
