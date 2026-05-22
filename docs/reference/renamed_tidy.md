# renamed_tidy

Minor modification of the `tidy()` function that renames the columns to
be more intuitive and adds the left-hand and operator columns for lm
objects

## Usage

``` r
renamed_tidy(model)
```

## Arguments

- model:

  model fit from [`lm()`](https://rdrr.io/r/stats/lm.html)

## Value

data.frame

## See also

Other model summary helpers:
[`get_lm_multicollinearity()`](https://ekarinpongpipat.com/eepR/reference/get_lm_multicollinearity.md),
[`models2coefs()`](https://ekarinpongpipat.com/eepR/reference/models2coefs.md),
[`models2omni()`](https://ekarinpongpipat.com/eepR/reference/models2omni.md),
[`r_sq_to_adj_r_sq()`](https://ekarinpongpipat.com/eepR/reference/r_sq_to_adj_r_sq.md),
[`tidy_es()`](https://ekarinpongpipat.com/eepR/reference/tidy_es.md),
[`tidy_es_lm()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lm.md),
[`tidy_es_lmer()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lmer.md)

## Examples

``` r
renamed_tidy(lm(mpg ~ wt, data = mtcars))
#> # A tibble: 2 × 7
#>   lh    op    rh              b    se     t        p
#>   <chr> <chr> <chr>       <dbl> <dbl> <dbl>    <dbl>
#> 1 mpg   ~     (Intercept) 37.3  1.88  19.9  8.24e-19
#> 2 mpg   ~     wt          -5.34 0.559 -9.56 1.29e-10
```
