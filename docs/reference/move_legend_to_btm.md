# move_legend_to_btm

move_legend_to_btm

## Usage

``` r
move_legend_to_btm(learn = FALSE)
```

## Arguments

- learn:

  logical, whether to print the equivalent ggplot2 theme code

## Value

ggplot2 theme object

## See also

Other plotting helpers:
[`cor_plot()`](https://ekarinpongpipat.com/eepR/reference/cor_plot.md),
[`plot_age()`](https://ekarinpongpipat.com/eepR/reference/plot_age.md),
[`plot_bland_altman()`](https://ekarinpongpipat.com/eepR/reference/plot_bland_altman.md),
[`plot_cor()`](https://ekarinpongpipat.com/eepR/reference/plot_cor.md),
[`plot_cor_heatmap()`](https://ekarinpongpipat.com/eepR/reference/plot_cor_heatmap.md),
[`plot_scree()`](https://ekarinpongpipat.com/eepR/reference/plot_scree.md)

## Examples

``` r
plot_cor("wt", "mpg", mtcars) + move_legend_to_btm()
#> `geom_smooth()` using formula = 'y ~ x'
```
