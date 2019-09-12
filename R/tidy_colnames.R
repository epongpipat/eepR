# currently, does the following modifications:
# 1. lower-case
# 2. replaces:
#    - periods with underscores
#    - space with underscores
#    - double underscore with one underscore
#    - parentheses with underscore
#    - brackets with underscore
#    - forward and backward slashes with underscore
#    - dash with underscore
#    - e_mail with email
#    - removes trailing white space and trailing underscores
tidy_colnames <- function(data) {
  require(xfun)
  packages <- c("dplyr", "stringr")
  xfun::pkg_attach(packages, install = T, message = F)
  colnames(data) <- colnames(data) %>%
    tolower() %>%
    str_replace_all(., "[.]", "_") %>%
    str_replace_all(., "[ ]", "_") %>%
    str_replace_all(., "\\(", "_") %>%
    str_replace_all(., "\\)", "_") %>%
    str_replace_all(., "\\[", "_") %>%
    str_replace_all(., "\\]", "_") %>%
    str_replace_all(., "/", "_") %>%
    str_replace_all(., "\\\\", "_") %>%
    str_replace_all(., "_$", "") %>%
    str_replace_all(., "-", "_") %>%
    str_replace_all(., "e_mail", "email") %>%
    str_replace_all(., "__", "_") %>%
    trimws()

  #colnames(data) <- sub("_$", "", colnames(data))

  return(data)
}
