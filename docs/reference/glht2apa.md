# glht2apa

converts [`glht()`](https://rdrr.io/pkg/multcomp/man/glht.html) contrast
model to APA format string

## Usage

``` r
glht2apa(
  m,
  terms = "all",
  level = 0.95,
  digits = 3,
  format = "html",
  test = c("t", "F")
)
```

## Arguments

- m:

  model from
  [`multcomp::glht()`](https://rdrr.io/pkg/multcomp/man/glht.html)

- terms:

  specify terms to print in APA format (default: all)

- level:

  specify confidence level (default: 0.95)

- digits:

  specify digit to round statistics (default: 3)

- format:

  specify format (default: html) (options: html, plain)

- test:

  statistical test for `glht` models. Options are "t" (default) for
  t-tests (multiple comparisons/pairwise contrasts) and "F" for joint
  F-tests.

## Value

Character string with APA-formatted results.

## See also

Other model2apa:
[`cor2apa()`](https://ekarinpongpipat.com/eepR/reference/cor2apa.md),
[`lm2apa()`](https://ekarinpongpipat.com/eepR/reference/lm2apa.md),
[`lmer2apa()`](https://ekarinpongpipat.com/eepR/reference/lmer2apa.md),
[`model2apa()`](https://ekarinpongpipat.com/eepR/reference/model2apa.md)
