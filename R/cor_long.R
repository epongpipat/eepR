#' @title cor_long
#'
#' @param data data to correlate and transform to long format
#'
#' @return
#' @export
#' @import dplyr stringr tibble
#' @examples
#' cor_long(mtcars)
cor_long <- function(data) {

  colnames(data) <- paste0(1:length(colnames(data)), ". ", colnames(data)) %>%
    str_replace_all(., "_", " ") %>%
    str_to_title()

  cor_long <- cor(data) %>%
    as.data.frame() %>%
    rownames_to_column(., "var_1") %>%
    gather(., "var_2", "val", -var_1)

  return(cor_long)

}
