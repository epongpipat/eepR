#' get_3dstats
#' @description obtain summary metrics of data file from discrete segmentation. summary metrics include non-zero voxels, min, max, median, mean
#' @concept neuroimaging
#' @param in_data input path to data nifti file
#' @param in_dseg input path to discrete segmentation nifti file
#' @param in_lut input path to look up table
#' @param out_path output path to save stats tsv file
#' @param overwrite flag to overwrite (default: 0)
#'
#' @return
#' @export
#' @import dplyr
#' @importFrom RNifti readNifti
#' @importFrom RNifti pixdim
get_3dstats <- function(in_data, in_dseg, in_lut = NULL, out_path, overwrite = FALSE) {
  if (safe_to_write(out_path, overwrite)) {

    cat('read data', '\n')
    dseg <- readNifti(in_dseg)
    data <- readNifti(in_data)

    keys <- sort(unique(as.numeric(dseg)))
    keys <- keys[keys != 0]

    # checks
    if (sum(dim(dseg) - dim(data)) != 0) {
      stop(sprintf('dimensions do not match (dim1: %s; dim2: %s)', paste0(dim(dseg), collapse = ','), paste0(dim(data), collapse = ',')))
    }

    if (sum(pixdim(dseg) - pixdim(data)) > 1e-4) {
      stop(sprintf('dimensions do not match (pixdim1: %s; pixdim2: %s)', paste0(pixdim(dseg), collapse = ','), paste0(pixdim(data), collapse = ',')))
    }

    # main
    cat('extract stats', '\n')
    df_stat <- lapply(1:length(keys), function(k) {
      data.frame(index = keys[k],
                 nzvoxel = length(data[dseg == keys[k] & data != 0]),
                 nzmin = min(data[dseg == keys[k] & data != 0]),
                 nzmax = max(data[dseg == keys[k] & data != 0]),
                 nzmean = mean(data[dseg == keys[k] & data != 0]),
                 nzmedian = median(data[dseg == keys[k] & data != 0]),
                 nzsd = sd(data[dseg == keys[k] & data != 0]))
    }) |>
      bind_rows() |>
      arrange(keys)

    if (!is.null(in_lut)) {
      df_lut <- read.delim2(in_lut)
      df <- right_join(df_lut, df_stat)
    } else {
      df <- df_stat
    }

    cat('write stats', '\n')
    write.table(df, out_path, row.names = FALSE, sep = '\t', quote = FALSE)
    return(df)

  }

}

# if (!interactive()) {
#   library(argparse)
#   parser <- argparse::ArgumentParser()
#   parser$add_argument('--in-data', help = 'input path to data nifti file', required = TRUE)
#   parser$add_argument('--in-dseg', help = 'input path to discrete segmentation nifti file', required = TRUE)
#   parser$add_argument('--in-lut', help = 'input path to look up table in BIDS format', required = TRUE)
#   parser$add_argument('-o', '--out-path', help = 'output path to save stats in tsv format', required = TRUE)
#   parser$add_argument('--overwrite', help = 'flag to overwrite', default = 0, choices = c(0, 1))
#   args <- parser$parse_args()
#   get_3dstats(args$in_data, args$in_dseg, args$in_lut, args$out_path, args$overwrite)
# }



