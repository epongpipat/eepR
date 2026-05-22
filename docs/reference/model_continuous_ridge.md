# model_continuous_ridge

model_continuous_ridge

## Usage

``` r
model_continuous_ridge(data, y)
```

## Arguments

- data:

  data to be analyzed

- y:

  name/string of outcome to be predicted that is within the data

## Value

ridge results

## See also

Other continuous model wrappers:
[`model_continuous_elastic_net()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_elastic_net.md),
[`model_continuous_lasso()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_lasso.md),
[`model_continuous_svm_linear()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_svm_linear.md)

## Examples

``` r
data <- data.frame(y = mtcars$mpg, wt = mtcars$wt, hp = mtcars$hp)
model_continuous_ridge(data, "y")
#> 
#> Call:  glmnet(x = x, y = y, alpha = 0, lambda = cv_ridge$lambda.min) 
#> 
#>   Df  %Dev Lambda
#> 1  2 82.43 0.5147
```
