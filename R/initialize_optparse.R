#' @title initialize_optparse
#' @concept r_helper
#'
#' @param func_name name of function [type: string]
#' @param func_path path to function (optional)
#' @param out_path path to write optparsed file (optional)
#'
#' @return
#' @export
#' @importFrom glue glue
#' @examples initialize_optparse("pmid2doi")
initialize_optparse <- function(func_name, func_path = NULL, out_path = NULL) {

  # write optparse section
  opts <- formals(func_name)
  out <- glue('#!{system("which Rscript", intern = T)} --vanilla')
  out <- glue("{out}\n\nsuppressMessages(require(optparse))")
  out <- glue('{out}\noption_list <- list(')
  for (i in 1:length(names(opts))) {
    opt <- names(opts)[i]
    val <- opts[[opt]]
    out <- paste0(out, "\n  make_option(opt_str = c('--", opt,"')")
    if (opts[[opt]] != "") {
      if (is.character(val)) {
        out <- glue('{out}, default = "{val}", type = "character", help = "[default: %default]"')
      } else {
        out <- glue("{out}, default = {val}")
      }
    }
    if (i == length(names(opts))){
      out <- glue("{out})")
    } else {
      out <- glue("{out}),")
    }
  }
  out <- glue("{out}\n)")
  out <- glue('{out}\nopts <- parse_args(OptionParser(option_list = option_list))')

  # write func section
  out <- glue('{out}\n')
  if (!is.null(func_path)) {
    out <- glue('{out}\nsource("{func_path}")')
  }
  out <- glue('{out}\n{func_name}(')
  for (i in 1:length(names(opts))) {
    opt <- names(opts)[i]
    if (i == 1) {
      out <- glue('{out}opts${opt}')
    } else {
      out <- glue('{out}, opts${opt}')
    }
  }
  out <- glue('{out})')

  # save file
  if (!is.null(out_path)) {
    cat(out, file = out_path)
    system(glue('chmod +x {out_path}'))
  }
  return(out)
}
