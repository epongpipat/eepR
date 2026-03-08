# cor2apa

converts [`cor.test()`](https://rdrr.io/r/stats/cor.test.html) model to
APA format string

## Usage

``` r
cor2apa(m, digits = 3)
```

## Arguments

- m:

  model from [`cor.test()`](https://rdrr.io/r/stats/cor.test.html)

- digits:

  round statistics to specified digit

## Examples

``` r
cor2apa(cor.test(carData::Salaries$yrs.since.phd, carData::Salaries$salary))
#> r(395) = 0.419, p = 2.5e-18, 95% CI [0.335, 0.497]
```
