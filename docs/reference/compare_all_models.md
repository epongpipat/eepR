# compare_all_models

compare_all_models

## Usage

``` r
compare_all_models(model_list)
```

## Arguments

- model_list:

  list of models

## Value

comparison of models

## Examples

``` r
data <- carData::Salaries
model_1 <- lm(salary ~ yrs.since.phd, data)
model_2 <- lm(salary ~ yrs.since.phd * rank, data)
model_3 <- lm(salary ~ yrs.since.phd * rank * sex, data)
compare_all_models(list(model_1, model_2, model_3))
#> # A tibble: 3 × 12
#>   model formula           n   n_p     sse      ssr  df_r df_residual f_statistic
#>   <dbl> <chr>         <int> <int>   <dbl>    <dbl> <int>       <int>       <dbl>
#> 1     1 salary ~ yrs…   397     2 2.99e11 NA          NA         395      NA    
#> 2     2 salary ~ yrs…   397     6 2.19e11  8.05e10     4         391      35.9  
#> 3     3 salary ~ yrs…   397    12 2.17e11  1.79e 9     6         385       0.529
#> # ℹ 3 more variables: r_sqaure <dbl>, adj_r_squared <dbl>, p.value <dbl>
```
