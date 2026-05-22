# models2omni

model(s) into a single omnibus table. Uses
[`broom::glance()`](https://generics.r-lib.org/reference/glance.html)
and adds extra columns of extra model attributes

## Usage

``` r
models2omni(models, attribute = "extra_info")
```

## Arguments

- models:

  a single model or a list of models

- attribute:

  name of attribute list to turn in columns (default: 'extra_info')

## Value

data.frame of extra_info of model attributes and glance

## See also

Other model summary helpers:
[`get_lm_multicollinearity()`](https://ekarinpongpipat.com/eepR/reference/get_lm_multicollinearity.md),
[`models2coefs()`](https://ekarinpongpipat.com/eepR/reference/models2coefs.md),
[`r_sq_to_adj_r_sq()`](https://ekarinpongpipat.com/eepR/reference/r_sq_to_adj_r_sq.md),
[`renamed_tidy()`](https://ekarinpongpipat.com/eepR/reference/renamed_tidy.md),
[`tidy_es()`](https://ekarinpongpipat.com/eepR/reference/tidy_es.md),
[`tidy_es_lm()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lm.md),
[`tidy_es_lmer()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lmer.md)

## Examples

``` r
m1 <- lm(salary ~ yrs.since.phd, carData::Salaries)
attr(m1, 'extra_info') <- list(m = 1, another_key = 'another_value')
models2omni(m1)
#>   m   another_key r.squared adj.r.squared    sigma statistic      p.value df
#> 1 1 another_value 0.1757547      0.173668 27533.59  84.22628 2.495042e-18  1
#>      logLik      AIC      BIC     deviance df.residual nobs
#> 1 -4620.911 9247.823 9259.774 299448839521         395  397
```
