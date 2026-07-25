# model2apa

converts a model to APA format string

## Usage

``` r
model2apa(m, terms = "all", level = 0.95, digits = 3, format = "html")
```

## Arguments

- m:

  model from `lmer()`

- terms:

  specify terms to print in APA format (default: all)

- level:

  specify confidence level (default: 0.95)

- digits:

  specify digit to round statistics (default: 3)

- format:

  specify format (default: html) (options: html, plain)

## Value

Character string with APA-formatted model results.

## See also

Other model2apa:
[`cor2apa()`](https://ekarinpongpipat.com/eepR/reference/cor2apa.md),
[`lm2apa()`](https://ekarinpongpipat.com/eepR/reference/lm2apa.md),
[`lmer2apa()`](https://ekarinpongpipat.com/eepR/reference/lmer2apa.md)

## Examples

``` r
# cor.test
model2apa(cor.test(carData::Salaries$yrs.since.phd, carData::Salaries$salary), format = 'plain')
#> r(395) = 0.419, p = 2.5e-18, 95% CI [0.335, 0.497]

# lm
model2apa(lm(mpg ~ wt, data = mtcars), format = 'plain')
#>                                                                                     (Intercept) 
#> "b = 37.285, t(30) = 19.858, p = 8.24e-19, 95% CI [33.450, 41.120], Adjusted R-Squared = 0.927" 
#>                                                                                              wt 
#> "b = -5.344, t(30) = -9.559, p = 1.29e-10, 95% CI [-6.486, -4.203], Adjusted R-Squared = 0.745" 

# lme
model2apa(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy), format = 'plain')
#> Computing profile confidence intervals ...
#>                                                                                         (Intercept) 
#> "b = 251.405, t(174) = 36.838, p = 1.17e-17, 95% CI [237.681, 265.130], Adjusted R-Squared = 0.987" 
#>                                                                                                Days 
#>      "b = 10.467, t(174) = 6.771, p = 3.26e-06, 95% CI [7.359, 13.576], Adjusted R-Squared = 0.714" 
```
