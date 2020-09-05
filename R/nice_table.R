#' nice_table
#'
#' @param table a data.frame/table to pass through kable
#'
#' @return a kable-styled table
#' @export
#' @import kableExtra
#' @examples
nice_table <- function(table) {
  kable(table) %>%
    kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))
}
