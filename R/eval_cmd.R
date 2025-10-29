#' eval_cmd
#' @concept r_helper
#' @param cmd string expression to evaluate
#' @param out_paths vector or list of output paths
#' @param overwrite flag to overwrite output paths (default: FALSE)
#' @param print flag to print command only (default: FALSE)
#'
#' @return
#' @export
#' 
#' @examples
eval_cmd <- function(cmd, out_paths, overwrite = FALSE, print = FALSE) {
  out_paths <- unlist(out_paths)
  cat(paste0('\n[CMD]\t', cmd))
  if (print) {
    cat(paste0('\n[WARN]\tprinting command only'))
    return(invisible())
  } else if (sum(file.exists(out_paths)) & overwrite) {
    cat(paste0('\n[WARN]\toverwriting, file already exists and overwrite set to TRUE'))
    for (i in 1:length(out_paths)) {
      i0 <- sprintf("%02d", i)
      if (file.exists(out_paths[i])) {
        cat(paste0('\n\t\t', i0, ': ', out_paths[i]))
      } else {
        cat(paste0('\n\t\t', i0, ': ', out_paths[i], ' [missing]'))
      }
    }
    file.remove(out_paths)
  } else if (sum(file.exists(out_paths)) & !overwrite) {
    cat(paste0('\n[WARN]\tskipping, file already exists and overwrite set to FALSE'))
    for (i in 1:length(out_paths)) {
      i0 <- sprintf("%02d", i)
      if (file.exists(out_paths[i])) {
        cat(paste0('\n\t\t', i0, ': ', out_paths[i]))
      } else {
        cat(paste0('\n\t\t', i0, ': ', out_paths[i], ' [missing]'))
      }
    }
    return(invisible())
  }
  eval(parse(text = cmd), envir = .GlobalEnv)
  if (sum(file.exists(out_paths) != 1)) {
    cat(paste0('\n[ERROR]\tmissing output file(s)'))
    for (i in 1:length(out_paths)) {
      i0 <- sprintf("%02d", i)
      if (file.exists(out_paths[i])) {
        cat(paste0('\n\t\t', i0, ': ', out_paths[i]))
      } else {
        cat(paste0('\n\t\t', i0, ': ', out_paths[i], ' [missing]'))
      }
    }
  }
  return(invisible())
}
