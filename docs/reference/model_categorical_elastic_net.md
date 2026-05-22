# model_categorical_elastic_net

model_categorical_elastic_net

## Usage

``` r
model_categorical_elastic_net(x, y, alpha_list = seq(1e-04, 0.9999, 1e-04))
```

## Arguments

- x:

  features/predictors used in prediction of outcome

- y:

  categorical outcome to predict

- alpha_list:

  vector of alpha values to cross-validate

## Value

elastic net results

## See also

Other categorical model wrappers:
[`model_categorical_all()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_all.md),
[`model_categorical_glm()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_glm.md),
[`model_categorical_lasso()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_lasso.md),
[`model_categorical_ridge()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_ridge.md),
[`model_categorical_svm()`](https://ekarinpongpipat.com/eepR/reference/model_categorical_svm.md)

## Examples

``` r
if (FALSE) { # \dontrun{
x <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
y <- iris$Species
model_categorical_elastic_net(x, y, alpha_list = c(0.25, 0.5, 0.75))
} # }
```
