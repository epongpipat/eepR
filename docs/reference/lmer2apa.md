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
[`glht2apa()`](https://ekarinpongpipat.com/eepR/reference/glht2apa.md),
[`lm2apa()`](https://ekarinpongpipat.com/eepR/reference/lm2apa.md),
[`model2apa()`](https://ekarinpongpipat.com/eepR/reference/model2apa.md)

## Examples

``` r
lmer2apa(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy), format = 'plain')
#> Computing profile confidence intervals ...
#> Error in loadNamespace(x): there is no package called ‘broomExtra’
```
