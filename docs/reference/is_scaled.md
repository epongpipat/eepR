# is_scaled

Checks if a numeric vector or matrix (column-wise) is scaled according
to a specified type

## Usage

``` r
is_scaled(x, type = "z", eps = 1e-08)
```

## Arguments

- x:

  a numeric vector or matrix

- type:

  type of scaling to check for. Options are: "mean_centered" (or
  "centered"), "z_scored" (or "z"), and "ss1". Default is "z".

- eps:

  small error tolerance of being close enough to zero (default: 1e-8)

## Value

vector of logicals

## Examples

``` r
is_scaled(scale(c(1, 2, 2, 3, 3, 3)))
#> [1] TRUE
```
