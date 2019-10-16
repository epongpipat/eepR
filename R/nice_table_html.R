#' nice_table_html
#'
#' @param table
#'
#' @return
#' @export
#'
#' @examples
nice_table_html <- function(table) {
  nice_table(table) %>%
    scroll_box(width = "100%")
}

