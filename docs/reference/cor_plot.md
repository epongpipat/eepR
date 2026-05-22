# cor_plot

cor_plot

## Usage

``` r
cor_plot(data)
```

## Arguments

- data:

  data to create a heat map from

## Value

ggplot2 correlation heatmap.

## See also

Other plotting helpers:
[`move_legend_to_btm()`](https://ekarinpongpipat.com/eepR/reference/move_legend_to_btm.md),
[`plot_age()`](https://ekarinpongpipat.com/eepR/reference/plot_age.md),
[`plot_bland_altman()`](https://ekarinpongpipat.com/eepR/reference/plot_bland_altman.md),
[`plot_cor()`](https://ekarinpongpipat.com/eepR/reference/plot_cor.md),
[`plot_cor_heatmap()`](https://ekarinpongpipat.com/eepR/reference/plot_cor_heatmap.md),
[`plot_scree()`](https://ekarinpongpipat.com/eepR/reference/plot_scree.md)

## Examples

``` r
cor_plot(mtcars)
#> Warning: `cor_plot()` was deprecated in eepR 1.0.0.
#> ℹ Please use `plot_cor_heatmap()` instead.
```
