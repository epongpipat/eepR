
#' @title append_colnames
#' @concept data_wrangle
#' @description add a string to beginning and/or ending of all the column names
#' @param data data.frame that contains the column names to change with a prefix
#' @param prefix string to add to the beginning of all of the column names of the data.frame
#' @param suffix string to add to the end of all of the column names of the data.frame
#' @return data.frame with new column names with prefix string appended to the column names
#' @export
#' @importFrom lifecycle deprecate_warn
#'
#' @examples
#' df <- append_colnames(carData::Salaries, prefix = 'p_', suffix = '_s')
#' head(df)
append_colnames <- function(data, prefix = NULL, suffix = NULL) {
  colnames(data) <- paste0(prefix, colnames(data), suffix)
  return(data)
}


#' @title append_prefix_to_colnames
#' @concept data_wrangle
#' @description add a string to beginning of all the column names
#' @param data data.frame that contains the column names to change with a prefix
#' @param prefix string to add to the beginning of all of the column names of the data.frame
#'
#' @return data.frame with new column names with prefix string appended to the column names
#' @export
#' @importFrom lifecycle deprecate_warn
#'
#' @examples
#' df <- append_prefix_to_colnames(carData::Salaries, 'p_')
#' head(df)
append_prefix_to_colnames <- function(data, prefix) {
  lifecycle::deprecate_warn("0.5.0", "append_suffix_to_colnames()", "append_colnames(prefix)")
  return(append_colnames(data = data, prefix = prefix))
}

#' @title append_suffix_to_colnames
#' @concept data_wrangle
#' @description add a string to end of all the column names
#' @param data data.frame that contains the column names to change with a suffix
#' @param suffix string to add to the end of all of the column names of the data.frame
#'
#' @return data.frame with new column names with suffix string appended to the column names
#' @export
#' @importFrom lifecycle deprecate_warn
#' @examples
#' df <- append_suffix_to_colnames(carData::Salaries, '_s')
#' head(df)
append_suffix_to_colnames <- function(data, suffix) {
  lifecycle::deprecate_warn("0.5.0", "append_suffix_to_colnames()", "append_colnames(suffix)")
  return(append_colnames(data = data, suffix = suffix))
}
