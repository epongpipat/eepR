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
#> Error in if (attributes(model)$class != "lm") {    stop(glue("attribute must be lm (attribute: {attributes(model)$class})"))}: argument is of length zero
```
