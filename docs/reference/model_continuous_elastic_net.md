# model_continuous_elastic_net

model_continuous_elastic_net

## Usage

``` r
model_continuous_elastic_net(data, y, alpha_list = seq(1e-04, 0.9999, 1e-04))
```

## Arguments

- data:

  data to be analyzed

- y:

  name/string of outcome to be predicted that is within the data

- alpha_list:

  vector of alpha to cross-validate (default: seq(0.0001, 0.9999,
  0.0001))

## Value

elastic net results

## See also

Other continuous model wrappers:
[`model_continuous_lasso()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_lasso.md),
[`model_continuous_ridge()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_ridge.md),
[`model_continuous_svm_linear()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_svm_linear.md)

## Examples

``` r
if (FALSE) { # \dontrun{
data <- data.frame(y = mtcars$mpg, wt = mtcars$wt, hp = mtcars$hp)
model_continuous_elastic_net(data, "y", alpha_list = c(0.25, 0.5, 0.75))
} # }
```
