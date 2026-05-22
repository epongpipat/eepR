# flatten_dimension_all

flatten_dimension_all

## Usage

``` r
flatten_dimension_all(data)
```

## Arguments

- data:

  multi-dimensional data to completely flattened/reduced to a single
  dimension

## Value

data that is flattened to a single dimension

## See also

Other dimension flattening helpers:
[`flatten_dimension()`](https://ekarinpongpipat.com/eepR/reference/flatten_dimension.md)

## Examples

``` r
x <- array(1:24, dim = c(2, 3, 4))
flatten_dimension_all(x)
#> Error in eval(first, envir = parent.frame(), enclos = baseenv()): object 'multiprocess' not found
```
