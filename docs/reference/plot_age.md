# plot_age

plot_age

## Usage

``` r
plot_age(data, y_var, x_var = "age", y_lab = NULL, x_lab = "Age")
```

## Arguments

- data:

  input data.frame

- y_var:

  y-axis variable to plot

- x_var:

  x-axis variable to plot

- y_lab:

  y-axis label

- x_lab:

  x-axis label

## Value

ggplot figure of y-axis variable and age

## See also

Other plotting helpers:
[`cor_plot()`](https://ekarinpongpipat.com/eepR/reference/cor_plot.md),
[`move_legend_to_btm()`](https://ekarinpongpipat.com/eepR/reference/move_legend_to_btm.md),
[`plot_bland_altman()`](https://ekarinpongpipat.com/eepR/reference/plot_bland_altman.md),
[`plot_cor()`](https://ekarinpongpipat.com/eepR/reference/plot_cor.md),
[`plot_cor_heatmap()`](https://ekarinpongpipat.com/eepR/reference/plot_cor_heatmap.md),
[`plot_scree()`](https://ekarinpongpipat.com/eepR/reference/plot_scree.md)

## Examples

``` r
data <- data.frame(age = c(20, 30, 40, 50), score = c(4, 6, 7, 9))
plot_age(data, y_var = "score")
#> `geom_smooth()` using formula = 'y ~ x'
```
