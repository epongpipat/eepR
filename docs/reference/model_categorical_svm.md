# model_categorical_svm

model_categorical_svm

## Usage

``` r
model_categorical_svm(x, y, kernel = "linear", ...)
```

## Arguments

- x:

  features/predictors used in prediction of outcome

- y:

  categorical outcome to predict

- kernel:

  SVM kernel passed to
  [`e1071::svm()`](https://rdrr.io/pkg/e1071/man/svm.html)

## Value

Fitted SVM model from
[`e1071::svm()`](https://rdrr.io/pkg/e1071/man/svm.html).

## See also

Other categorical model wrappers:
[`model_categorical_all()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_all.md),
[`model_categorical_elastic_net()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_elastic_net.md),
[`model_categorical_glm()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_glm.md),
[`model_categorical_lasso()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_lasso.md),
[`model_categorical_ridge()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_ridge.md)

## Examples

``` r
x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
y <- iris$Species
model_categorical_svm(x, y)
#> 
#> Call:
#> svm.default(x = x, y = y, kernel = kernel)
#> 
#> 
#> Parameters:
#>    SVM-Type:  C-classification 
#>  SVM-Kernel:  linear 
#>        cost:  1 
#> 
#> Number of Support Vectors:  29
#> 
```
