initialize_parallel_computing <- function(save = 1) {

  require(xfun)
  packages <- c("doParallel", "foreach", "future")
  xfun::pkg_attach(packages, message = F, install = T)
  
  n_cores <- availableCores()
  n_cores <- makeCluster(n_cores - save)
  registerDoParallel(cores = n_cores)
  plan(multiprocess)

}
