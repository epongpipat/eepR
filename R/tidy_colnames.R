#' @title tidy_colnames
#' @description makes the data.frame have column names that are in tidy format.
#' @details currently, does the following modifications:
#' 1. lower-case
#' 2. replaces:
#'    - periods with underscores
#'    - space with underscores
#'    - double underscore with one underscore
#'    - parentheses with underscore
#'    - brackets with underscore
#'    - forward and backward slashes with underscore
#'    - dash with underscore
#'    - e_mail with email
#'    - removes trailing white space and trailing underscores
#'
#' @param data data.frame that contains the column names to be converted
#' @importFrom xfun pkg_attach
#' @import dplyr stringr
#' @return data.frame with tidy column names
#' @export
#'
#' @examples
#' # before
#' colnames(carData::Salaries)
#'
#' # after
#' df <- carData::Salaries %>%
#' tidy_colnames(.)
#' colnames(df)
tidy_colnames <- function(data) {
  #require(xfun)
  #packages <- c("dplyr", "stringr")
  #xfun::pkg_attach(packages, install = T, message = F)
  colnames(data) <- colnames(data) %>%
    tolower() %>%
    str_replace_all(., "[.]", "_") %>%
    str_replace_all(., "[ ]", "_") %>%
    str_replace_all(., "\\(", "_") %>%
    str_replace_all(., "\\)", "_") %>%
    str_replace_all(., "\\[", "_") %>%
    str_replace_all(., "\\]", "_") %>%
    str_replace_all(., "/", "_") %>%
    str_replace_all(., "\\\\", "_") %>%
    str_replace_all(., "-", "_") %>%
    str_replace_all(., ",", "_") %>%
    str_replace_all(., "\\?", "_") %>%
    str_replace_all(., "e_mail", "email") %>%
    trimws() %>%
    str_replace_all(., "__", "_") %>%
    str_replace_all(., "_$", "")

  #colnames(data) <- sub("_$", "", colnames(data))

  return(data)
}
