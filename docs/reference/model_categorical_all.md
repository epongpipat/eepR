# model_categorical_all

model_categorical_all

## Usage

``` r
model_categorical_all(x, y)
```

## Arguments

- x:

  features used in prediction

- y:

  outcome to predict

## Value

A tibble with model names and fitted categorical models.

## See also

Other categorical model wrappers:
[`model_categorical_elastic_net()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_elastic_net.md),
[`model_categorical_glm()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_glm.md),
[`model_categorical_lasso()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_lasso.md),
[`model_categorical_ridge()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_ridge.md),
[`model_categorical_svm()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_svm.md)

## Examples

``` r
if (FALSE) { # \dontrun{
x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
y <- iris$Species
model_categorical_all(x, y)
} # }
```
