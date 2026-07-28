# Create Data Grid for Model Predictions

Create Data Grid for Model Predictions

## Usage

``` r
gen_data_predict(model, x, m = NULL, covariates = 0)
```

## Arguments

- model:

  A fitted model object (lm, glm, lmer, lmerTest, etc.).

- x:

  Character vector specifying focal predictor(s) (e.g.,
  "yrs.since.phd").

- m:

  Moderator specifications:

  - NULL (default): No moderators.

  - Named list: list(yrs.service = "sd", rank = "real").

  - Special list with "all": list(all = c(continuous = "sd", factor =
    "real")).

- covariates:

  Value, summary function, or named list of specific values to hold
  unspecified covariates constant. Default is 0.

## Value

A data.frame grid ready for stats::predict().

## Examples

``` r
fit <- lm(salary ~ yrs.since.phd * yrs.service, data = carData::Salaries)
gen_data_predict(fit, x = "yrs.since.phd", m = list(yrs.service = "sd"))
#>   yrs.service yrs.since.phd
#> 1    4.608586             0
#> 2   17.614610             0
#> 3   30.620633             0
gen_data_predict(fit, x = "yrs.since.phd", m = list(yrs.service = c(10, 20)))
#>   yrs.service yrs.since.phd
#> 1          10             0
#> 2          20             0
```
