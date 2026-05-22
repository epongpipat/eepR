# plot_bland_altman

plot_bland_altman

## Usage

``` r
plot_bland_altman(a, b, data, ci = 0.95, txt_offset = 0.25)
```

## Arguments

- a:

  first variable in comparison

- b:

  second variable in comparison

- data:

  data of the variables

- ci:

  confidence interval (default: 0.95)

- txt_offset:

  text offset for labels (default: 0.25)

## Value

ggplot2 Bland-Altman plot.

## See also

Other plotting helpers:
[`cor_plot()`](https://ekarinpongpipat.com/eepR/reference/cor_plot.md),
[`move_legend_to_btm()`](https://ekarinpongpipat.com/eepR/reference/move_legend_to_btm.md),
[`plot_age()`](https://ekarinpongpipat.com/eepR/reference/plot_age.md),
[`plot_cor()`](https://ekarinpongpipat.com/eepR/reference/plot_cor.md),
[`plot_cor_heatmap()`](https://ekarinpongpipat.com/eepR/reference/plot_cor_heatmap.md),
[`plot_scree()`](https://ekarinpongpipat.com/eepR/reference/plot_scree.md)

## Examples

``` r
# note: not the best example, since it should be conceptually similar metrics
plot_bland_altman('yrs.since.phd', 'yrs.service', carData::Salaries)
```
