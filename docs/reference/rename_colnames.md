# rename_colnames

rename column names

## Usage

``` r
rename_colnames(data, new_colnames)
```

## Arguments

- data:

  data.frame to be renamed

- new_colnames:

  a vector of new column names

## Value

data.frame with the new column names

## See also

Other column name helpers:
[`append_colnames()`](https://ekarinpongpipat.com/eepR/reference/append_colnames.md),
[`append_prefix_to_colnames()`](https://ekarinpongpipat.com/eepR/reference/append_prefix_to_colnames.md),
[`append_suffix_to_colnames()`](https://ekarinpongpipat.com/eepR/reference/append_suffix_to_colnames.md),
[`tidy_colnames()`](https://ekarinpongpipat.com/eepR/reference/tidy_colnames.md)

## Examples

``` r
rename_colnames(
  data.frame(a = 1:3, b = 4:6),
  c("participant_id", "score")
)
#>   participant_id score
#> 1              1     4
#> 2              2     5
#> 3              3     6
```
