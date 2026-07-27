# Create Simple Slopes Contrast Matrix (COPE Matrix)

Create Simple Slopes Contrast Matrix (COPE Matrix)

## Usage

``` r
gen_contrast_ss(model, x, m = NULL, covariates = 0, digits = 4)
```

## Arguments

- model:

  A fitted model object (lm, glm, lmer, lmerTest, etc.).

- x:

  Character string specifying the focal predictor for the slope (e.g.,
  "yrs.since.phd").

- m:

  Moderator specification:

  - NULL (default): No moderators. Returns overall focal predictor
    slopes.

  - Named list: list(yrs.service = "sd", rank = "real").

  - Special list with "all": list(all = c(continuous = "sd", factor =
    "real")).

- covariates:

  Value, summary function, or named list of specific values to hold
  unspecified covariates constant. Default is 0.

- digits:

  Integer specifying the number of decimal places to round continuous
  numeric variables in row names. Default is 4.

## Value

A numeric matrix where rows correspond to simple slope contrasts at
moderator values.

## See also

Other contrast or COPE helpers:
[`check_contrast_orthogonality()`](https://ekarinpongpipat.com/eepR/reference/check_contrast_orthogonality.md),
[`gen_contrast_blank()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_blank.md),
[`tidy_es_cope_F()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_F.md),
[`tidy_es_cope_t()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_t.md)

## Examples

``` r
fit <- lm(salary ~ yrs.since.phd * yrs.service, data = carData::Salaries)
gen_contrast_ss(fit, x = "yrs.since.phd", m = list(yrs.service = "sd"))
#>                                    (Intercept) yrs.since.phd yrs.service
#> yrs.since.phd@yrs.service==4.6086            0             1           0
#> yrs.since.phd@yrs.service==17.6146           0             1           0
#> yrs.since.phd@yrs.service==30.6206           0             1           0
#>                                    yrs.since.phd:yrs.service
#> yrs.since.phd@yrs.service==4.6086                   4.608586
#> yrs.since.phd@yrs.service==17.6146                 17.614610
#> yrs.since.phd@yrs.service==30.6206                 30.620633
```
