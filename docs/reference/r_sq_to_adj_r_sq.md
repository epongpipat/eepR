# r_sq_to_adj_r_sq

Convert r-squared (\$R^2\$) to adjusted r-squared (\$R^2_Adj.\$).

## Usage

``` r
r_sq_to_adj_r_sq(r_sq, n, n_p)
```

## Arguments

- r_sq:

  r-squared (\$R^2\$) value

- n:

  number of subjects/rows

- n_p:

  number of parameters

## Value

adjusted r-squared (\$R^2_Adj.\$) value

## See also

Other model summary helpers:
[`get_lm_multicollinearity()`](https://ekarinpongpipat.com/eepR/reference/get_lm_multicollinearity.md),
[`models2coefs()`](https://ekarinpongpipat.com/eepR/reference/models2coefs.md),
[`models2omni()`](https://ekarinpongpipat.com/eepR/reference/models2omni.md),
[`renamed_tidy()`](https://ekarinpongpipat.com/eepR/reference/renamed_tidy.md),
[`tidy_es()`](https://ekarinpongpipat.com/eepR/reference/tidy_es.md),
[`tidy_es_lm()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lm.md),
[`tidy_es_lmer()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lmer.md)

## Examples

``` r
r_sq_to_adj_r_sq(.5, 100, 5)
#> [1] 0.4789474
```
