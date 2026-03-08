# append_suffix_to_colnames

add a string to end of all the column names

## Usage

``` r
append_suffix_to_colnames(data, suffix)
```

## Arguments

- data:

  data.frame that contains the column names to change with a suffix

- suffix:

  string to add to the end of all of the column names of the data.frame

## Value

data.frame with new column names with suffix string appended to the
column names

## Examples

``` r
df <- append_suffix_to_colnames(carData::Salaries, '_s')
#> Warning: `append_suffix_to_colnames()` was deprecated in eepR 0.5.0.
#> ℹ Please use the `suffix` argument of `append_colnames()` instead.
head(df)
#>      rank_s discipline_s yrs.since.phd_s yrs.service_s sex_s salary_s
#> 1      Prof            B              19            18  Male   139750
#> 2      Prof            B              20            16  Male   173200
#> 3  AsstProf            B               4             3  Male    79750
#> 4      Prof            B              45            39  Male   115000
#> 5      Prof            B              40            41  Male   141500
#> 6 AssocProf            B               6             6  Male    97000
```
