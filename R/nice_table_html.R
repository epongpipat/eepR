#' nice_table_html
#'
#' @param table
#'
#' @return
#' @export
#' @import kableExtra
#' @examples
nice_table_html <- function(table) {
  nice_table(table) %>%
    scroll_box(width = "100%")
}

