# lmer2apa

converts `lmer()` model to APA format string

## Usage

``` r
lmer2apa(m, terms = "all", level = 0.95, digits = 3, format = "html")
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

Character string with APA-formatted mixed-effects model results.

## See also

Other model2apa:
[`cor2apa()`](https://ekarinpongpipat.com/eepR/reference/cor2apa.md),
[`lm2apa()`](https://ekarinpongpipat.com/eepR/reference/lm2apa.md),
[`model2apa()`](https://ekarinpongpipat.com/eepR/reference/model2apa.md)

## Examples

``` r
lmer2apa(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy), format = 'plain')
#> Warning: 'oldNames' is deprecated. Please use 'signames' instead.
#> Computing profile confidence intervals ...
#>                                                                                         (Intercept) 
#> "b = 251.405, t(174) = 36.838, p = 1.17e-17, 95% CI [237.681, 265.130], Adjusted R-Squared = 0.987" 
#>                                                                                                Days 
#>      "b = 10.467, t(174) = 6.771, p = 3.26e-06, 95% CI [7.359, 13.576], Adjusted R-Squared = 0.714" 
```
