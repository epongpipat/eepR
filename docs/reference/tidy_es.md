# tidy_es

a modification of the tidy command to adds the effect size (confidence
intervals for the regression coefficient and adjusted R^2)

## Usage

``` r
tidy_es(model, ci = 0.95)
```

## Arguments

- model:

  model fit from [`lm()`](https://rdrr.io/r/stats/lm.html)

- ci:

  confidence interval (0, 1)

## Value

data.frame

## Examples

``` r
tidy_es(lm(salary ~ yrs.since.phd, carData::Salaries))
#>       lh op            rh          b        se         t             p
#> 1 salary  ~   (Intercept) 91718.6854 2765.7923 33.161813 3.332606e-116
#> 2 salary  ~ yrs.since.phd   985.3421  107.3651  9.177488  2.495042e-18
#>    r_sq_adj    b_ci_ll   b_ci_ul r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 0.7350649 86281.1714 97156.199      0.7026265              1
#> 2 0.1736680   774.2636  1196.421      0.1210838              1
```
