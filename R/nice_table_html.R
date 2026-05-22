#' @title nice_table_html
#' @family table helpers
#'
#' @param table a data.frame/table to pass through kable
#'
#' @return a scrollable HTML table
#' @export
#' @importFrom kableExtra scroll_box
#' @examples
#' nice_table_html(head(mtcars))
nice_table_html <- function(table) {
  nice_table(table) %>%
    scroll_box(width = "100%")
}
