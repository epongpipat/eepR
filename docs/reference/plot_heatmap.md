# plot_heatmap

Plot an affine/adjacency matrix (e.g., correlation matrix) with a
BIDS-format lookup table, grouping bands, and grid lines.

## Usage

``` r
plot_heatmap(
  affine_matrix,
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
  grid_color = "black",
  grid_linewidth = 0.5,
  legend_title = "Value",
  group_legend_title = group_var
)
```

## Arguments

- affine_matrix:

  A square matrix, data.frame, or a path to a CSV/TSV file containing
  the matrix. Can be with or without row and column names.

- lut:

  A data.frame or a path to a BIDS-format TSV file containing the lookup
  table. Must contain 'index', 'name', and 'color' (hex values) columns,
  and the grouping variable column.

- group_var:

  Character. Name of the column in `lut` to use as the grouping
  variable. Default is `"network"`.

- border_width:

  Integer. Width (in plot units/pixels) of the grouping bands around the
  plot. Set to `0` to omit. Default is `10`.

- scale_fill_type:

  Character. Type of color scale to use: `"gradient2"` (diverging),
  `"viridis"`, or `"distiller"`. Default is `"gradient2"`.

- scale_fill_limits:

  Numeric vector of length 2. Minimum and maximum values for the
  colorscale. Default is `NULL` (auto-calculated).

- scale_fill_low:

  Character. Color for low values in a `"gradient2"` scale. Default is
  `"blue"`.

- scale_fill_mid:

  Character. Color for middle values in a `"gradient2"` scale. Default
  is `"white"`.

- scale_fill_high:

  Character. Color for high values in a `"gradient2"` scale. Default is
  `"red"`.

- scale_fill_midpoint:

  Numeric. Midpoint for a `"gradient2"` scale. Default is `0`.

- scale_fill_palette:

  Character. Name of the palette/option to use for `"viridis"` or
  `"distiller"` scale. Default is `NULL`.

- na_val:

  Numeric. Value(s) in the matrix to replace with `NA`. Default is
  `NULL`.

- scale_fill_na_color:

  Character. Color to use for `NA` values in the matrix. Default is
  `"grey50"`.

- diagonal_to_na:

  Logical. If `TRUE`, sets the diagonal elements of the matrix to `NA`.
  Default is `FALSE`.

- title:

  Character. Title of the plot. Default is `NULL`.

- subtitle:

  Character. Subtitle of the plot. Default is `NULL`.

- x_label:

  Character. Label for the x-axis. Default is `NULL`.

- y_label:

  Character. Label for the y-axis. Default is `NULL`.

- x_breaks:

  Numeric vector. Breaks for the x-axis. Default is `NULL` (defaults to
  `c(1, N)`).

- y_breaks:

  Numeric vector. Breaks for the y-axis. Default is `NULL` (defaults to
  `c(1, N)`).

- out_path:

  Character. Optional path to save the generated plot. If `NULL`, the
  plot is not saved.

- width:

  Numeric. Width of the output image in `units`. Default is `7`.

- height:

  Numeric. Height of the output image in `units`. Default is `6`.

- units:

  Character. Units for output image size (`"in"`, `"cm"`, `"mm"`, or
  `"px"`). Default is `"in"`.

- dpi:

  Numeric. Resolution of the output image in dots per inch. Default is
  `300`.

- match_by_name:

  Logical. If `TRUE`, attempts to align and reorder matrix rows/columns
  to match the lookup table using colnames/rownames matching. Default is
  `TRUE`.

- grid_color:

  Character. Color of the grid lines. Default is `"black"`.

- grid_linewidth:

  Numeric. Width of the grid lines. Default is `0.5`.

- legend_title:

  Character. Title of the heatmap color legend. Default is `"Value"`.

- group_legend_title:

  Character. Title of the grouping band legend. Default matches
  `group_var`.

## Value

A `ggplot` object.

## Examples

``` r
# Simulate a 5x5 lookup table
sim_lut <- data.frame(
  index = 1:5,
  name = as.character(1:5),
  color = c("#ff0000", "#ff0000", "#0000ff", "#0000ff", "#0000ff"),
  network = c("Vis", "Vis", "Default", "Default", "Default"),
  stringsAsFactors = FALSE
)

# Simulate a 5x5 symmetric matrix
sim_matrix <- matrix(
  c(1.0, 0.8, 0.1, 0.2, 0.0,
    0.8, 1.0, 0.2, 0.1, 0.1,
    0.1, 0.2, 1.0, 0.7, 0.6,
    0.2, 0.1, 0.7, 1.0, 0.8,
    0.0, 0.1, 0.6, 0.8, 1.0),
  nrow = 5, ncol = 5
)
rownames(sim_matrix) <- paste0("parcel", 1:5)
colnames(sim_matrix) <- paste0("parcel", 1:5)

# Plot the heatmap
p <- plot_heatmap(
  affine_matrix = sim_matrix,
  lut = sim_lut,
  group_var = "network",
  border_width = 1,
  diagonal_to_na = TRUE,
  title = "Simulated Heatmap"
)
print(p)

```
