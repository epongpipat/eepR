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

## Examples

``` r
renamed_tidy(lm(mpg ~ wt, data = mtcars))
#> # A tibble: 2 × 7
#>   lh    op    rh              b    se     t        p
#>   <chr> <chr> <chr>       <dbl> <dbl> <dbl>    <dbl>
#> 1 mpg   ~     (Intercept) 37.3  1.88  19.9  8.24e-19
#> 2 mpg   ~     wt          -5.34 0.559 -9.56 1.29e-10
```
