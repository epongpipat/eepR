# cor2apa

converts [`cor.test()`](https://rdrr.io/r/stats/cor.test.html) model to
APA format string

## Usage

``` r
cor2apa(m, level = 0.95, digits = 3, format = "html")
```

## Arguments

- m:

  model from [`cor.test()`](https://rdrr.io/r/stats/cor.test.html)

- level:

  specify confidence level (default: 0.95). note: level should match the
  confidence level used in
  [`cor.test()`](https://rdrr.io/r/stats/cor.test.html). this argument
  does not actually update the confidence interval range, but only the
  reported confidence interval level

- digits:

  round statistics to specified digit

- format:

  specify format (default: html) (options: html, plain)

## Value

Character string with APA-formatted correlation results.

## See also

Other model2apa:
[`lm2apa()`](https://ekarinpongpipat.com/eepR/reference/lm2apa.md),
[`lmer2apa()`](https://ekarinpongpipat.com/eepR/reference/lmer2apa.md),
[`model2apa()`](https://ekarinpongpipat.com/eepR/reference/model2apa.md)

## Examples

``` r
cor2apa(cor.test(carData::Salaries$yrs.since.phd, carData::Salaries$salary), format = 'plain')
#> r(395) = 0.419, p = 2.5e-18, 95% CI [0.335, 0.497]
```
