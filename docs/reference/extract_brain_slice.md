# extract_brain_slice

extract_brain_slice

## Usage

``` r
extract_brain_slice(data, dir, slice)
```

## Arguments

- data:

  3D brain data

- dir:

  direction to extract slice (choices: i, j, or k)

- slice:

  integer from 1 to slice max

## Value

data.frame of the slice in long format (columns: x, y, value)

## See also

Other neuroimaging helpers:
[`compare_brains()`](https://ekarinpongpipat.com/eepR/reference/compare_brains.md),
[`convet_lut_fs2bids()`](https://ekarinpongpipat.com/eepR/reference/convet_lut_fs2bids.md),
[`get_3dstats()`](https://ekarinpongpipat.com/eepR/reference/get_3dstats.md),
[`plot_brain()`](https://ekarinpongpipat.com/eepR/reference/plot_brain.md),
[`plot_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/plot_brain_slice.md),
[`split_dseg2mask()`](https://ekarinpongpipat.com/eepR/reference/split_dseg2mask.md)

## Examples

``` r
brain <- array(1:27, dim = c(3, 3, 3))
extract_brain_slice(brain, dir = "k", slice = 2)
#> # A tibble: 9 × 3
#>       x     y value
#>   <int> <int> <int>
#> 1     1     1    10
#> 2     1     2    13
#> 3     1     3    16
#> 4     2     1    11
#> 5     2     2    14
#> 6     2     3    17
#> 7     3     1    12
#> 8     3     2    15
#> 9     3     3    18
```
