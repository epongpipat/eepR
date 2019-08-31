# currently, does the following modifications:
# 1. lower-case
# 2. replaces:
#    - periods with underscores
tidy_colnames <- function(data) {
  require(xfun)
  packages <- c("dplyr", "stringr")
  xfun::pkg_attach(packages, install = T, message = F)
  colnames(data) <- colnames(data) %>%
    tolower() %>%                           
    str_replace_all(., "[.]", "_")          
  return(data)
}
