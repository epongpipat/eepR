# model2apa

converts a model to APA format string

## Usage

``` r
model2apa(
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

  model from `lmer()`, [`lm()`](https://rdrr.io/r/stats/lm.html),
  [`cor.test()`](https://rdrr.io/r/stats/cor.test.html), or
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
  t-tests and "F" for joint F-tests.

## Value

Character string with APA-formatted model results.

## See also

Other model2apa:
[`cor2apa()`](https://ekarinpongpipat.com/eepR/reference/cor2apa.md),
[`glht2apa()`](https://ekarinpongpipat.com/eepR/reference/glht2apa.md),
[`lm2apa()`](https://ekarinpongpipat.com/eepR/reference/lm2apa.md),
[`lmer2apa()`](https://ekarinpongpipat.com/eepR/reference/lmer2apa.md)

## Examples

``` r
# cor.test
model2apa(cor.test(carData::Salaries$yrs.since.phd, carData::Salaries$salary), format = 'plain')
#> r(395) = 0.419, p = 2.495×10^-18, 95% CI [0.335, 0.497]

# lm
model2apa(lm(mpg ~ wt, data = mtcars), format = 'plain')
#>                                                                                         (Intercept) 
#> "b = 37.285, t(30) = 19.858, p = 8.242×10^-19, 95% CI [33.450, 41.120], Adjusted R-Squared = 0.927" 
#>                                                                                                  wt 
#> "b = -5.344, t(30) = -9.559, p = 1.294×10^-10, 95% CI [-6.486, -4.203], Adjusted R-Squared = 0.745" 

# lme
model2apa(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy), format = 'plain')
#> Computing profile confidence intervals ...
#> Error in loadNamespace(x): there is no package called ‘broomExtra’

# glht (t-test)
model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
c <- gen_contrast_ss(model_fit, x = "rank")[-1, ]
glht_obj <- multcomp::glht(model_fit, c)
model2apa(glht_obj, test = 't', format = 'plain')
#>                                                                                                   rankAssocProf 
#>        "b = 1.376×10^4, t(393) = 3.475, p = 0.001, 95% CI [5.038×10^3, 2.249×10^4], Adjusted R-Squared = 0.027" 
#>                                                                                                        rankProf 
#> "b = 4.784×10^4, t(393) = 15.376, p = 1.776×10^-15, 95% CI [4.099×10^4, 5.47×10^4], Adjusted R-Squared = 0.374" 
```
