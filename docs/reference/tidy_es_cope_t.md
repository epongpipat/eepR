# tidy_es_cope_t

a modification of the tidy command that adds the effect size (confidence
intervals for the contrast coefficient and adjusted R^2) for linear
hypothesis testing contrasts (t-test) using glht

## Usage

``` r
tidy_es_cope_t(model, ci = 0.95)
```

## Arguments

- model:

  contrast model from
  [`multcomp::glht()`](https://rdrr.io/pkg/multcomp/man/glht.html)

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
[`tidy_es_cope_F()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_F.md),
[`tidy_es_lm()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lm.md),
[`tidy_es_lmer()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lmer.md)

## Examples

``` r
model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
c <- rbind(
  AssocProf_minus_AsstProf = c(0, 1, 0, 0),
  Prof_minus_AsstProf      = c(0, 0, 1, 0),
  Prof_minus_AssocProf     = c(0, -1, 1, 0)
)
model_fit_cope_t <- multcomp::glht(model_fit, c)
tidy_es_cope_t(model_fit_cope_t)
#>       lh op                       rh        b       se  df         t
#> 1 salary  ~ AssocProf_minus_AsstProf 13761.54 3960.661 393  3.474557
#> 2 salary  ~      Prof_minus_AsstProf 47843.84 3111.552 393 15.376197
#> 3 salary  ~     Prof_minus_AssocProf 34082.30 3159.885 393 10.785929
#>             p   r_sq_adj   b_ci_ll  b_ci_ul r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 0.001612599 0.02733473  4485.395 23037.69    0.007003391              1
#> 2 0.000000000 0.37403428 40556.364 55131.31    0.314935373              1
#> 3 0.000000000 0.22644424 26681.621 41482.97    0.169579185              1
```
