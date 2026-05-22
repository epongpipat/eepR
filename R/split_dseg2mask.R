#' split_dseg2mask
#' @concept neuroimaging
#' @family neuroimaging helpers
#' @param in_dseg path to discrete segmentation file
#' @param in_lut path to look up table .tsv file (bids format)
#' @param out_prefix output prefix of the mask files
#' @param overwrite flag to overwrite output files (default: FALSE)
#'
#' @return Invisibly returns \code{NULL}; writes one mask NIfTI per LUT entry.
#' @export
#' @importFrom RNifti readNifti
#' @importFrom RNifti writeNifti
#' @importFrom readr read_tsv
#' @importFrom stringr str_sub
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_length
#' @importFrom stringr str_replace
#' @importFrom glue glue
split_dseg2mask <- function(in_dseg, in_lut, out_prefix, overwrite = FALSE) {

  # checks
  in_paths <- list()
  in_paths$dseg <- in_dseg
  in_paths$lut <- in_lut

  for (key in names(in_paths)) {
    if (!file.exists(in_paths[[key]])) {
      stop(glue("file does not exist ({key}: {in_paths[[key]]})"))
    }
  }

  df_lut <- read_tsv(in_paths[["lut"]])
  data <- readNifti(in_paths[["dseg"]])

  values <- sort(unique(as.numeric(data)))
  values <- values[values != 0]

  files <- lapply(values, function(x) {
    data_temp <- data
    data_temp[data_temp != x] <- 0
    data_temp[data_temp == x] <- 1
    idx <- which(df_lut$index == x)
    label <- df_lut[idx, "name"]
    label <- str_replace_all(label, "_", "-")
    if (str_sub(label, 1, 1) == "x" && !is.na(as.numeric(str_sub(label, 2, 2)))) {
      label <- str_sub(label, 2, str_length(label))
    }
    out_path <- glue("{out_prefix}label-{label}_mask.nii.gz")
    if (save_to_write(out_path, overwrite)) {
      writeNifti(data_temp, out_path)
    }
  })
  return(invisible(NULL))
}
