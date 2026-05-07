# is_z_scored

Checks if a numeric vector or matrix (column-wise) is z-scored. In other
words, checks if the mean is zero and the standard deviation is one
(within a specified tolerance)

## Usage

``` r
is_z_scored(x, eps = 1e-08)
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
is_z_scored(scale(c(1, 2, 2, 3, 3, 3)))
#> [1] TRUE
```
