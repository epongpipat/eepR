#' nice_table_html_short
#'
#' @param table
#' @param height
#'
#' @return
#' @export
#' @import kableExtra
#' @examples
nice_table_html_short <- function(table, height = "200px") {
  nice_table(table) %>%
    scroll_box(height = height, width = "100%")
}
