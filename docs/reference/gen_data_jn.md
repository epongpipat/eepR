# Generate Johnson-Neyman Data

Generate Johnson-Neyman Data

## Usage

``` r
gen_data_jn(data, ci = 0.95)
```

## Arguments

- data:

  A data.frame that is the output of
  [`tidy_es()`](https://ekarinpongpipat.com/eepR/reference/tidy_es.md)
  on a `glht` object.

- ci:

  Confidence interval (0, 1). Default is 0.95.

## Value

A data.frame of class `c("jn_df", "data.frame")` containing:

- `x`: Values of the primary moderator (mapped to the x-axis).

- `group`: Values of the secondary moderator, if any.

- `facet`: Values of the tertiary moderator, if any.

- `predicted`: Simple slope estimate.

- `std.error`: Standard error of the slope.

- `df`: Degrees of freedom.

- `statistic`: t-statistic.

- `p.value`: p-value.

- `conf.low`: Lower bound of the slope confidence interval.

- `conf.high`: Upper bound of the slope confidence interval.

- `sig`: Logical indicating whether the slope is significant (p.value \<
  1 - ci).

## See also

Other contrast or COPE helpers:
[`check_contrast_orthogonality()`](https://ekarinpongpipat.com/eepR/reference/check_contrast_orthogonality.md),
[`gen_contrast_blank()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_blank.md),
[`gen_contrast_ss()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_ss.md),
[`plot.jn_df()`](https://ekarinpongpipat.com/eepR/reference/plot.jn_df.md),
[`tidy_es_cope_F()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_F.md),
[`tidy_es_cope_t()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_t.md)

## Examples

``` r
fit <- lm(salary ~ yrs.since.phd * yrs.service, data = carData::Salaries)
contrast_mat <- gen_contrast_ss(fit, x = "yrs.since.phd", m = list(yrs.service = seq(0, 50, 10)))
glht_obj <- multcomp::glht(fit, linfct = contrast_mat)
tidy_res <- tidy_es(glht_obj)
jn_data <- gen_data_jn(tidy_res)
plot(jn_data)
```
