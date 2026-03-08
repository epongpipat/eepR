# get_lm_multicollinearity

get_lm_multicollinearity

## Usage

``` r
get_lm_multicollinearity(model)
```

## Arguments

- model:

  fitted model from [`lm()`](https://rdrr.io/r/stats/lm.html)

## Examples

``` r
get_lm_multicollinearity(lm(salary ~ yrs.since.phd + yrs.service, carData::Salaries))
#> yrs.since.phd ~ yrs.service
#> yrs.service ~ yrs.since.phd
#>            term tolerance     vif
#> 1 yrs.since.phd 0.1725384 5.79581
#> 2   yrs.service 0.1725384 5.79581
```
