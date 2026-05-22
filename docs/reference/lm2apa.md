# lm2apa

converts [`lm()`](https://rdrr.io/r/stats/lm.html) model to APA format
string

## Usage

``` r
lm2apa(m, terms = "all", level = 0.95, digits = 3, format = "html")
```

## Arguments

- m:

  model from [`lm()`](https://rdrr.io/r/stats/lm.html)

- terms:

  specify terms to print in APA format (default: all)

- level:

  specify confidence level (default: 0.95)

- digits:

  specify digit to round statistics (default: 3)

- format:

  specify format (default: html) (options: html, plain)

## Value

Character string with APA-formatted linear model results.

## See also

Other model2apa:
[`cor2apa()`](https://ekarinpongpipat.com/eepR/reference/cor2apa.md),
[`lmer2apa()`](https://ekarinpongpipat.com/eepR/reference/lmer2apa.md),
[`model2apa()`](https://ekarinpongpipat.com/eepR/reference/model2apa.md)

## Examples

``` r
lm2apa(lm(mpg ~ wt, data = mtcars), format = 'plain')
#>                                                                                     (Intercept) 
#> "b = 37.285, t(30) = 19.858, p = 8.24e-19, 95% CI [33.450, 41.120], Adjusted R-Squared = 0.927" 
#>                                                                                              wt 
#> "b = -5.344, t(30) = -9.559, p = 1.29e-10, 95% CI [-6.486, -4.203], Adjusted R-Squared = 0.745" 
```
