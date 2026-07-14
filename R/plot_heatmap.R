#' @title plot_heatmap
#' @description
#' Plot an affine/adjacency matrix (e.g., correlation matrix) with a BIDS-format lookup table,
#' grouping bands, and grid lines.
#' @concept visualization
#' @concept neuroimaging
#'
#' @param affine_matrix A square matrix, data.frame, or a path to a CSV/TSV file containing the matrix.
#'   Can be with or without row and column names.
#' @param lut A data.frame or a path to a BIDS-format TSV file containing the lookup table.
#'   Must contain 'index' and 'color' (hex values) columns, and the grouping variable column.
#' @param group_var Character. Name of the column in \code{lut} to use as the grouping variable.
#'   Default is \code{"network"}.
#' @param border_width Integer. Width (in plot units/pixels) of the grouping bands around the plot.
#'   Set to \code{0} to omit. Default is \code{10}.
#' @param scale_fill_type Character. Type of color scale to use: \code{"gradient2"} (diverging),
#'   \code{"viridis"}, or \code{"distiller"}. Default is \code{"gradient2"}.
#' @param scale_fill_limits Numeric vector of length 2. Minimum and maximum values for the colorscale.
#'   Default is \code{NULL} (auto-calculated).
#' @param scale_fill_low Character. Color for low values in a \code{"gradient2"} scale. Default is \code{"blue"}.
#' @param scale_fill_mid Character. Color for middle values in a \code{"gradient2"} scale. Default is \code{"white"}.
#' @param scale_fill_high Character. Color for high values in a \code{"gradient2"} scale. Default is \code{"red"}.
#' @param scale_fill_midpoint Numeric. Midpoint for a \code{"gradient2"} scale. Default is \code{0}.
#' @param scale_fill_palette Character. Name of the palette/option to use for \code{"viridis"} or \code{"distiller"} scale.
#'   Default is \code{NULL}.
#' @param na_val Numeric. Value(s) in the matrix to replace with \code{NA}. Default is \code{NULL}.
#' @param scale_fill_na_color Character. Color to use for \code{NA} values in the matrix. Default is \code{"grey50"}.
#' @param diagonal_to_na Logical. If \code{TRUE}, sets the diagonal elements of the matrix to \code{NA}.
#'   Default is \code{FALSE}.
#' @param title Character. Title of the plot. Default is \code{NULL}.
#' @param subtitle Character. Subtitle of the plot. Default is \code{NULL}.
#' @param x_label Character. Label for the x-axis. Default is \code{NULL}.
#' @param y_label Character. Label for the y-axis. Default is \code{NULL}.
#' @param x_breaks Numeric vector. Breaks for the x-axis. Default is \code{NULL} (defaults to \code{c(1, N)}).
#' @param y_breaks Numeric vector. Breaks for the y-axis. Default is \code{NULL} (defaults to \code{c(1, N)}).
#' @param out_path Character. Optional path to save the generated plot. If \code{NULL}, the plot is not saved.
#' @param width Numeric. Width of the output image in \code{units}. Default is \code{7}.
#' @param height Numeric. Height of the output image in \code{units}. Default is \code{6}.
#' @param units Character. Units for output image size (\code{"in"}, \code{"cm"}, \code{"mm"}, or \code{"px"}).
#'   Default is \code{"in"}.
#' @param dpi Numeric. Resolution of the output image in dots per inch. Default is \code{300}.
#' @param match_by_name Logical. If \code{TRUE}, attempts to align and reorder matrix rows/columns to match the lookup table using colnames/rownames matching.
#'   Default is \code{TRUE}.
#' @param diamond Logical. If \code{TRUE}, the heatmap is rotated 45 degrees to display as a diamond shape.
#'   Default is \code{FALSE}.
#' @param diamond_direction Character. Direction of the main diagonal in diamond view: \code{"vertical"} (default) or \code{"horizontal"}.
#' @param grid_color Character. Color of the grid lines. Default is \code{"black"}.
#' @param grid_linewidth Numeric. Width of the grid lines. Default is \code{0.5}.
#' @param legend_title Character. Title of the heatmap color legend. Default is \code{"Value"}.
#' @param group_legend_title Character. Title of the grouping band legend. Default matches \code{group_var}.
#'
#' @examples
#' # Simulate a 400-node lookup table matching Schaefer 400 with Yeo 7 networks
#' networks <- c("Visual", "Somatomotor", "Dorsal Attention", "Ventral Attention",
#'               "Limbic", "Frontoparietal", "Default")
#' net_colors <- c("#781286", "#4682B4", "#00760E", "#C43A4D",
#'                 "#FFFFC4", "#E69422", "#CD3E4E")
#' net_rep <- rep(networks, each = 57, length.out = 400)
#' color_rep <- rep(net_colors, each = 57, length.out = 400)
#' 
#' sim_lut <- data.frame(
#'   index = 1:400,
#'   name = paste0("parcel", 1:400),
#'   color = color_rep,
#'   network = net_rep,
#'   stringsAsFactors = FALSE
#' )
#' 
#' # Simulate a 400x400 symmetric correlation matrix with network block structures
#' set.seed(42)
#' sim_matrix <- matrix(runif(400 * 400, min = -0.2, max = 0.2), nrow = 400, ncol = 400)
#' sim_matrix <- (sim_matrix + t(sim_matrix)) / 2
#' for (net in networks) {
#'   idx <- which(sim_lut$network == net)
#'   sim_matrix[idx, idx] <- sim_matrix[idx, idx] + runif(length(idx)^2, min = 0.3, max = 0.7)
#' }
#' diag(sim_matrix) <- 1.0
#' rownames(sim_matrix) <- sim_lut$name
#' colnames(sim_matrix) <- sim_lut$name
#' 
#' # Plot the heatmap
#' p <- plot_heatmap(
#'   affine_matrix = sim_matrix,
#'   lut = sim_lut,
#'   group_var = "network",
#'   border_width = 10,
#'   diagonal_to_na = TRUE,
#'   title = "Simulated Schaefer 400 (Yeo 7 Networks)"
#' )
#' print(p)
#' 
#' # Plot the same heatmap rotated to be a diamond shape
#' p_diamond <- plot_heatmap(
#'   affine_matrix = sim_matrix,
#'   lut = sim_lut,
#'   group_var = "network",
#'   border_width = 10,
#'   diagonal_to_na = TRUE,
#'   diamond = TRUE,
#'   title = "Rotated Simulated Schaefer 400"
#' )
#' print(p_diamond)
#'
#' @return A \code{ggplot} object.
#' @export
#'
#' @importFrom ggplot2 ggplot geom_raster scale_fill_manual scale_fill_gradient2 scale_fill_viridis_c scale_fill_distiller coord_fixed theme_minimal theme element_blank labs scale_x_continuous scale_y_continuous annotate ggsave element_text
#' @importFrom ggnewscale new_scale_fill
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr mutate select distinct first group_by summarize
#' @importFrom tibble rownames_to_column
#' @importFrom glue glue
#' @importFrom scales squish
plot_heatmap <- function(affine_matrix,
                         lut,
                         group_var = "network",
                         border_width = 10,
                         scale_fill_type = c("gradient2", "viridis", "distiller"),
                         scale_fill_limits = NULL,
                         scale_fill_low = "blue",
                         scale_fill_mid = "white",
                         scale_fill_high = "red",
                         scale_fill_midpoint = 0,
                         scale_fill_palette = NULL,
                         na_val = NULL,
                         scale_fill_na_color = "grey50",
                         diagonal_to_na = FALSE,
                         title = NULL,
                         subtitle = NULL,
                         x_label = NULL,
                         y_label = NULL,
                         x_breaks = NULL,
                         y_breaks = NULL,
                         out_path = NULL,
                         width = 7,
                         height = 6,
                         units = "in",
                         dpi = 300,
                         match_by_name = TRUE,
                         diamond = FALSE,
                         diamond_direction = c("vertical", "horizontal"),
                         grid_color = "black",
                         grid_linewidth = 0.5,
                         legend_title = "Value",
                         group_legend_title = group_var) {

  # Match scale_fill_type parameter
  scale_fill_type <- match.arg(scale_fill_type)
  diamond_direction <- match.arg(diamond_direction)

  # Helper for rotating coordinates for diamond view
  make_polygon_data <- function(df, x_col, y_col, id_prefix) {
    df$cell_id <- paste0(id_prefix, "_", seq_len(nrow(df)))
    if (diamond_direction == "horizontal") {
      df$x_rot <- df[[x_col]] - df[[y_col]]
      df$y_rot <- df[[x_col]] + df[[y_col]]
    } else {
      df$x_rot <- df[[x_col]] + df[[y_col]]
      df$y_rot <- df[[y_col]] - df[[x_col]]
    }
    
    v1 <- df
    v1$x_coord <- v1$x_rot
    v1$y_coord <- v1$y_rot + 1
    
    v2 <- df
    v2$x_coord <- v2$x_rot + 1
    v2$y_coord <- v2$y_rot
    
    v3 <- df
    v3$x_coord <- v3$x_rot
    v3$y_coord <- v3$y_rot - 1
    
    v4 <- df
    v4$x_coord <- v4$x_rot - 1
    v4$y_coord <- v4$y_rot
    
    poly_df <- rbind(v1, v2, v3, v4)
    poly_df <- poly_df[order(poly_df$cell_id), ]
    return(poly_df)
  }

  # 1. Load the lookup table (lut)
  if (is.character(lut)) {
    if (!file.exists(lut)) {
      stop(sprintf("Lookup table file does not exist: %s", lut))
    }
    df_lut <- read.delim(lut, header = TRUE, sep = "\t", check.names = FALSE, stringsAsFactors = FALSE)
  } else {
    df_lut <- as.data.frame(lut, check.names = FALSE, stringsAsFactors = FALSE)
  }

  # Validate lookup table columns
  required_cols <- c("index", "color")
  missing_cols <- setdiff(required_cols, colnames(df_lut))
  if (length(missing_cols) > 0) {
    stop(sprintf("Lookup table is missing required columns: %s", paste(missing_cols, collapse = ", ")))
  }
  if (!group_var %in% colnames(df_lut)) {
    stop(sprintf("Grouping variable '%s' not found in lookup table. Available columns: %s", 
                  group_var, paste(colnames(df_lut), collapse = ", ")))
  }

  # Ensure df_lut is ordered by index first to align with matrix matching
  df_lut <- df_lut[order(df_lut$index), , drop = FALSE]
  N <- nrow(df_lut)

  # 2. Load the affine matrix
  if (is.character(affine_matrix)) {
    if (!file.exists(affine_matrix)) {
      stop(sprintf("Affine matrix file does not exist: %s", affine_matrix))
    }
    # Detect delimiter (comma or tab)
    first_line <- readLines(affine_matrix, n = 1)
    sep <- ","
    if (grepl("\t", first_line)) {
      sep <- "\t"
    }
    df_r <- read.delim(affine_matrix, sep = sep, header = TRUE, check.names = FALSE, stringsAsFactors = FALSE)
  } else {
    df_r <- as.data.frame(affine_matrix, check.names = FALSE)
  }

  # Detect if the first column contains row names (character/factor labels)
  if (ncol(df_r) > 0 && !is.numeric(df_r[[1]])) {
    rnames <- df_r[[1]]
    df_r <- df_r[, -1, drop = FALSE]
    rownames(df_r) <- rnames
  }

  # Convert columns to numeric, just in case
  for (col in seq_len(ncol(df_r))) {
    if (is.character(df_r[[col]])) {
      df_r[[col]] <- suppressWarnings(as.numeric(df_r[[col]]))
    }
  }

  # 3. Match matrix rows/cols to lookup table if requested
  mat_names <- colnames(df_r)
  mat_rownames <- rownames(df_r)
  lut_indexes <- as.character(df_lut$index)

  matched <- FALSE

  if (match_by_name && !is.null(mat_names) && !is.null(mat_rownames)) {
    if ("name" %in% colnames(df_lut)) {
      lut_names <- as.character(df_lut$name)
      if (all(lut_names %in% mat_names) && all(lut_names %in% mat_rownames)) {
        df_r <- df_r[lut_names, lut_names, drop = FALSE]
        matched <- TRUE
      }
    }
    
    if (!matched) {
      if (all(lut_indexes %in% mat_names) && all(lut_indexes %in% mat_rownames)) {
        df_r <- df_r[lut_indexes, lut_indexes, drop = FALSE]
        matched <- TRUE
      } else {
        # Strip non-numeric characters for indices comparison (e.g. 'parcel1' -> '1')
        clean_mat_names <- gsub("[^0-9]", "", mat_names)
        clean_mat_rownames <- gsub("[^0-9]", "", mat_rownames)
        
        if (all(lut_indexes %in% clean_mat_names) && all(lut_indexes %in% clean_mat_rownames)) {
          col_map <- setNames(mat_names, clean_mat_names)
          row_map <- setNames(mat_rownames, clean_mat_rownames)
          
          target_cols <- col_map[lut_indexes]
          target_rows <- row_map[lut_indexes]
          
          df_r <- df_r[target_rows, target_cols, drop = FALSE]
          matched <- TRUE
        }
      }
    }
  }

  if (!matched) {
    if (nrow(df_r) != N || ncol(df_r) != N) {
      warning(sprintf("Matrix dimensions (%dx%d) do not match the lookup table rows (%d). Alignment by position may be incorrect.", 
                      nrow(df_r), ncol(df_r), N))
    }
  }

  # 4. Handle NA transformations
  if (diagonal_to_na) {
    diag(df_r) <- NA
  }

  if (!is.null(na_val)) {
    for (val in na_val) {
      df_r[df_r == val] <- NA
    }
  }

  # Sort lookup table by grouping variable and then index, and reorder matrix accordingly
  sort_idx <- order(df_lut[[group_var]], df_lut$index)
  df_lut <- df_lut[sort_idx, , drop = FALSE]
  df_r <- df_r[sort_idx, sort_idx, drop = FALSE]

  N <- nrow(df_lut)
  df_lut$pos <- seq_len(N)

  # Reset rownames and colnames to 1:N to align with lut$pos
  rownames(df_r) <- seq_len(N)
  colnames(df_r) <- seq_len(N)

  # Reshape to long format and manually invert row index (i) for y-axis mapping (so Row 1 is at N)
  df_r_long <- df_r |>
    as.data.frame() |>
    tibble::rownames_to_column('i') |>
    tidyr::pivot_longer(cols = -i, names_to = 'j', values_to = 'value') |>
    dplyr::mutate(i = as.numeric(i),
                  j = as.numeric(j)) |>
    dplyr::mutate(y_coord = N - i + 1,
                  x_coord = j)

  # 5. Build dynamic grouping attributes (factor preserves order of appearance in LUT)
  df_lut$group_val <- factor(df_lut[[group_var]], levels = unique(df_lut[[group_var]]))
  df_lut$group_num <- match(df_lut[[group_var]], unique(df_lut[[group_var]]))

  group_colors <- df_lut |>
    dplyr::group_by(group_val) |>
    dplyr::summarize(color = dplyr::first(color), .groups = "drop")
  colors_vec <- group_colors$color
  names(colors_vec) <- as.character(group_colors$group_val)

  # 6. Plot initialization
  p <- ggplot2::ggplot()

  # Draw border bands if border_width > 0
  if (border_width > 0) {
    df_lut_long <- do.call(rbind, lapply(1:border_width, function(w) {
      df_tmp <- df_lut
      df_tmp$step <- w
      df_tmp
    }))

    df_lut_long$y_mapped <- N - df_lut_long$pos + 1

    df_lut_long1 <- df_lut_long |> dplyr::mutate(x = pos, y = N + step)
    df_lut_long2 <- df_lut_long |> dplyr::mutate(x = 1 - step, y = y_mapped)
    df_lut_long3 <- df_lut_long |> dplyr::mutate(x = pos, y = 1 - step)
    df_lut_long4 <- df_lut_long |> dplyr::mutate(x = N + step, y = y_mapped)

    if (diamond) {
      poly_df1 <- make_polygon_data(df_lut_long1, "x", "y", "lut1")
      poly_df2 <- make_polygon_data(df_lut_long2, "x", "y", "lut2")
      poly_df3 <- make_polygon_data(df_lut_long3, "x", "y", "lut3")
      poly_df4 <- make_polygon_data(df_lut_long4, "x", "y", "lut4")

      p <- p +
        ggplot2::geom_polygon(data = poly_df1, ggplot2::aes(x = x_coord, y = y_coord, group = cell_id, fill = group_val)) +
        ggplot2::scale_fill_manual(values = colors_vec) +
        ggplot2::labs(fill = group_legend_title) +
        ggnewscale::new_scale_fill() +
        
        ggplot2::geom_polygon(data = poly_df2, ggplot2::aes(x = x_coord, y = y_coord, group = cell_id, fill = group_val)) +
        ggplot2::scale_fill_manual(values = colors_vec) +
        ggplot2::labs(fill = group_legend_title) +
        ggnewscale::new_scale_fill() +
        
        ggplot2::geom_polygon(data = poly_df3, ggplot2::aes(x = x_coord, y = y_coord, group = cell_id, fill = group_val)) +
        ggplot2::scale_fill_manual(values = colors_vec) +
        ggplot2::labs(fill = group_legend_title) +
        ggnewscale::new_scale_fill() +
        
        ggplot2::geom_polygon(data = poly_df4, ggplot2::aes(x = x_coord, y = y_coord, group = cell_id, fill = group_val)) +
        ggplot2::scale_fill_manual(values = colors_vec) +
        ggplot2::labs(fill = group_legend_title) +
        ggnewscale::new_scale_fill()
    } else {
      p <- p +
        ggplot2::geom_raster(data = df_lut_long1, ggplot2::aes(x = x, y = y, fill = group_val)) +
        ggplot2::scale_fill_manual(values = colors_vec) +
        ggplot2::labs(fill = group_legend_title) +
        ggnewscale::new_scale_fill() +
        
        ggplot2::geom_raster(data = df_lut_long2, ggplot2::aes(x = x, y = y, fill = group_val)) +
        ggplot2::scale_fill_manual(values = colors_vec) +
        ggplot2::labs(fill = group_legend_title) +
        ggnewscale::new_scale_fill() +
        
        ggplot2::geom_raster(data = df_lut_long3, ggplot2::aes(x = x, y = y, fill = group_val)) +
        ggplot2::scale_fill_manual(values = colors_vec) +
        ggplot2::labs(fill = group_legend_title) +
        ggnewscale::new_scale_fill() +
        
        ggplot2::geom_raster(data = df_lut_long4, ggplot2::aes(x = x, y = y, fill = group_val)) +
        ggplot2::scale_fill_manual(values = colors_vec) +
        ggplot2::labs(fill = group_legend_title) +
        ggnewscale::new_scale_fill()
    }
  }

  # Draw main matrix heatmap
  if (diamond) {
    poly_df_r <- make_polygon_data(df_r_long, "x_coord", "y_coord", "r")
    p <- p + ggplot2::geom_polygon(data = poly_df_r, ggplot2::aes(x = x_coord, y = y_coord, group = cell_id, fill = value))
  } else {
    p <- p + ggplot2::geom_raster(data = df_r_long, ggplot2::aes(x = x_coord, y = y_coord, fill = value))
  }

  # Main heatmap fill colorscale
  if (scale_fill_type == "gradient2") {
    p <- p + ggplot2::scale_fill_gradient2(
      low = scale_fill_low,
      mid = scale_fill_mid,
      high = scale_fill_high,
      midpoint = scale_fill_midpoint,
      limits = scale_fill_limits,
      oob = scales::squish,
      na.value = scale_fill_na_color
    )
  } else if (scale_fill_type == "viridis") {
    palette_option <- if (is.null(scale_fill_palette)) "D" else scale_fill_palette
    p <- p + ggplot2::scale_fill_viridis_c(
      option = palette_option,
      limits = scale_fill_limits,
      oob = scales::squish,
      na.value = scale_fill_na_color
    )
  } else if (scale_fill_type == "distiller") {
    palette_name <- if (is.null(scale_fill_palette)) "RdBu" else scale_fill_palette
    p <- p + ggplot2::scale_fill_distiller(
      palette = palette_name,
      limits = scale_fill_limits,
      oob = scales::squish,
      na.value = scale_fill_na_color
    )
  }

  # Setup breaks (reverse y breaks layout to match custom positive coordinate inversion)
  if (is.null(x_breaks)) x_breaks <- c(1, N)
  if (is.null(y_breaks)) y_breaks <- c(1, N)
  y_break_positions <- N - y_breaks + 1

  # Theme and labels
  p <- p +
    ggplot2::labs(fill = legend_title) +
    ggplot2::coord_fixed() +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank()
    ) +
    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      x = x_label,
      y = y_label
    )

  if (diamond) {
    p <- p + ggplot2::theme(
      axis.title.x = ggplot2::element_blank(),
      axis.title.y = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks.x = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank()
    )
  } else {
    p <- p +
      ggplot2::scale_x_continuous(breaks = x_breaks) +
      ggplot2::scale_y_continuous(breaks = y_break_positions, labels = y_breaks)
  }

  # Draw grid lines separating groups
  transitions <- which(diff(df_lut$group_num) != 0)
  grid_idx_x <- c(0.5, transitions + 0.5, N + 0.5)
  grid_idx_y <- c(0.5, N - transitions + 0.5, N + 0.5)

  if (diamond) {
    if (diamond_direction == "horizontal") {
      # Draw vertical grid lines (rotated, horizontal direction)
      for (idx in grid_idx_x) {
        y_start <- 0.5 - border_width
        y_end <- N + 0.5 + border_width
        p <- p + ggplot2::annotate(
          "segment",
          x = idx - y_start,
          xend = idx - y_end,
          y = idx + y_start,
          yend = idx + y_end,
          color = grid_color,
          linewidth = grid_linewidth
        )
      }
      # Draw horizontal grid lines (rotated, horizontal direction)
      for (idx in grid_idx_y) {
        x_start <- 0.5 - border_width
        x_end <- N + 0.5 + border_width
        p <- p + ggplot2::annotate(
          "segment",
          x = x_start - idx,
          xend = x_end - idx,
          y = x_start + idx,
          yend = x_end + idx,
          color = grid_color,
          linewidth = grid_linewidth
        )
      }

      # Outer border boxes (rotated, horizontal direction)
      if (border_width > 0) {
        p <- p +
          # Left outer boundary
          ggplot2::annotate("segment", x = 0.5 - border_width - 0.5, xend = 0.5 - border_width - (N + 0.5), y = 0.5 - border_width + 0.5, yend = 0.5 - border_width + N + 0.5, color = grid_color, linewidth = grid_linewidth) +
          # Right outer boundary
          ggplot2::annotate("segment", x = N + 0.5 + border_width - 0.5, xend = N + 0.5 + border_width - (N + 0.5), y = N + 0.5 + border_width + 0.5, yend = N + 0.5 + border_width + N + 0.5, color = grid_color, linewidth = grid_linewidth) +
          # Bottom outer boundary
          ggplot2::annotate("segment", x = 0.5 - (0.5 - border_width), xend = N + 0.5 - (0.5 - border_width), y = 0.5 + 0.5 - border_width, yend = N + 0.5 + 0.5 - border_width, color = grid_color, linewidth = grid_linewidth) +
          # Top outer boundary
          ggplot2::annotate("segment", x = 0.5 - (N + 0.5 + border_width), xend = N + 0.5 - (N + 0.5 + border_width), y = 0.5 + N + 0.5 + border_width, yend = N + 0.5 + N + 0.5 + border_width, color = grid_color, linewidth = grid_linewidth)
      }
    } else {
      # Draw vertical grid lines (rotated, vertical direction)
      for (idx in grid_idx_x) {
        y_start <- 0.5 - border_width
        y_end <- N + 0.5 + border_width
        p <- p + ggplot2::annotate(
          "segment",
          x = idx + y_start,
          xend = idx + y_end,
          y = y_start - idx,
          yend = y_end - idx,
          color = grid_color,
          linewidth = grid_linewidth
        )
      }
      # Draw horizontal grid lines (rotated, vertical direction)
      for (idx in grid_idx_y) {
        x_start <- 0.5 - border_width
        x_end <- N + 0.5 + border_width
        p <- p + ggplot2::annotate(
          "segment",
          x = x_start + idx,
          xend = x_end + idx,
          y = idx - x_start,
          yend = idx - x_end,
          color = grid_color,
          linewidth = grid_linewidth
        )
      }

      # Outer border boxes (rotated, vertical direction)
      if (border_width > 0) {
        p <- p +
          # Left outer boundary
          ggplot2::annotate("segment", x = 0.5 - border_width + 0.5, xend = 0.5 - border_width + N + 0.5, y = border_width, yend = N + border_width, color = grid_color, linewidth = grid_linewidth) +
          # Right outer boundary
          ggplot2::annotate("segment", x = N + 0.5 + border_width + 0.5, xend = N + 0.5 + border_width + N + 0.5, y = -N - border_width, yend = -border_width, color = grid_color, linewidth = grid_linewidth) +
          # Bottom outer boundary
          ggplot2::annotate("segment", x = 0.5 + 0.5 - border_width, xend = N + 0.5 + 0.5 - border_width, y = -border_width, yend = -N - border_width, color = grid_color, linewidth = grid_linewidth) +
          # Top outer boundary
          ggplot2::annotate("segment", x = 0.5 + N + 0.5 + border_width, xend = N + 0.5 + N + 0.5 + border_width, y = N + border_width, yend = border_width, color = grid_color, linewidth = grid_linewidth)
      }
    }
  } else {
    # Draw vertical grid lines
    for (idx in grid_idx_x) {
      p <- p + ggplot2::annotate("segment", x = idx, xend = idx, y = 0.5 - border_width, yend = N + 0.5 + border_width, color = grid_color, linewidth = grid_linewidth)
    }
    # Draw horizontal grid lines
    for (idx in grid_idx_y) {
      p <- p + ggplot2::annotate("segment", x = 0.5 - border_width, xend = N + 0.5 + border_width, y = idx, yend = idx, color = grid_color, linewidth = grid_linewidth)
    }

    # Outer border boxes
    if (border_width > 0) {
      p <- p +
        ggplot2::annotate("segment", x = 0.5 - border_width, xend = 0.5 - border_width, y = 0.5, yend = N + 0.5, color = grid_color, linewidth = grid_linewidth) +
        ggplot2::annotate("segment", x = N + 0.5 + border_width, xend = N + 0.5 + border_width, y = 0.5, yend = N + 0.5, color = grid_color, linewidth = grid_linewidth) +
        ggplot2::annotate("segment", x = 0.5, xend = N + 0.5, y = 0.5 - border_width, yend = 0.5 - border_width, color = grid_color, linewidth = grid_linewidth) +
        ggplot2::annotate("segment", x = 0.5, xend = N + 0.5, y = N + 0.5 + border_width, yend = N + 0.5 + border_width, color = grid_color, linewidth = grid_linewidth)
    }
  }

  # Save plot if out_path is provided
  if (!is.null(out_path)) {
    ggplot2::ggsave(
      filename = out_path,
      plot = p,
      width = width,
      height = height,
      units = units,
      dpi = dpi
    )
  }

  return(p)
}
