# is_ss1

Checks if a numeric vector or matrix (column-wise) has a sum of squares
equal to 1 (within a specified tolerance)

## Usage

``` r
is_ss1(x, eps = 1e-08)
```

## Arguments

- x:

  a numeric vector or matrix

- eps:

  small error tolerance of being close enough to zero (default: 1e-8)

## Value

vector of logicals

## Examples

``` r
x <- c(1, 2, 2, 3, 3, 3)
is_ss1(scale(x) / sqrt(length(x)))
#> [1] TRUE
```
