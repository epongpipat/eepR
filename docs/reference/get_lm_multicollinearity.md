# get_lm_multicollinearity

get_lm_multicollinearity

## Usage

``` r
get_lm_multicollinearity(model)
```

## Arguments

- model:

  fitted model from [`lm()`](https://rdrr.io/r/stats/lm.html)

## Value

A data.frame with multicollinearity diagnostics for each model term.

## See also

Other model summary helpers:
[`models2coefs()`](https://ekarinpongpipat.com/eepR/reference/models2coefs.md),
[`models2omni()`](https://ekarinpongpipat.com/eepR/reference/models2omni.md),
[`r_sq_to_adj_r_sq()`](https://ekarinpongpipat.com/eepR/reference/r_sq_to_adj_r_sq.md),
[`renamed_tidy()`](https://ekarinpongpipat.com/eepR/reference/renamed_tidy.md),
[`tidy_es()`](https://ekarinpongpipat.com/eepR/reference/tidy_es.md),
[`tidy_es_lm()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lm.md),
[`tidy_es_lmer()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lmer.md)

## Examples

``` r
get_lm_multicollinearity(lm(salary ~ yrs.since.phd + yrs.service, carData::Salaries))
#> yrs.since.phd ~ yrs.service
#> yrs.service ~ yrs.since.phd
#>            term tolerance     vif
#> 1 yrs.since.phd 0.1725384 5.79581
#> 2   yrs.service 0.1725384 5.79581
```
