#' plot_steps
#' @concept visualization
#' @param in_path path to input csv file of subjects by rows (required)
#' @param out_path path to save output image (optional)
#' @param subjid columns that identify the rows. if more than one, will combine into key1-value1_key2-value2_...keyN-valueN
#' @param title title of plot
#' @param subtitle subtitle of plot
#'
#' @return ggplot2 heatmap of steps
#' @export
#'
#' @importFrom stringr str_replace_all
#' @importFrom stringr  str_remove
#' @importFrom stringr str_subset
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom tidyr separate
#' @importFrom dplyr mutate
#' @importFrom crayon green
#' @importFrom crayon red
#' @import ggplot2
#' @import patchwork
plot_steps <- function(in_path, out_path = NULL, subjid = 'sub', title = NULL, subtitle = NULL) {
  # checks
  if (!file.exists(in_path)) {
    stop(sprintf("file does not exist (%s)", in_path))
  }

  df <- read.csv(in_path)
  colnames(df) <- str_replace_all(colnames(df), '\\..', '. ')
  colnames(df) <- str_remove(colnames(df), 'X')

  if (length(subjid) >= 2) {
    # combine as key1-value1_key2-value2_...keyN-valueN
    df[, 'subjid'] <- apply(df[, subjid], 1, function(x) paste(paste0(subjid, '-', x), collapse='_'))
  } else {
    df[, 'subjid'] <- as.character(df[, subjid])
  }

  # remove non-step columns
  step_vars <- str_subset(colnames(df), '\\.\\s')
  df <- df[, c('subjid', step_vars)]

  df_summary <- df |>
    pivot_longer(cols = -subjid,
                 names_to = 'step',
                 values_to = 'complete') |>
    group_by(step) |>
    summarize(pct_complete = mean(complete),
              n_complete = sum(complete)) |>
    separate(col = step, into = c('step_number', 'step_name'), sep = '. ', remove = FALSE) |>
    mutate(step_number = as.numeric(step_number))

  cat("\n")
  cat("step:", "\n")
  for (i in 1:nrow(df_summary)) {
    if (df_summary$pct_complete[i] == 1) {
      symbol <- green("✓")
    } else {
      symbol <- red("✗")
    }
    cat(symbol, df_summary$step[i], '\n')
  }

  df_long <- df |>
    pivot_longer(cols = -subjid,
                 names_to = 'step',
                 values_to = 'complete') |>
    mutate(complete = as.factor(complete)) |>
    separate(col = step, into = c('step_number', 'step_name'), sep = '. ', remove = FALSE) |>
    mutate(step_number = as.integer(step_number)) |>
    mutate(step2 = str_pad(step_number, 2, 'left', 0))

  i <- which(rowMeans(df[, 2:ncol(df)]) < 1)
  if (length(i) > 0) {
    cat("\n")
    cat("steps incomplete:", "\n")
    print(df[i, ])
    cat('\n')
    cat("no. subjects incomplete:\t", length(i), '\n')
  } else {
    cat("\n")
    cat(green("✓"), 'all steps complete', '\n')
  }

  fig_a <- ggplot(df_summary, aes(step, pct_complete, fill = step_number)) +
    geom_col() +
    geom_hline(yintercept = c(0, 1)) +
    theme_minimal() +
    theme(axis.title.y.right = element_text(angle = 90),
          axis.text.x = element_text(angle = 45, vjust = 0, hjust = 0),
    ) +
    scale_fill_gradient(low = '#60efff', high = 'blue') +
    guides(fill = 'none') +
    labs(subtitle = glue("N: {nrow(df)}"),
         y = '% Complete',
         x = NULL) +
    scale_y_continuous(breaks = seq(0, 1, .2), sec.axis = sec_axis(~ . * nrow(df), breaks = seq(0, 100, 20), name = '# Subjects')) +
    scale_x_discrete(position = 'top')

  fig_b <- ggplot(df_long, aes(step_number, subjid, fill = step_number, alpha = complete)) +
    geom_hline(yintercept = df[i, 'subjid'], color = 'red') +
    geom_tile(color = 'white') +
    theme_minimal() +
    scale_fill_gradient(low = '#60efff', high = 'blue') +
    scale_alpha_manual(values = c('0' = 0, '1' = 1)) +
    coord_fixed() +
    scale_x_continuous(breaks = seq(from = 0, to = ncol(df) - 1, by = 2), expand = c(0, 0)) +
    scale_y_discrete(limits = rev) +
    labs(#y = 'Subject',
         y = NULL,
         x = NULL,
         fill = 'Step') +
    guides(fill = 'none', alpha = 'none')

  fig <- (fig_a / fig_b) +
    plot_annotation(title = title,
                    subtitle = subtitle,
                    #caption = paste0(c('steps:', unique(df_long$step)), collapse = '\n'),
                    theme = theme(plot.caption = element_text(hjust = 0)))

  if (!is.null(out_path)) {
    ggsave(out_path, fig)
  }

  return(invisible(fig))
}
