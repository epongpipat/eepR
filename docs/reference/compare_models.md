# compare_models

compare_models

## Usage

``` r
compare_models(model_1, model_2)
```

## Arguments

- model_1:

  a model to compare

- model_2:

  the other model to compare

## Value

comparison of the two models

## Examples

``` r
data <- carData::Salaries
model_1 <- lm(salary ~ yrs.since.phd * rank, data)
model_2 <- lm(salary ~ yrs.since.phd * rank * sex, data)
compare_models(model_1, model_2)
#> # A tibble: 2 × 12
#>   model formula            n   n_p     sse     ssr  df_r df_residual f_statistic
#>   <dbl> <chr>          <int> <int>   <dbl>   <dbl> <int>       <int>       <dbl>
#> 1     1 salary ~ yrs.…   397     6 2.19e11 NA         NA         391      NA    
#> 2     2 salary ~ yrs.…   397    12 2.17e11  1.79e9     6         385       0.529
#> # ℹ 3 more variables: r_sqaure <dbl>, adj_r_squared <dbl>, p.value <dbl>
```
