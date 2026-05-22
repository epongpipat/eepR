# plot_scree

plot_scree

## Usage

``` r
plot_scree(sv = NULL, eigs = NULL, p_perm = NULL, a_thr = 0.05)
```

## Arguments

- sv:

  singular values

- eigs:

  eigenvalues

- p_perm:

  permuted p values for each component

- a_thr:

  alpha threshold for significance of permuted p values (default: 0.05)

## Value

patchwork/ggplot object containing scree and cumulative variance plots.

## See also

Other plotting helpers:
[`cor_plot()`](https://ekarinpongpipat.com/eepR/reference/cor_plot.md),
[`move_legend_to_btm()`](https://ekarinpongpipat.com/eepR/reference/move_legend_to_btm.md),
[`plot_age()`](https://ekarinpongpipat.com/eepR/reference/plot_age.md),
[`plot_bland_altman()`](https://ekarinpongpipat.com/eepR/reference/plot_bland_altman.md),
[`plot_cor()`](https://ekarinpongpipat.com/eepR/reference/plot_cor.md),
[`plot_cor_heatmap()`](https://ekarinpongpipat.com/eepR/reference/plot_cor_heatmap.md)

## Examples

``` r
plot_scree(eigs = c(4, 2, 1, 0.5))
```
