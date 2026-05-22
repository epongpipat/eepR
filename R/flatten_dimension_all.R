#' @title flatten_dimension_all
#' @concept data_wrangle
#' @family dimension flattening helpers
#' @param data multi-dimensional data to completely flattened/reduced to a single dimension
#' @return data that is flattened to a single dimension
#' @export
#' @import dplyr tidyr
#' @importFrom future plan
#' @importFrom furrr future_map
#' @examples
#' x <- array(1:24, dim = c(2, 3, 4))
#' flatten_dimension_all(x)
flatten_dimension_all <- function(data) {

  plan(multiprocess)

  data_dim <- data %>% dim()
  if (is.null(data_dim)) {
    n_dim <- 1
  } else {
    n_dim <- length(data_dim)
  }

  df <- flatten_dimension(data)

  while(n_dim > 1) {
    df <- df %>%
      mutate(data = future_map(data, flatten_dimension)) %>%
      unnest()

    data_dim <- df$data[[1]] %>% dim()
    if (is.null(data_dim)) {
      n_dim <- 1
    } else {
      n_dim <- length(data_dim)
    }

  }

  df <- df %>%
    mutate(data = future_map(data, flatten_dimension)) %>%
    unnest() %>%
    unnest()

  return(df)
}
