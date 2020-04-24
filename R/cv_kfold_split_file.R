#' cv_kfold_split_file
#'
#' @param x_path
#' @param y_path
#' @param k_fold
#' @param out_dir
#'
#' @return
#' @export
#'
#' @examples
cv_kfold_split_file <- function(x_path, y_path, k_fold, out_dir) {

  stop_if_dne(x_path)
  stop_if_dne(y_path)

  n_pad <- 3
  k_fold_pad <- str_pad(k_fold, n_pad, "left", 0)

  x <- read.csv(x_path)
  y <- read.csv(y_path)

  if (dim(x)[1] != dim(y)[1]) {
    stop(glue("number of rows in x {dim(x)[1]} and y {dim(y)[1]} do not match."))
  }

  out_file <- glue("{out_dir}/x.csv")
  mkdir_if_dne(out_file)
  stop_if_e(out_file)
  file.copy(x_path, out_file)

  out_file <- glue("{out_dir}/y.csv")
  mkdir_if_dne(out_file)
  stop_if_e(out_file)
  file.copy(y_path, out_file)

  for (i in 1:k_fold) {
    tryCatch2({
      i_pad <- str_pad(i, n_pad, "left", 0)

      cv_out_dir <- glue("{out_dir}/cv-kfold-{k_fold_pad}-{i_pad}")
      mkdir_if_dne(cv_out_dir)

      n_fold <- ceiling(dim(x)[1]/k_fold)
      cv_idx <- rep(1:k_fold, each = n_fold, length.out = dim(x)[1])

      x_train <- x[cv_idx != i, ]
      x_test <- x[cv_idx == i, ]
      y_train <- y[cv_idx != i, ]
      y_test <- y[cv_idx == i, ]

      out_path <- glue("{cv_out_dir}/x_train.csv")
      stop_if_e(out_path)
      write.csv(x_train, out_path, row.names = F)

      out_path <- glue("{cv_out_dir}/x_test.csv")
      stop_if_e(out_path)
      write.csv(x_train, out_path, row.names = F)

      out_path <- glue("{cv_out_dir}/y_train.csv")
      stop_if_e(out_path)
      write.csv(x_train, out_path, row.names = F)

      out_path <- glue("{cv_out_dir}/y_test.csv")
      stop_if_e(out_path)
      write.csv(x_train, out_path, row.names = F)
    })
  }
}
