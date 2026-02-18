#' plot_scree
#'
#' @param sv singular values
#' @param eigs eigenvalues
#' @param p_perm permuted p values for each component
#' @param a_thr alpha threshold for significance of permuted p values (default: 0.05)
#'
#' @returns
#' @export
#'
#' @examples
plot_scree <- function(sv = NULL, eigs = NULL, p_perm = NULL, a_thr = 0.05) {
  if (is.null(sv) & is.null(eigs)) {
    stop('either sv or eigs must be supplied')
  }
  
  tmp <- list()
  if (!is.null(sv)) {
    tmp$eig <- sv^2
  }
  
  if (!is.null(eigs)) {
    tmp$eig <- eigs
  }
  
  if (!is.null(eigs) & !is.null(sv)) {
    warning('both sv and eigs is supplied, using eigs')
  }
  
  tmp$c <- 1:length(tmp$eig)
  
  if (is.null(p_perm)) {
    tmp$p_perm <- p_perm
  }
  
  tmp$data <- as.data.frame(tmp)
  
  tmp$data$r_sq <- tmp$data$eig / sum(tmp$data$eig)
  tmp$data$r_sq_cmltv <- cumsum(tmp$data$r_sq)
  
  # print(tmp$data)
  
  tmp$p1 <- ggplot(tmp$data, aes(c, eig)) +
    geom_line(color = 'lightgray') +
    theme_minimal() +
    scale_x_continuous(breaks = 1:nrow(tmp$data)) +
    scale_y_continuous(sec.axis = sec_axis(transform = ~ . / sum(tmp$data$eig), name = '% Variance Explained')) +
    labs(x = 'Component',
         y = 'Eigenvalue')
  
  if (!is.null(p_perm)) {
    tmp$p1 <- tmp$p1 +
      geom_point(aes(color = p_perm < a_thr)) +
      labs(color = TeX(paste0('$p_{permuted}$ < ', a_thr))) +
      scale_color_manual(values = c('FALSE' = 'lightgray', 'TRUE' = 'black')) +
      move_legend_to_btm()
  } else {
    tmp$p1 <- tmp$p1 +
      geom_point()
  }
  
  tmp$p2 <- ggplot(tmp$data, aes(c, r_sq_cmltv)) +
    geom_line() +
    geom_point() +
    theme_minimal() +
    labs(x = 'Component',
         y = '% Variance Explained (Cumulative)') +
    scale_x_continuous(breaks = 1:nrow(tmp$data)) +
    scale_y_continuous(breaks = seq(0, 1, .1), limits = c(0, 1.01))
  
  tmp$p <- tmp$p1 | tmp$p2
  return(tmp$p)
}