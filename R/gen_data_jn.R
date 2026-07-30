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
#' fit1 <- lm(salary ~ yrs.since.phd * yrs.service, data = carData::Salaries)
#' c1 <- gen_contrast_ss(
#'   fit1,
#'   x = "yrs.since.phd",
#'   m = list(yrs.service = "real")
#' )
#' fit_cope1 <- multcomp::glht(fit1, linfct = c1)
#' df_cope_coef1 <- tidy_es(fit_cope1)
#' df_cope_jn1 <- gen_data_jn(df_cope_coef1)
#' plot(df_cope_jn1)
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
  # Dependent variable name (y name)
  y_name <- if ("lh" %in% colnames(data)) data$lh[1] else "y"
  attr(res_df, "y.name") <- y_name
  attr(res_df, "y.title") <- paste("Slope of", focal_name)
  attr(res_df, "title") <- "Johnson-Neyman Plot"
  
  # Set S3 class
  class(res_df) <- c("jn_df", "data.frame")
  
  return(res_df)
}

#' Plot Johnson-Neyman Data
#'
#' @md
#' @concept visualization
#' @family contrast or COPE helpers
#' @param x An object of class `jn_df` (the output from [gen_data_jn()]).
#' @param scales Character vector specifying whether facet scales should be `"fixed"`, `"free_y"`, `"free_x"`, or `"free"`. Default is `"fixed"`.
#' @param nrow Number of rows in the facet grid. Default is `NULL`.
#' @param ncol Number of columns in the facet grid. Default is `NULL`.
#' @param font_family Font family name for the plot text. If `NULL` (default), dynamically checks and uses `"Arial"`, falling back to `"Helvetica"`, then `"sans"`.
#' @param legend.position Character vector specifying the legend position: `"bottom"` (default) or `"right"`.
#' @param slope.symbol Character vector specifying the symbol to represent the slope in the y-axis label: `"b"` (italicized b, default), `"beta"` (italicized Greek beta), `"bhat"` (italicized b with a hat), or `"betahat"` (Greek beta with a hat).
#' @param x_digits Integer specifying the number of decimal places for rounding the x-axis tick labels. Default is `NULL` (no rounding).
#' @param y_digits Integer specifying the number of decimal places for rounding the y-axis tick labels. Default is `NULL` (no rounding).
#' @param x_scientific Logical flag indicating whether to use clean plotmath scientific notation formatting for the x-axis tick labels. Default is `TRUE`.
#' @param y_scientific Logical flag indicating whether to use clean plotmath scientific notation formatting for the y-axis tick labels. Default is `TRUE`.
#' @param ... Additional arguments (not used).
#' @return A `ggplot` object.
#' @export
#' @import ggplot2
#' @examples
#' # 1. Simple moderator example using real values
#' fit1 <- lm(salary ~ yrs.since.phd * yrs.service, data = carData::Salaries)
#' c1 <- gen_contrast_ss(
#'   fit1,
#'   x = "yrs.since.phd",
#'   m = list(yrs.service = "real")
#' )
#' df_tidy_cope1 <- tidy_es(multcomp::glht(fit1, linfct = c1))
#' plot(gen_data_jn(df_tidy_cope1), font_size_max = 12)
#'
#' # 2. Multi-moderator polynomial example with free y scales and custom layout
#' fit2 <- lm(
#'   salary ~ scale(yrs.since.phd, scale = FALSE) * scale(yrs.service, scale = FALSE) +
#'     I(scale(yrs.since.phd, scale = FALSE)^2) * scale(yrs.service, scale = FALSE),
#'   data = carData::Salaries
#' )
#' c2 <- gen_contrast_ss(fit2, x = "yrs.since.phd", m = list(yrs.since.phd = "real", yrs.service = "sd"))
#' df_tidy_cope2 <- tidy_es(multcomp::glht(fit2, c2), mcc = "none")
#' plot(gen_data_jn(df_tidy_cope2), scales = "free_y", nrow = 1, font_size_max = 10)
plot.jn_df <- function(x, scales = "fixed", nrow = NULL, ncol = NULL, font_family = NULL, legend.position = c("bottom", "right"), slope.symbol = c("b", "beta", "bhat", "betahat"), font_size_max = 7, x_digits = NULL, y_digits = NULL, x_scientific = TRUE, y_scientific = TRUE, ...) {
  legend.position <- match.arg(legend.position)
  slope.symbol <- match.arg(slope.symbol)
  
  # Factory function for custom axis label formatter
  make_axis_formatter <- function(digits = NULL, scientific = TRUE) {
    function(val_vec) {
      if (length(val_vec) == 0 || all(is.na(val_vec))) return(character(0))
      
      # Determine scientific notation based on raw formatting per element
      any_scientific <- any(sapply(val_vec, function(v) {
        if (is.na(v)) return(FALSE)
        grepl("e", format(v))
      }))
      
      if (!is.null(digits)) {
        val_vec <- round(val_vec, digits)
      }
      
      if (scientific && any_scientific) {
        s <- scales::scientific(val_vec)
        formatted <- sapply(s, function(v) {
          if (is.na(v)) return(NA)
          if (v == "0e+00" || v == "0") return("0")
          parts <- strsplit(v, "e")[[1]]
          base <- as.numeric(parts[1])
          exp <- as.numeric(parts[2])
          
          if (exp == 0) {
            if (!is.null(digits)) {
              return(paste0("\"", format(base, nsmall = digits, trim = TRUE), "\""))
            } else {
              return(parts[1])
            }
          }
          
          if (!is.null(digits)) {
            base_str_expr <- paste0("\"", format(base, nsmall = digits, trim = TRUE), "\"")
          } else {
            base_str_expr <- parts[1]
          }
          
          if (base_str_expr == "1" && is.null(digits)) {
            paste0("10^", exp)
          } else if (base_str_expr == "-1" && is.null(digits)) {
            paste0("-10^", exp)
          } else {
            paste0(base_str_expr, " %*% 10^", exp)
          }
        })
        return(parse(text = formatted))
      } else {
        return(format(val_vec, trim = TRUE, nsmall = if (!is.null(digits)) digits else 0))
      }
    }
  }
  
  x_formatter <- make_axis_formatter(digits = x_digits, scientific = x_scientific)
  y_formatter <- make_axis_formatter(digits = y_digits, scientific = y_scientific)
  
  # Retrieve metadata from attributes
  x_title <- attr(x, "x.title")
  y_title <- attr(x, "y.title")
  legend_title <- attr(x, "legend.title")
  title_text <- attr(x, "title")
  
  y_name <- attr(x, "y.name")
  if (is.null(y_name) || is.na(y_name) || y_name == "NA" || length(y_name) == 0) {
    y_name <- "y"
  }
  y_name <- trimws(y_name)
  focal_name <- attr(x, "focal.name")
  if (is.null(focal_name)) focal_name <- "x"
  
  symbol_expr <- switch(slope.symbol,
    "b" = quote(italic(b)),
    "beta" = quote(beta),
    "bhat" = quote(hat(italic(b))),
    "betahat" = quote(hat(beta))
  )
  
  y_label <- bquote(.(symbol_expr) ~ "(" * .(y_name) * " / " * .(focal_name) * ")")
  
  # Choose font family (Arial first, falling back to Helvetica, then standard sans)
  if (is.null(font_family)) {
    font_family <- "Arial"
    if (requireNamespace("systemfonts", quietly = TRUE)) {
      if (systemfonts::font_info("Arial")$family != "Arial") {
        if (systemfonts::font_info("Helvetica")$family == "Helvetica") {
          font_family <- "Helvetica"
        } else {
          font_family <- "sans"
        }
      }
    }
  }
  
  # Defaults if attributes are missing
  if (is.null(x_title)) x_title <- "Moderator"
  if (is.null(y_title)) y_title <- "Simple Slope"
  if (is.null(legend_title)) legend_title <- "Group"
  if (is.null(title_text)) title_text <- "Johnson-Neyman Plot"
  
  # Convert to plain data frame to avoid subclass indexing/subsetting quirks in R
  x_df <- as.data.frame(x)
  
  # Standardize sig factor for plot legends
  x_df$sig <- factor(x_df$sig, levels = c(TRUE, FALSE))
  
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
  
  is_x_numeric <- is.numeric(x_df$x)
  has_group <- "group" %in% colnames(x_df)
  has_facet <- "facet" %in% colnames(x_df)
  
  if (has_group) {
    group_name <- attr(x, "group.name")
    if (is.null(group_name)) group_name <- "Group"
    x_df$group <- factor(x_df$group, labels = paste(group_name, "=", levels(factor(x_df$group))))
  }
  if (has_facet) {
    facet_name <- attr(x, "facet.name")
    if (is.null(facet_name)) facet_name <- "Facet"
    x_df$facet <- factor(x_df$facet, labels = paste(facet_name, "=", levels(factor(x_df$facet))))
  }
  
  # Define the dummy data frame for the fill legend (numeric moderator only)
  dummy_legend_df <- data.frame(
    x = as.numeric(NA),
    y = as.numeric(NA),
    Significance = factor(c("Significant", "Non-significant"), levels = c("Significant", "Non-significant"))
  )
  
  # Determine if we have multiple panels
  has_multiple_panels <- has_group || has_facet
  
  if (is.null(title_text) || title_text == "Johnson-Neyman Plot") {
    if (has_multiple_panels) {
      title_text <- "Johnson-Neyman Plots"
    } else {
      title_text <- "Johnson-Neyman Plot"
    }
  }
  
  if (has_multiple_panels) {
    # Generate unique panel combinations for sub-plots
    if (has_group && has_facet) {
      combos <- unique(x_df[, c("group", "facet"), drop = FALSE])
      combos <- combos[order(combos$group, combos$facet), , drop = FALSE]
    } else if (has_group) {
      combos <- unique(x_df[, "group", drop = FALSE])
      combos <- combos[order(combos$group), , drop = FALSE]
    } else {
      combos <- unique(x_df[, "facet", drop = FALSE])
      combos <- combos[order(combos$facet), , drop = FALSE]
    }
    
    # Calculate grid layout columns
    n_plots <- nrow(combos)
    if (is.null(ncol)) {
      if (is.null(nrow)) {
        ncol <- min(3, n_plots)
      } else {
        ncol <- ceiling(n_plots / nrow)
      }
    }
    
    plot_list <- list()
    for (i in 1:n_plots) {
      row_val <- combos[i, , drop = FALSE]
      # Filter subset data for this sub-plot
      if (has_group && has_facet) {
        sub_df <- x_df[x_df$group == row_val$group & x_df$facet == row_val$facet, ]
        panel_title <- paste0(row_val$group, ", ", row_val$facet)
      } else if (has_group) {
        sub_df <- x_df[x_df$group == row_val$group, ]
        panel_title <- as.character(row_val$group)
      } else {
        sub_df <- x_df[x_df$facet == row_val$facet, ]
        panel_title <- as.character(row_val$facet)
      }
      
      # Build the sub-plot
      sub_p <- ggplot2::ggplot(sub_df) +
        ggplot2::geom_hline(yintercept = 0, linetype = "dashed", color = "grey50")
      
      if (is_x_numeric) {
        sub_p <- sub_p +
          ggplot2::geom_ribbon(ggplot2::aes(x = x, ymin = conf.low, ymax = conf.high), fill = "grey90", alpha = 0.3, show.legend = FALSE) +
          ggplot2::geom_ribbon(
            data = subset(sub_df, conf.low > 0),
            ggplot2::aes(x = x, ymin = conf.low, ymax = conf.high),
            fill = "grey60",
            alpha = 0.3,
            show.legend = FALSE
          ) +
          ggplot2::geom_ribbon(
            data = subset(sub_df, conf.high < 0),
            ggplot2::aes(x = x, ymin = conf.low, ymax = conf.high),
            fill = "grey60",
            alpha = 0.3,
            show.legend = FALSE
          ) +
          ggplot2::geom_rect(
            data = dummy_legend_df,
            ggplot2::aes(xmin = x, xmax = x, ymin = y, ymax = y, fill = Significance),
            show.legend = TRUE
          ) +
          ggplot2::geom_line(ggplot2::aes(x = x, y = predicted), color = "black", linewidth = 1) +
          ggplot2::scale_fill_manual(
            values = c(
              "Significant" = "grey60",
              "Non-significant" = "grey90"
            ),
            name = "Significance"
          )
      } else {
        sub_p <- sub_p +
          ggplot2::geom_pointrange(
            ggplot2::aes(x = factor(x), y = predicted, ymin = conf.low, ymax = conf.high, shape = sig),
            color = "black",
            size = 0.8
          ) +
          ggplot2::scale_shape_manual(
            values = c("TRUE" = 16, "FALSE" = 1),
            labels = c("TRUE" = "Significant", "FALSE" = "Non-significant"),
            name = "Significance",
            drop = FALSE
          )
      }
      
      # Setup sub-plot labels and theme
      panel_letter <- letters[i]
      
      # Set y-axis title only on the first column of the grid to save horizontal space
      if ((i - 1) %% ncol == 0) {
        sub_y_label <- y_label
      } else {
        sub_y_label <- NULL
      }
      
      sub_p <- sub_p +
        ggplot2::labs(x = x_title, y = sub_y_label, title = panel_title, tag = panel_letter) +
        ggplot2::scale_y_continuous(labels = y_formatter)
      
      if (is_x_numeric) {
        sub_p <- sub_p + ggplot2::scale_x_continuous(labels = x_formatter)
      }
      
      sub_p <- sub_p +
        ggplot2::theme_classic() +
        ggplot2::theme(
          text = ggplot2::element_text(family = font_family, size = font_size_max),
          plot.tag = ggplot2::element_text(face = "bold", size = font_size_max),
          plot.title = ggplot2::element_text(size = font_size_max, hjust = 0.5),
          axis.title = ggplot2::element_text(size = font_size_max),
          axis.text = ggplot2::element_text(size = font_size_max - 1),
          legend.title = ggplot2::element_text(size = font_size_max),
          legend.text = ggplot2::element_text(size = font_size_max - 1)
        )
      
      plot_list[[i]] <- sub_p
    }
    
    # Combine sub-plots using patchwork and add centered main title
    p_combined <- patchwork::wrap_plots(plot_list, ncol = ncol, nrow = nrow, guides = "collect") +
      patchwork::plot_annotation(
        title = title_text,
        theme = ggplot2::theme(
          plot.title = ggplot2::element_text(
            family = font_family,
            size = font_size_max,
            face = "bold",
            hjust = 0
          )
        )
      ) &
      ggplot2::theme(legend.position = legend.position)
    
    return(p_combined)
    
  } else {
    # Single plot layout (no faceting needed)
    p <- ggplot2::ggplot(x_df) +
      ggplot2::geom_hline(yintercept = 0, linetype = "dashed", color = "grey50")
    
    if (is_x_numeric) {
      p <- p +
        ggplot2::geom_ribbon(ggplot2::aes(x = x, ymin = conf.low, ymax = conf.high), fill = "grey90", alpha = 0.3, show.legend = FALSE) +
        ggplot2::geom_ribbon(
          data = subset(x_df, conf.low > 0),
          ggplot2::aes(x = x, ymin = conf.low, ymax = conf.high),
          fill = "grey60",
          alpha = 0.3,
          show.legend = FALSE
        ) +
        ggplot2::geom_ribbon(
          data = subset(x_df, conf.high < 0),
          ggplot2::aes(x = x, ymin = conf.low, ymax = conf.high),
          fill = "grey60",
          alpha = 0.3,
          show.legend = FALSE
        ) +
        ggplot2::geom_rect(
          data = dummy_legend_df,
          ggplot2::aes(xmin = x, xmax = x, ymin = y, ymax = y, fill = Significance),
          show.legend = TRUE
        ) +
        ggplot2::geom_line(ggplot2::aes(x = x, y = predicted), color = "black", linewidth = 1) +
        ggplot2::scale_fill_manual(
          values = c(
            "Significant" = "grey60",
            "Non-significant" = "grey90"
          ),
          name = "Significance"
        )
    } else {
      p <- p +
        ggplot2::geom_pointrange(
          ggplot2::aes(x = factor(x), y = predicted, ymin = conf.low, ymax = conf.high, shape = sig),
          color = "black",
          size = 0.8
        ) +
        ggplot2::scale_shape_manual(
          values = c("TRUE" = 16, "FALSE" = 1),
          labels = c("TRUE" = "Significant", "FALSE" = "Non-significant"),
          name = "Significance",
          drop = FALSE
        )
    }
    
    # Single plot style
    p <- p +
      ggplot2::labs(x = x_title, y = y_label, title = title_text) +
      ggplot2::scale_y_continuous(labels = y_formatter)
    
    if (is_x_numeric) {
      p <- p + ggplot2::scale_x_continuous(labels = x_formatter)
    }
    
    p <- p +
      ggplot2::theme_classic() +
      ggplot2::theme(
        text = ggplot2::element_text(family = font_family, size = font_size_max),
        plot.title = ggplot2::element_text(size = font_size_max, face = "bold", hjust = 0),
        axis.title = ggplot2::element_text(size = font_size_max),
        axis.text = ggplot2::element_text(size = font_size_max - 1),
        legend.title = ggplot2::element_text(size = font_size_max),
        legend.text = ggplot2::element_text(size = font_size_max - 1),
        legend.position = legend.position
      )
    
    return(p)
  }
}
