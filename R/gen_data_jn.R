#' Generate Johnson-Neyman Data
#'
#' @md
#' @concept stats
#' @family contrast or COPE helpers
#' @param data A data.frame that is the output of [tidy_es()] on a `glht` object.
#' @param ci Confidence interval (0, 1). Default is 0.95.
#'
#' @return A data.frame of class `c("jn_df", "data.frame")` containing:
#'   - `x`: Values of the primary moderator (mapped to the x-axis).
#'   - `group`: Values of the secondary moderator, if any.
#'   - `facet`: Values of the tertiary moderator, if any.
#'   - `predicted`: Simple slope estimate.
#'   - `std.error`: Standard error of the slope.
#'   - `df`: Degrees of freedom.
#'   - `statistic`: t-statistic.
#'   - `p.value`: p-value.
#'   - `conf.low`: Lower bound of the slope confidence interval.
#'   - `conf.high`: Upper bound of the slope confidence interval.
#'   - `sig`: Logical indicating whether the slope is significant (p.value < 1 - ci).
#'
#' @export
#' @importFrom dplyr bind_rows
#' @examples
#' fit <- lm(salary ~ yrs.since.phd * yrs.service, data = carData::Salaries)
#' contrast_mat <- gen_contrast_ss(fit, x = "yrs.since.phd", m = list(yrs.service = seq(0, 50, 10)))
#' glht_obj <- multcomp::glht(fit, linfct = contrast_mat)
#' tidy_res <- tidy_es(glht_obj)
#' jn_data <- gen_data_jn(tidy_res)
#' plot(jn_data)
gen_data_jn <- function(data, ci = 0.95) {
  if (missing(data) || !is.data.frame(data)) {
    stop("Error: 'data' must be a data.frame.")
  }
  if (!"rh" %in% colnames(data)) {
    stop("Error: 'data' must contain a 'rh' column.")
  }
  # Check if there are any @ symbols in rh
  if (!any(grepl("@", data$rh, fixed = TRUE))) {
    stop("Error: 'rh' column does not contain moderator specifications (missing '@').")
  }
  
  # Parse rh column to extract x and moderator values
  parse_rh <- function(rh_vector) {
    parsed_list <- lapply(rh_vector, function(rh) {
      parts <- strsplit(rh, "@", fixed = TRUE)[[1]]
      x_val <- parts[1]
      mods_part <- if (length(parts) > 1) parts[2] else ""
      
      res <- list(x = x_val)
      
      if (mods_part != "") {
        # Split by &
        mod_pairs <- strsplit(mods_part, "&", fixed = TRUE)[[1]]
        for (pair in mod_pairs) {
          # Split by ==
          kv <- strsplit(pair, "==", fixed = TRUE)[[1]]
          if (length(kv) == 2) {
            k <- kv[1]
            v <- kv[2]
            # Remove outer quotes if present
            v <- gsub('^"|"$', '', v)
            # Try to convert to numeric
            v_num <- suppressWarnings(as.numeric(v))
            if (!is.na(v_num)) {
              res[[k]] <- v_num
            } else {
              res[[k]] <- v
            }
          }
        }
      }
      return(res)
    })
    
    df_parsed <- dplyr::bind_rows(parsed_list)
    return(df_parsed)
  }
  
  df_parsed <- parse_rh(data$rh)
  
  # Validate that the focal predictor is continuous (meaning only 1 level name exists before '@')
  if (length(unique(df_parsed$x)) > 1) {
    stop("Error: focal predictor 'x' must be continuous (multiple focal levels found in 'rh').")
  }
  
  focal_name <- unique(df_parsed$x)
  df_parsed$x <- NULL
  
  # Map moderator columns to standard names: x (first), group (second), facet (third)
  mod_cols <- colnames(df_parsed)
  mod_names <- list(
    x = if (length(mod_cols) >= 1) mod_cols[1] else NULL,
    group = if (length(mod_cols) >= 2) mod_cols[2] else NULL,
    facet = if (length(mod_cols) >= 3) mod_cols[3] else NULL
  )
  
  if (length(mod_cols) >= 1) colnames(df_parsed)[1] <- "x"
  if (length(mod_cols) >= 2) colnames(df_parsed)[2] <- "group"
  if (length(mod_cols) >= 3) colnames(df_parsed)[3] <- "facet"
  if (length(mod_cols) >= 4) {
    for (i in 4:length(mod_cols)) {
      colnames(df_parsed)[i] <- paste0("moderator", i)
    }
  }
  
  # Extract and rename target columns from input data
  target_df <- data.frame(
    predicted = data$b,
    std.error = data$se,
    conf.low = data$b_ci_ll,
    conf.high = data$b_ci_ul,
    p.value = data$p
  )
  if ("df" %in% colnames(data)) {
    target_df$df <- data$df
  }
  if ("t" %in% colnames(data)) {
    target_df$statistic <- data$t
  }
  
  # Combine parsed moderators with statistics
  res_df <- cbind(df_parsed, target_df)
  
  # Add sig indicator
  alpha <- 1 - ci
  res_df$sig <- res_df$p.value < alpha
  
  res_df <- as.data.frame(res_df)
  
  # Set attributes for plot method labeling
  attr(res_df, "x.name") <- mod_names$x
  attr(res_df, "x.title") <- mod_names$x
  attr(res_df, "group.name") <- mod_names$group
  attr(res_df, "legend.title") <- mod_names$group
  attr(res_df, "facet.name") <- mod_names$facet
  attr(res_df, "focal.name") <- focal_name
  attr(res_df, "y.title") <- paste("Slope of", focal_name)
  attr(res_df, "title") <- paste("Johnson-Neyman Plot for", focal_name)
  
  # Set S3 class
  class(res_df) <- c("jn_df", "data.frame")
  
  return(res_df)
}

