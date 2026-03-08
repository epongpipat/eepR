# r_sq_to_adj_r_sq

Convert r-squared (\$R^2\$) to adjusted r-squared (\$R^2_Adj.\$).

## Usage

``` r
r_sq_to_adj_r_sq(r_sq, n, n_p)
```

## Arguments

- r_sq:

  r-squared (\$R^2\$) value

- n:

  number of subjects/rows

- n_p:

  number of parameters

## Value

## Examples

``` r
r_sq_to_adj_r_sq(.5, 100, 5)
#> [1] 0.4789474
```
