#' @title rename_colnames
#' @description rename column names
#' @param data data.frame to be renamed
#' @param new_colnames a vector of new column names
#'
#' @return data.frame with the new column names
#' @export
#'
#' @examples
#' # example to be added
rename_colnames <- function(data, new_colnames) {
  colnames(data) <- new_colnames
  return(data)
}
