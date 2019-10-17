#' @title flatten_dimension
#'
#' @param data multi-dimensional data to be flattened/reduced by a single dimension
#'
#' @return data that is flattened/reduced by a single dimension
#' @export
#' @import dplyr
#' @examples
#' # to be added
flatten_dimension <- function(data) {

  starting_letter <- 9 # start lettering at i rather than a

  data_dim <- data %>% dim()

  if (is.null(data_dim)) {
    n_dim <- 1
    n_last_dim <- data %>% length()
  } else {
    n_dim <- length(data_dim)
    n_last_dim <- dim(data)[n_dim]
  }

  last_dim_letter <- letters[starting_letter + n_dim - 1]
  df <- tibble(!!last_dim_letter := 1:n_last_dim,
                 data = NA)

  for (i in 1:n_last_dim) {
    cmd <- paste0("data[", paste0(rep(",", n_dim - 1), collapse = ""), i,"]")
    temp_data <- eval(parse(text = cmd))
    df$data[i] <- list(temp_data)
  }

  return(df)

}
