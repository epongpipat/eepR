#' @title initialize_parallel_computing
#' @description initialize parallel computing for different types of parallel computing
#' @param save number of cores to save/exclude from parallel computing (default: 1)
#'
#' @export
#' @import doParallel foreach future
initialize_parallel_computing <- function(save = 1) {
  n_cores <- availableCores()
  n_cores <- makeCluster(n_cores - save)
  registerDoParallel(cores = n_cores)
  plan(multiprocess)

}
