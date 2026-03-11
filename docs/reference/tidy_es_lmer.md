# tidy_es_lmer

a modification of the renamed tidy command that adds the effect size
(confidence intervals for the regression coefficient and adjusted R^2)

## Usage

``` r
tidy_es_lmer(model, ci = 0.95)
```

## Arguments

- model:

  model output from
  [`lmerTest::lmer()`](https://rdrr.io/pkg/lmerTest/man/lmer.html) or
  [`lme4::lmer()`](https://rdrr.io/pkg/lme4/man/lmer.html)

- ci:

  confidence interval (default: 0.95)

## Value

data.frame

## Examples

``` r
tidy_es_lmer(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy))
#> Computing profile confidence intervals ...
#>         lh op          rh         b       se       df         t            p
#> 1 Reaction  ~ (Intercept) 251.40510 6.824597 16.99973 36.838090 1.171558e-17
#> 2 Reaction  ~        Days  10.46729 1.545790 16.99998  6.771481 3.263824e-06
#>    r_sq_adj    b_ci_ll   b_ci_ul r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 0.9869002 237.680696 265.12951      0.9743608              1
#> 2 0.7136175   7.358653  13.57592      0.4836195              1
```
