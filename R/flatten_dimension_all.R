flatten_dimension_all <- function(data) {
  
  packages <- c("dplyr", "tidyr", "purrr", "furrr")
  xfun::pkg_attach()
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
