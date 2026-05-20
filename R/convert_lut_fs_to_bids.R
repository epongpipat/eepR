#' convet_lut_fs2bids
#' @concept neuroimaging
#' @description converts look up table (LUT) from freesurfer-format (No., Label Name, R, G, B, A) to BIDS-format (index, name, color [hex], alpha)
#' @param lut input path to look up table in freesurfer format
#' @param out_path output path to look up table in BIDS format (default: NULL)
#' @param overwrite flag to overwrite (default: 0)
#'
#' @return
#' @import dplyr
#' @importFrom stringr str_to_lower
#' @export
convet_lut_fs2bids <- function(lut, out_path = NULL, overwrite = FALSE) {

  # checks
  if (!is.data.frame(lut) | !(is.character(lut) & file.exists(lut))) {
    stop('lut must be a data.frame or a path to a look-up table in freesurfer format')
  }

  if (is.character(lut)) {
    df <- read.table(in_path)
  }

  df <- df |>
    mutate(color = str_to_lower(rgb(V3, V4, V5, maxColorValue = 255))) |>
    rename(index = V1,
           name = V2) |>
    mutate(alpha = 1) |>
    select(index, name, color, alpha)
  df[1, 'alpha'] <- 0
  if (safe_to_write(out_path, overwrite)) {
    write.table(df, file = out_path, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
    return(invisible(df))
  }
}


# if (!interactive()) {
#   library(argparse)
#   parser <- argparse::ArgumentParser()
#   parser$add_argument('-i', '--in-path', help = 'input path to look up table in freesurfer format', required = TRUE)
#   parser$add_argument('-o', '--out-path', help = 'output path to look up table in BIDS format', required = TRUE)
#   parser$add_argument('--overwrite', help = 'flag to overwrite', default = 0, choices = c(0, 1))
#   args <- parser$parse_args()
#   convet_lut_fs2bids(in_path = args$in_path, out_path = args$out_path, overwrite = args$overwrite)
# }
