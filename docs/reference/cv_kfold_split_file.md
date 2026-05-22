# cv_kfold_split_file

cv_kfold_split_file

## Usage

``` r
cv_kfold_split_file(x_path, y_path, k_fold, out_dir)
```

## Arguments

- x_path:

  path to predictor CSV file

- y_path:

  path to outcome CSV file

- k_fold:

  number of folds

- out_dir:

  output directory for split CSV files

## Value

Invisibly returns `NULL`; writes k-fold train/test CSV files to
`out_dir`.

## Examples

``` r
if (FALSE) { # \dontrun{
tmp <- tempdir()
x_path <- file.path(tmp, "x.csv")
y_path <- file.path(tmp, "y.csv")
write.csv(iris[, 1:4], x_path, row.names = FALSE)
write.csv(iris["Species"], y_path, row.names = FALSE)
cv_kfold_split_file(x_path, y_path, k_fold = 5, out_dir = file.path(tmp, "cv"))
} # }
```
