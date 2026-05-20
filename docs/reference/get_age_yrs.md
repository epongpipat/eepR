# get_age_yrs

calculate age in years

## Usage

``` r
get_age_yrs(dob, ref_date = lubridate::today())
```

## Arguments

- dob:

  date of birth

- ref_date:

  reference date (default: today's date)

## Examples

``` r
get_age_years('1776-07-04')
#> Error in get_age_years("1776-07-04"): could not find function "get_age_years"
```
