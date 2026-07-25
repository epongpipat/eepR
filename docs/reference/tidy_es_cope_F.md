# tidy_es_cope_F

a modification of the tidy command that adds the effect size (confidence
intervals for the adjusted R^2) for linear hypothesis testing contrasts
(joint F-test) using glht

## Usage

``` r
tidy_es_cope_F(model, label = NULL, ci = 0.95)
```

## Arguments

- model:

  contrast model from
  [`multcomp::glht()`](https://rdrr.io/pkg/multcomp/man/glht.html)

- label:

  label for the contrast term (default: joined contrast names)

- ci:

  confidence interval (0, 1)

## Value

data.frame

## See also

Other model summary helpers:
[`get_lm_multicollinearity()`](https://ekarinpongpipat.com/eepR/reference/get_lm_multicollinearity.md),
[`models2coefs()`](https://ekarinpongpipat.com/eepR/reference/models2coefs.md),
[`models2omni()`](https://ekarinpongpipat.com/eepR/reference/models2omni.md),
[`r_sq_to_adj_r_sq()`](https://ekarinpongpipat.com/eepR/reference/r_sq_to_adj_r_sq.md),
[`renamed_tidy()`](https://ekarinpongpipat.com/eepR/reference/renamed_tidy.md),
[`tidy_es()`](https://ekarinpongpipat.com/eepR/reference/tidy_es.md),
[`tidy_es_cope_t()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_t.md),
[`tidy_es_lm()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lm.md),
[`tidy_es_lmer()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lmer.md)

## Examples

``` r
model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
c <- rbind(
  c(0, 1, 0, 0),
  c(0, 0, 1, 0)
)
model_fit_cope_F <- multcomp::glht(model_fit, c)
tidy_es_cope_F(model_fit_cope_F, label = "rank")
#>       lh op   rh       ss df       ms        F            p  r_sq_adj
#> 1 salary  ~ rank 297.8327  2 148.9164 148.9164 7.267053e-49 0.4282263
#>   r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1      0.3698418              1
```
