calculate_sdt <- function(n_tp, n_tn, n_fp, n_fn) {

  # totals
  n <- n_tp + n_tn + n_fp + n_fn
  n_t <- n_tp + n_tn
  n_f <- n_fp + n_fn

  # calculate rates
  acc <- n_t / n
  tpr <- n_tp / (n_tp + n_fn)
  fpr <- n_fp / (n_fp + n_tn)

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
  df <- tibble(n, n_t, n_f, accuracy = acc, tpr, fpr, tpr_adj, fpr_adj, tpr_z, fpr_z, d_prime, c)
  return(df)

}
