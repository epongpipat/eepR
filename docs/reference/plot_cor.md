# plot_cor

plot_cor

## Usage

``` r
plot_cor(x, y, data)
```

## Arguments

- x:

  x variable

- y:

  y variable

- data:

  data that contains the x and y variables

## Value

ggplot2 figure with correlation statistics

## See also

Other plotting helpers:
[`cor_plot()`](https://ekarinpongpipat.com/eepR/reference/cor_plot.md),
[`move_legend_to_btm()`](https://ekarinpongpipat.com/eepR/reference/move_legend_to_btm.md),
[`plot_age()`](https://ekarinpongpipat.com/eepR/reference/plot_age.md),
[`plot_bland_altman()`](https://ekarinpongpipat.com/eepR/reference/plot_bland_altman.md),
[`plot_cor_heatmap()`](https://ekarinpongpipat.com/eepR/reference/plot_cor_heatmap.md),
[`plot_scree()`](https://ekarinpongpipat.com/eepR/reference/plot_scree.md)

## Examples

``` r
plot_cor('yrs.service', 'yrs.since.phd', carData::Salaries)
#> `geom_smooth()` using formula = 'y ~ x'
```
