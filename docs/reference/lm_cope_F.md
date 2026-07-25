# lm_cope_F

perform a contrast over parameter estimate (COPE) *F*-test

## Usage

``` r
lm_cope_F(model_fit, c, label = NULL, ci = 0.95)
```

## Arguments

- model_fit:

  model fitted using [`lm()`](https://rdrr.io/r/stats/lm.html)

- c:

  contrast matrix or list of contrast matrices

- label:

  label for the contrast term (optional, default: names of the contrast
  list or 'Contrast')

- ci:

  confidence interval (default: 0.95)

## Value

data.frame with columns term, ss, df, ms, F, p, r_sq_adj,
r_sq_adj_ci_ll, and r_sq_adj_ci_ul

## See also

Other lm_cope:
[`lm_cope_t()`](https://ekarinpongpipat.com/eepR/reference/lm_cope_t.md)

## Examples

``` r
model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)

# single contrast matrix
c_single <- rbind(
  c(0, 1, 0, 0),
  c(0, 0, 1, 0)
)
lm_cope_F(model_fit, c_single, label = "rank")
#>   term           ss df          ms        F            p  r_sq_adj
#> 1 rank 152810893487  2 76405446744 148.9164 7.267053e-49 0.4282263
#>   r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1      0.3698418              1

# list of contrast matrices
c_list <- list(
  rank = rbind(
    c(0, 1, 0, 0),
    c(0, 0, 1, 0)
  ),
  discipline = matrix(c(0, 0, 0, 1), nrow = 1)
)
lm_cope_F(model_fit, c_list)
#>         term           ss df          ms         F            p   r_sq_adj
#> 1       rank 152810893487  2 76405446744 148.91637 7.267053e-49 0.42822629
#> 2 discipline  18429929986  1 18429929986  35.92045 4.653640e-09 0.08141476
#>   r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1     0.36984178              1
#> 2     0.04329669              1
```
