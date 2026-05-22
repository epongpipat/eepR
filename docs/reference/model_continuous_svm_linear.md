# model_continuous_svm_linear

model continuous linear support vector machine

## Usage

``` r
model_continuous_svm_linear(data, y)
```

## Arguments

- data:

  clean data.frame of predictors and outcome to be analyzed

- y:

  continuous outcome name within the data.frame

## Value

linear svm model

## See also

Other continuous model wrappers:
[`model_continuous_elastic_net()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_elastic_net.md),
[`model_continuous_lasso()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_lasso.md),
[`model_continuous_ridge()`](https://ekarinpongpipat.com/eepR/reference/model_continuous_ridge.md)

## Examples

``` r
data <- data.frame(y = mtcars$mpg, wt = mtcars$wt, hp = mtcars$hp)
model_continuous_svm_linear(data, "y")
#> 
#> Call:
#> svm.default(x = x, y = y, type = "eps-regression", kernel = "linear")
#> 
#> 
#> Parameters:
#>    SVM-Type:  eps-regression 
#>  SVM-Kernel:  linear 
#>        cost:  1 
#>       gamma:  0.5 
#>     epsilon:  0.1 
#> 
#> 
#> Number of Support Vectors:  27
#> 
```
