# lm_cope_t

perform a contrast over parameter estimate (COPE) *t*-test

## Usage

``` r
lm_cope_t(model_fit, c, ci = 0.95)
```

## Arguments

- model_fit:

  model fitted using [`lm()`](https://rdrr.io/r/stats/lm.html)

- c:

  contrast matrix

- ci:

  confidence interval (default: 0.95)

## Value

data.frame with columns term, b, se, t, p, b_ci_ll, b_ci_ul, r_sq_adj,
r_sq_adj_ci_ll, and r_sq_adj_ci_ul

## See also

Other lm_cope:
[`lm_cope_F()`](https://ekarinpongpipat.com/eepR/reference/lm_cope_F.md)

## Examples

``` r
model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
c <- rbind(
  AssocProf_minus_AsstProf = c(0, 1, 0, 0),
  Prof_minus_AsstProf      = c(0, 0, 1, 0),
  Prof_minus_AssocProf     = c(0, -1, 1, 0)
)
lm_cope_t(model_fit, c)
#>                       term        b       se         t            p  b_ci_ll
#> 1 AssocProf_minus_AsstProf 13761.54 3960.661  3.474557 5.686954e-04  5974.81
#> 2      Prof_minus_AsstProf 47843.84 3111.552 15.376197 4.174398e-42 41726.47
#> 3     Prof_minus_AssocProf 34082.30 3159.885 10.785929 6.211644e-24 27869.90
#>    b_ci_ul   r_sq_adj r_sq_adj_ci_ll r_sq_adj_ci_ul
#> 1 21548.28 0.02733473    0.007003391              1
#> 2 53961.21 0.37403428    0.314935373              1
#> 3 40294.69 0.22644424    0.169579185              1
```
