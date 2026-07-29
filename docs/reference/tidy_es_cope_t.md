# tidy_es_cope_t

a modification of the tidy command that adds the effect size (confidence
intervals for the contrast coefficient and adjusted R^2) for linear
hypothesis testing contrasts (t-test) using glht

## Usage

``` r
tidy_es_cope_t(
  model,
  ci = 0.95,
  mcc = c("single-step", "none", "uncorrected", "fdr", "FDR", "tukey", "tukey's HSD",
    "Tukey")
)
```

## Arguments

- model:

  contrast model from
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
[`tidy_es()`](https://ekarinpongpipat.com/eepR/reference/tidy_es.md),
[`tidy_es_cope_F()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_F.md),
[`tidy_es_lm()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lm.md),
[`tidy_es_lmer()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_lmer.md)

Other contrast or COPE helpers:
[`check_contrast_orthogonality()`](https://ekarinpongpipat.com/eepR/reference/check_contrast_orthogonality.md),
[`gen_contrast_blank()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_blank.md),
[`gen_contrast_ss()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_ss.md),
[`gen_data_jn()`](https://ekarinpongpipat.com/eepR/reference/gen_data_jn.md),
[`plot.jn_df()`](https://ekarinpongpipat.com/eepR/reference/plot.jn_df.md),
[`tidy_es_cope_F()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_F.md)

## Examples

``` r
model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
c <- gen_contrast_ss(model_fit, x = "rank")[-1, ]
model_fit_cope_t <- multcomp::glht(model_fit, c)
tidy_es_cope_t(model_fit_cope_t)
#>       lh op            rh        b       se  df         t            p
#> 1 salary  ~ rankAssocProf 13761.54 3960.661 393  3.474557 1.092134e-03
#> 2 salary  ~      rankProf 47843.84 3111.552 393 15.376197 1.887379e-15
#>     r_sq_adj   b_ci_ll  b_ci_ul r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 0.02733473  5037.619 22485.47    0.007003391              1
#> 2 0.37403428 40990.199 54697.48    0.314935373              1
```
