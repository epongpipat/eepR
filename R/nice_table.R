#' nice_table
#'
#' @param table
#'
#' @return
#' @export
#'
#' @examples
nice_table <- function(table) {
  kable(table) %>%
    kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))
}
