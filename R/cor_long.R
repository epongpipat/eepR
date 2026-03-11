#' @title cor_long
#' @concept stats
#' @param data data to correlate and transform to long format
#'
#' @return data.frame
#' @export
#' @import dplyr
#' @importFrom stringr str_pad
#' @importFrom stringr str_length
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_to_title
#' @importFrom tibble rownames_to_column
#' @importFrom tidyr gather
#' @examples
#' cor_long(mtcars)
cor_long <- function(data) {

  n_pad <- str_pad(string = 1:length(colnames(data)),
                            width = str_length(length(colnames(data))),
                            side = 'left',
                            pad = 0)
  colnames(data) <- paste0(n_pad, ". ", colnames(data)) %>%
    str_replace_all(., "_", " ") %>%
    str_to_title()

  cor_long <- cor(data) %>%
    as.data.frame() %>%
    rownames_to_column(., "var_1") %>%
    gather(., "var_2", "r", -var_1)

  return(cor_long)

}
