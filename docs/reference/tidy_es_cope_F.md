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

Other contrast or COPE helpers:
[`check_contrast_orthogonality()`](https://ekarinpongpipat.com/eepR/reference/check_contrast_orthogonality.md),
[`gen_contrast_blank()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_blank.md),
[`gen_contrast_ss()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_ss.md),
[`gen_data_jn()`](https://ekarinpongpipat.com/eepR/reference/gen_data_jn.md),
[`plot.jn_df()`](https://ekarinpongpipat.com/eepR/reference/plot.jn_df.md),
[`tidy_es_cope_t()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_t.md)

## Examples

``` r
model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
c <- gen_contrast_ss(model_fit, x = "rank")[-1, ]
model_fit_cope_F <- multcomp::glht(model_fit, c)
tidy_es_cope_F(model_fit_cope_F, label = "rank")
#>       lh op   rh           ss df          ms        F            p  r_sq_adj
#> 1 salary  ~ rank 152810893487  2 76405446744 148.9164 7.267053e-49 0.4282263
#>   r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1      0.3698418              1
```
