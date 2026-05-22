#' apa_table
#' @description covert a data table to APA format
#' @details black border on the top and bottom of the columns, black border on the bottom of the table, and font is Times size 12
#' @concept stats
#' @param table input data table
#'
#' @return gt object
#' @import gt
#' @export
#' @examples apa_table(renamed_tidy(lm(mpg ~ wt, data = mtcars)))
apa_table <- function(table) {
  df <- gt(table) %>%
    tab_style(style = list(cell_text(font = 'Times', size = 12, align = 'center'),
                           cell_borders(sides = c("top", 'bottom'), color = "#000000", style = "solid", weight = px(2))),
              locations = cells_column_labels()) %>%
    tab_style(style = list(cell_text(font = 'Times', size = 12, align = 'center'),
                           cell_borders(sides = 'all', color = "white", style = "solid", weight = px(0))),
              locations = cells_body()) %>%
    tab_style(style = list(cell_text(font = 'Times', size = 12, align = 'center'),
                           cell_borders(sides = 'bottom', color = "#000000", style = "solid", weight = px(2))),
              locations = cells_body(rows = nrow(table)))
  return(df)
}
