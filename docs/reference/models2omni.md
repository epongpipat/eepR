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

## Examples

``` r
m1 <- lm(salary ~ yrs.since.phd, carData::Salaries)
attr(m1, 'extra_info') <- list(m = 1, another_key = 'another_value')
models2omni(m1)
#> Error in glance(m): No `glance()` method for objects of class <numeric>.
```
