#' @title calculate_sdt
#' @concept stats
#' @description calculate signal detection theory (SDT) metrics such as d' and c
#' @param n_tp number of true positives (or hit)
#' @param n_tn number of true negatives (or correct rejection)
#' @param n_fp number of false positives (or false alarm)
#' @param n_fn number of false negatives (or miss)
#'
#' @return data.frame of signal detection theory metrics along with all the variables created along the way
#' @export
#' @importFrom tibble tibble
#' @examples
#' #example to be written
calculate_sdt <- function(n_tp, n_tn, n_fp, n_fn) {

  # totals
  n <- n_tp + n_tn + n_fp + n_fn
  n_t <- n_tp + n_tn
  n_f <- n_fp + n_fn

  # calculate rates
  acc <- n_t / n
  tpr <- n_tp / (n_tp + n_fn)
  tnr <- n_tn / (n_tn + n_fp)
  fpr <- n_fp / (n_fp + n_tn)
  fnr <-n_fn / (n_fn + n_tp)

  # adjust rates
  if (tpr == 1) {
    tpr_adj <- 1 - 0.5 * 1 / (n_tp + n_fn)
  } else {
    tpr_adj <- tpr
  }

  if (fpr == 0) {
    fpr_adj <- 0.5 * 1/(n_fp + n_tn)
  } else {
    fpr_adj <- fpr
  }

  # p > z
  tpr_z <- qnorm(tpr_adj)
  fpr_z <- qnorm(fpr_adj)

  # d'
  d_prime <- tpr_z - fpr_z

  # c
  c <- (tpr_z + fpr_z) / 2

  # create table
  df <- tibble(n, n_t, n_f, accuracy = acc, tpr, tnr, fpr, fnr, tpr_adj, fpr_adj, tpr_z, fpr_z, d_prime, c)
  return(df)

}
