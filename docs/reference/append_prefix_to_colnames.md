# append_prefix_to_colnames

add a string to beginning of all the column names

## Usage

``` r
append_prefix_to_colnames(data, prefix)
```

## Arguments

- data:

  data.frame that contains the column names to change with a prefix

- prefix:

  string to add to the beginning of all of the column names of the
  data.frame

## Value

data.frame with new column names with prefix string appended to the
column names

## Examples

``` r
df <- append_prefix_to_colnames(carData::Salaries, 'p_')
#> Warning: `append_suffix_to_colnames()` was deprecated in eepR 0.5.0.
#> ℹ Please use the `prefix` argument of `append_colnames()` instead.
head(df)
#>      p_rank p_discipline p_yrs.since.phd p_yrs.service p_sex p_salary
#> 1      Prof            B              19            18  Male   139750
#> 2      Prof            B              20            16  Male   173200
#> 3  AsstProf            B               4             3  Male    79750
#> 4      Prof            B              45            39  Male   115000
#> 5      Prof            B              40            41  Male   141500
#> 6 AssocProf            B               6             6  Male    97000
```
