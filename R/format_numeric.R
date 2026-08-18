#' format_numeric
#' @description formats a numeric value into a clean string, using scientific notation (with HTML formatting or plain text) for small/large numbers
#' @concept stats
#' @family model2apa helpers
#' @param x numeric value to format
#' @param digits specify digit to round statistics (default: 3)
#' @param format specify format (default: html) (options: html, plain)
#'
#' @returns Character string with formatted number.
#' @export
#' @importFrom scales scientific
#' @importFrom glue glue
#' @importFrom stringr str_split
format_numeric <- function(x, digits = 3, format = 'html') {
  if (is.na(x)) {
    return(NA_character_)
  }

  if (x == 0) {
    x_str <- sprintf(glue("%.{digits}f"), 0)
  } else if (abs(x) < 10^-digits || abs(x) > 10^digits) {
    x_str <- scientific(x, digits = digits + 1)
    x_str_parts <- unlist(str_split(x_str, 'e'))
    exp_val <- as.numeric(x_str_parts[2])

    if (format == 'html') {
      x_str <- glue("{x_str_parts[1]}×10<sup>{exp_val}</sup>")
    } else {
      x_str <- glue("{x_str_parts[1]}×10^{exp_val}")
    }
  } else {
    x_str <- sprintf(glue("%.{digits}f"), x)
  }
  return(x_str)
}
