# tidy_colnames

makes the data.frame have column names that are in tidy format.

## Usage

``` r
tidy_colnames(data)
```

## Arguments

- data:

  data.frame that contains the column names to be converted

## Value

data.frame with tidy column names

## Details

currently, does the following modifications: 1. lower-case 2.
replaces: - periods with underscores - space with underscores - double
underscore with one underscore - parentheses with underscore - brackets
with underscore - forward and backward slashes with underscore - dash
with underscore - e_mail with email - removes trailing white space and
trailing underscores

## Examples

``` r
# before
colnames(carData::Salaries)
#> [1] "rank"          "discipline"    "yrs.since.phd" "yrs.service"  
#> [5] "sex"           "salary"       

# after
df <- tidy_colnames(carData::Salaries)
#> Warning: `tidy_colnames()` was deprecated in eepR 0.5.0.
#> ℹ Please use `janitor::clean_names()` instead.
colnames(df)
#> [1] "rank"          "discipline"    "yrs_since_phd" "yrs_service"  
#> [5] "sex"           "salary"       
```
