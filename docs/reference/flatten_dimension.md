# flatten_dimension

flatten_dimension

## Usage

``` r
flatten_dimension(data)
```

## Arguments

- data:

  multi-dimensional data to be flattened/reduced by a single dimension

## Value

data that is flattened/reduced by a single dimension

## See also

Other dimension flattening helpers:
[`flatten_dimension_all()`](https://ekarinpongpipat.com/eepR/reference/flatten_dimension_all.md)

## Examples

``` r
x <- array(1:24, dim = c(2, 3, 4))
flattened_once <- flatten_dimension(x)
str(flattened_once)
#> tibble [4 × 2] (S3: tbl_df/tbl/data.frame)
#>  $ k   : int [1:4] 1 2 3 4
#>  $ data:List of 4
#>   ..$ : int [1:2, 1:3] 1 2 3 4 5 6
#>   ..$ : int [1:2, 1:3] 7 8 9 10 11 12
#>   ..$ : int [1:2, 1:3] 13 14 15 16 17 18
#>   ..$ : int [1:2, 1:3] 19 20 21 22 23 24
```
