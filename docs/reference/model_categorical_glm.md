# model_categorical_glm

model_categorical_glm

## Usage

``` r
model_categorical_glm(x, y)
```

## Arguments

- x:

  features/predictors used in prediction of outcome

- y:

  categorical outcome to predict

## Value

Fitted binomial GLM or multinomial model.

## See also

Other categorical model wrappers:
[`model_categorical_all()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_all.md),
[`model_categorical_elastic_net()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_elastic_net.md),
[`model_categorical_lasso()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_lasso.md),
[`model_categorical_ridge()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_ridge.md),
[`model_categorical_svm()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_svm.md)

## Examples

``` r
x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
y <- iris$Species
model_categorical_glm(x, y)
#> # weights:  18 (10 variable)
#> initial  value 164.791843 
#> iter  10 value 16.177348
#> iter  20 value 7.111438
#> iter  30 value 6.182999
#> iter  40 value 5.984028
#> iter  50 value 5.961278
#> iter  60 value 5.954900
#> iter  70 value 5.951851
#> iter  80 value 5.950343
#> iter  90 value 5.949904
#> iter 100 value 5.949867
#> final  value 5.949867 
#> stopped after 100 iterations
#> Call:
#> multinom(formula = y ~ x)
#> 
#> Coefficients:
#>            (Intercept) xSepal.Length xSepal.Width xPetal.Length xPetal.Width
#> versicolor    18.69037     -5.458424    -8.707401      14.24477    -3.097684
#> virginica    -23.83628     -7.923634   -15.370769      23.65978    15.135301
#> 
#> Residual Deviance: 11.89973 
#> AIC: 31.89973 
```
