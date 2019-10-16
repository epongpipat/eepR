append_suffix_to_colnames <- function(data, suffix) {
  colnames(data) <- paste0(colnames(data), "_", suffix)
  return(data)
}