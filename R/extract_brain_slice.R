#' extract_brain_slice
#' @concept neuroimaging
#' @param data 3D brain data
#' @param dir direction to extract slice (choices: i, j, or k)
#' @param slice integer from 1 to slice max
#'
#' @return data.frame of the slice in long format (columns: x, y, value)
#' @export
#' @import dplyr
#' @import tidyr
#' @import stringr
#'
extract_brain_slice <- function(data, dir, slice) {
  # checks
  if (is.null(data)) {
    stop("data is null")
  }

  if (length(dim(data)) != 3) {
    stop(sprintf("invalid dim (%s). must be 3 dimensions", dim(data)))
  }

  dirs <- c('i', 'j', 'k')
  if (!dir %in% dirs) {
    stop(sprintf('invalid dir (%s). dir must be either: i, j, or k', dir))
  }

  slice_max <- dim(data)[which(dirs == dir)]
  if (!slice %in% 1:slice_max) {
    stop(sprintf("invalid slice. must be an integer from 1 to %s", slice_max))
  }

  # main
  if (dir == 'i') {
    df <- data[slice,,] |>
      as.data.frame()
  } else if (dir == 'j') {
    df <- data[,slice,] |>
      as.data.frame()
  } else if (dir == 'k') {
    df <- data[,,slice] |>
      as.data.frame()
  }
  df <- df |>
    mutate(x = row_number()) |>
    pivot_longer(cols = -x, names_to = 'y') |>
    mutate(y = as.integer(str_remove(y, 'V')))
  attr(df, 'extra_info') <- list(dir = dir,
                                 slice = slice,
                                 min = min(as.numeric(data)),
                                 max = max(as.numeric(data)))
  return(df)
}
