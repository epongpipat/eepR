# model_categorical_lasso

model_categorical_lasso

## Usage

``` r
model_categorical_lasso(x, y)
```

## Arguments

- x:

  features/predictors used in prediction of outcome

- y:

  categorical outcome to predict

## Value

lasso results

## See also

Other categorical model wrappers:
[`model_categorical_all()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_all.md),
[`model_categorical_elastic_net()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_elastic_net.md),
[`model_categorical_glm()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_glm.md),
[`model_categorical_ridge()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_ridge.md),
[`model_categorical_svm()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_svm.md)

## Examples

``` r
x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
y <- iris$Species
model_categorical_lasso(x, y)
#> 
#> Call:  glmnet(x = x, y = y, family = family, alpha = 1, lambda = cv$lambda.min) 
#> 
#>   Df %Dev   Lambda
#> 1  4 95.6 0.001239
```
