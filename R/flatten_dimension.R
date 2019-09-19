flatten_dimension <- function(data) {
  packages <- c("dplyr")
  xfun::pkg_attach(packages, install = T, message = F)
  
  starting_letter <- 9
  #data <- data_long$data[[1]]
  
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
