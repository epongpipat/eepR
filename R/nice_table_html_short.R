#' @title nice_table_html_short
#' @family table helpers
#'
#' @param table a data.frame/table to pass through kable
#' @param height height of the scroll box
#'
#' @return a short scrollable HTML table
#' @export
#' @importFrom kableExtra scroll_box
#' @examples
#' nice_table_html_short(mtcars, height = "150px")
nice_table_html_short <- function(table, height = "200px") {
  nice_table(table) %>%
    scroll_box(height = height, width = "100%")
}
