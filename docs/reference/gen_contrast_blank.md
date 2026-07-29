# Create a Blank COPE / Contrast Matrix from a Model or Predictor Names

Create a Blank COPE / Contrast Matrix from a Model or Predictor Names

## Usage

``` r
gen_contrast_blank(model, contrasts = 1)
```

## Arguments

- model:

  A fitted model object (lm, glm, lmer, lmerTest, etc.) OR a character
  vector of parameter names.

- contrasts:

  Number of rows (integer), character vector of row names, or NULL/FALSE
  for no row names. Default is 1 (numeric, so no row names).

## Value

A numeric matrix filled with zeros matching the model's fixed-effect
parameters.

## See also

Other contrast or COPE helpers:
[`check_contrast_orthogonality()`](https://ekarinpongpipat.com/eepR/reference/check_contrast_orthogonality.md),
[`gen_contrast_ss()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_ss.md),
[`gen_data_jn()`](https://ekarinpongpipat.com/eepR/reference/gen_data_jn.md),
[`plot.jn_df()`](https://ekarinpongpipat.com/eepR/reference/plot.jn_df.md),
[`tidy_es_cope_F()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_F.md),
[`tidy_es_cope_t()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_t.md)

## Examples

``` r
fit <- lm(salary ~ rank + yrs.since.phd, data = carData::Salaries)
gen_contrast_blank(fit, contrasts = 2)
#>      (Intercept) rankAssocProf rankProf yrs.since.phd
#> [1,]           0             0        0             0
#> [2,]           0             0        0             0
gen_contrast_blank(fit, contrasts = c("ContrastA", "ContrastB"))
#>           (Intercept) rankAssocProf rankProf yrs.since.phd
#> ContrastA           0             0        0             0
#> ContrastB           0             0        0             0
```
