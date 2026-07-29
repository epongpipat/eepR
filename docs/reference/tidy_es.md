# tidy_es

a modification of the renamed tidy command to adds the effect size
(confidence intervals for the regression coefficient and adjusted R^2)

## Usage

``` r
tidy_es(
  model,
  ci = 0.95,
  mcc = c("single-step", "none", "uncorrected", "fdr", "FDR", "tukey", "tukey's HSD",
    "Tukey")
)
```

## Arguments

- model:

  model fit from [`lm()`](https://rdrr.io/r/stats/lm.html),
  [`lmerTest::lmer()`](https://rdrr.io/pkg/lmerTest/man/lmer.html),
  [`lme4::lmer()`](https://rdrr.io/pkg/lme4/man/lmer.html), or
  [`multcomp::glht()`](https://rdrr.io/pkg/multcomp/man/glht.html)

- ci:

  confidence interval (0, 1)

- mcc:

  multiple comparison correction method. Options include "single-step"
  (default, which is what glht provides for Tukey's HSD), "none"
  (uncorrected), "fdr", "FDR", "tukey", "tukey's HSD", and "Tukey".

## Value

data.frame

## See also

Other model summary helpers:
[`get_lm_multicollinearity()`](https://ekarinpongpipat.com/eepR/reference/get_lm_multicollinearity.md),
[`models2coefs()`](https://ekarinpongpipat.com/eepR/reference/models2coefs.md),
[`models2omni()`](https://ekarinpongpipat.com/eepR/reference/models2omni.md),
[`r_sq_to_adj_r_sq()`](https://ekarinpongpipat.com/eepR/reference/r_sq_to_adj_r_sq.md),
[`renamed_tidy()`](https://ekarinpongpipat.com/eepR/reference/renamed_tidy.md),
[`tidy_es_cope_F()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_F.md),
[`tidy_es_cope_t()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_t.md),
[`tidy_es_lm()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lm.md),
[`tidy_es_lmer()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lmer.md)

## Examples

``` r
# example: lm
tidy_es(lm(salary ~ yrs.since.phd, carData::Salaries))
#>       lh op            rh          b        se         t             p
#> 1 salary  ~   (Intercept) 91718.6854 2765.7923 33.161813 3.332606e-116
#> 2 salary  ~ yrs.since.phd   985.3421  107.3651  9.177488  2.495042e-18
#>    r_sq_adj    b_ci_ll   b_ci_ul r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 0.7350649 86281.1714 97156.199      0.7026265              1
#> 2 0.1736680   774.2636  1196.421      0.1210838              1

# example: lmer
tidy_es(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy))
#> Computing profile confidence intervals ...
#>         lh op          rh         b       se       df         t            p
#> 1 Reaction  ~ (Intercept) 251.40510 6.824597 16.99973 36.838090 1.171558e-17
#> 2 Reaction  ~        Days  10.46729 1.545790 16.99998  6.771481 3.263824e-06
#>    r_sq_adj    b_ci_ll   b_ci_ul r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 0.9869002 237.680695 265.12951      0.9743608              1
#> 2 0.7136175   7.358653  13.57592      0.4836195              1

# example: glht
model_fit <- lm(salary ~ rank + discipline, carData::Salaries)
c <- rbind(
  AssocProf_minus_AsstProf = c(0, 1, 0, 0),
  Prof_minus_AsstProf      = c(0, 0, 1, 0),
  Prof_minus_AssocProf     = c(0, -1, 1, 0)
)
model_fit_cope_t <- multcomp::glht(model_fit, c)
tidy_es(model_fit_cope_t)
#>       lh op                       rh        b       se  df         t
#> 1 salary  ~ AssocProf_minus_AsstProf 13761.54 3960.661 393  3.474557
#> 2 salary  ~      Prof_minus_AsstProf 47843.84 3111.552 393 15.376197
#> 3 salary  ~     Prof_minus_AssocProf 34082.30 3159.885 393 10.785929
#>             p   r_sq_adj   b_ci_ll  b_ci_ul r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 0.001630696 0.02733473  4485.219 23037.87    0.007003391              1
#> 2 0.000000000 0.37403428 40556.225 55131.45    0.314935373              1
#> 3 0.000000000 0.22644424 26681.481 41483.11    0.169579185              1
```
