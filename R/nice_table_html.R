#' @title nice_table_html
#'
#' @param table
#'
#' @return
#' @export
#' @importFrom kableExtra scroll_box
#' @examples
nice_table_html <- function(table) {
  nice_table(table) %>%
    scroll_box(width = "100%")
}