#' Plot Johnson-Neyman Data
#'
#' @md
#' @concept stats
#' @family contrast or COPE helpers
#' @param x An object of class `jn_df` (the output from [gen_data_jn()]).
#' @param ... Additional arguments (not used).
#' @return A `ggplot` object.
#' @export
#' @import ggplot2
plot.jn_df <- function(x, ...) {
  # Retrieve metadata from attributes
  x_title <- attr(x, "x.title")
  y_title <- attr(x, "y.title")
  legend_title <- attr(x, "legend.title")
  title_text <- attr(x, "title")
  
  # Defaults if attributes are missing
  if (is.null(x_title)) x_title <- "Moderator"
  if (is.null(y_title)) y_title <- "Simple Slope"
  if (is.null(legend_title)) legend_title <- "Group"
  if (is.null(title_text)) title_text <- "Johnson-Neyman Plot"
  
  # Standardize sig factor for plot legends
  x$sig <- factor(x$sig, levels = c(TRUE, FALSE))
  
  # Okabe-Ito colorblind friendly palette
  okabe_ito <- c(
    "#E69F00", # Orange
    "#56B4E9", # Sky Blue
    "#009E73", # Bluish Green
    "#F0E442", # Yellow
    "#0072B2", # Blue
    "#D55E00", # Vermillion
    "#CC79A7", # Reddish Purple
    "#000000"  # Black
  )
  
  is_x_numeric <- is.numeric(x$x)
  has_group <- "group" %in% colnames(x)
  has_facet <- "facet" %in% colnames(x)
  
  p <- ggplot2::ggplot(x) +
    ggplot2::geom_hline(yintercept = 0, linetype = "dashed", color = "grey50")
  
  if (is_x_numeric) {
    if (has_group) {
      x$group <- factor(x$group)
      num_levels <- length(levels(x$group))
      
      p <- p +
        ggplot2::geom_ribbon(ggplot2::aes(x = x, ymin = conf.low, ymax = conf.high, fill = group, group = group), alpha = 0.15) +
        ggplot2::geom_line(ggplot2::aes(x = x, y = predicted, color = group, linetype = sig, group = group), linewidth = 1)
      
      if (num_levels <= 8) {
        p <- p +
          ggplot2::scale_color_manual(values = okabe_ito[1:num_levels], name = legend_title) +
          ggplot2::scale_fill_manual(values = okabe_ito[1:num_levels], name = legend_title)
      } else {
        p <- p +
          ggplot2::scale_color_viridis_d(name = legend_title) +
          ggplot2::scale_fill_viridis_d(name = legend_title)
      }
      
      p <- p + ggplot2::scale_linetype_manual(
        values = c("TRUE" = "solid", "FALSE" = "dashed"),
        labels = c("TRUE" = "Significant", "FALSE" = "Non-significant"),
        name = "Significance"
      )
    } else {
      # No secondary moderator: color line and ribbon by significance
      p <- p +
        ggplot2::geom_ribbon(ggplot2::aes(x = x, ymin = conf.low, ymax = conf.high, fill = sig, group = 1), alpha = 0.15) +
        ggplot2::geom_line(ggplot2::aes(x = x, y = predicted, color = sig, group = 1), linewidth = 1) +
        ggplot2::scale_color_manual(
          values = c("TRUE" = "#0072B2", "FALSE" = "#999999"),
          labels = c("TRUE" = "Significant", "FALSE" = "Non-significant"),
          name = "Significance"
        ) +
        ggplot2::scale_fill_manual(
          values = c("TRUE" = "#0072B2", "FALSE" = "#999999"),
          labels = c("TRUE" = "Significant", "FALSE" = "Non-significant"),
          name = "Significance"
        )
    }
  } else {
    # Categorical primary moderator (x is factor/character)
    if (has_group) {
      x$group <- factor(x$group)
      num_levels <- length(levels(x$group))
      
      p <- p +
        ggplot2::geom_pointrange(
          ggplot2::aes(x = factor(x), y = predicted, ymin = conf.low, ymax = conf.high, color = group, shape = sig),
          position = ggplot2::position_dodge(width = 0.5),
          size = 0.8
        )
      
      if (num_levels <= 8) {
        p <- p + ggplot2::scale_color_manual(values = okabe_ito[1:num_levels], name = legend_title)
      } else {
        p <- p + ggplot2::scale_color_viridis_d(name = legend_title)
      }
      
      p <- p + ggplot2::scale_shape_manual(
        values = c("TRUE" = 16, "FALSE" = 1),
        labels = c("TRUE" = "Significant", "FALSE" = "Non-significant"),
        name = "Significance"
      )
    } else {
      p <- p +
        ggplot2::geom_pointrange(
          ggplot2::aes(x = factor(x), y = predicted, ymin = conf.low, ymax = conf.high, color = sig),
          size = 0.8
        ) +
        ggplot2::scale_color_manual(
          values = c("TRUE" = "#0072B2", "FALSE" = "#999999"),
          labels = c("TRUE" = "Significant", "FALSE" = "Non-significant"),
          name = "Significance"
        )
    }
  }
  
  if (has_facet) {
    p <- p + ggplot2::facet_wrap(~ facet)
  }
  
  p <- p +
    ggplot2::labs(x = x_title, y = y_title, title = title_text) +
    ggplot2::theme_classic()
  
  return(p)
}
