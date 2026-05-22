# models2coefs

combines model(s) into a single coefficients table. Uses
[`tidy_es()`](https://ekarinpongpipat.com/eepR/reference/tidy_es.md) and
adds extra columns of extra model attributes

## Usage

``` r
models2coefs(models, attribute = "extra_info")
```

## Arguments

- attribute:

  name of attribute list to turn in columns (default: 'extra_info')

- model:

  a single model or a list of models

## Value

data.frame of extra_info of model attributes, renamed tidy, and effect
size

## Examples

``` r
m1 <- lm(salary ~ yrs.since.phd, carData::Salaries)
attr(m1, 'extra_info') <- list(m = 1, another_key = 'another_value')
models2coefs(m1)
#>   m   another_key     lh op            rh          b        se         t
#> 1 1 another_value salary  ~   (Intercept) 91718.6854 2765.7923 33.161813
#> 2 1 another_value salary  ~ yrs.since.phd   985.3421  107.3651  9.177488
#>               p  r_sq_adj    b_ci_ll   b_ci_ul r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 3.332606e-116 0.7350649 86281.1714 97156.199      0.7026265              1
#> 2  2.495042e-18 0.1736680   774.2636  1196.421      0.1210838              1
```
