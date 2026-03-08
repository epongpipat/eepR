# append_colnames

add a string to beginning and/or ending of all the column names

## Usage

``` r
append_colnames(data, prefix = NULL, suffix = NULL)
```

## Arguments

- data:

  data.frame that contains the column names to change with a prefix

- prefix:

  string to add to the beginning of all of the column names of the
  data.frame

- suffix:

  string to add to the end of all of the column names of the data.frame

## Value

data.frame with new column names with prefix string appended to the
column names

## Examples

``` r
df <- append_colnames(carData::Salaries, prefix = 'p_', suffix = '_s')
head(df)
#>    p_rank_s p_discipline_s p_yrs.since.phd_s p_yrs.service_s p_sex_s p_salary_s
#> 1      Prof              B                19              18    Male     139750
#> 2      Prof              B                20              16    Male     173200
#> 3  AsstProf              B                 4               3    Male      79750
#> 4      Prof              B                45              39    Male     115000
#> 5      Prof              B                40              41    Male     141500
#> 6 AssocProf              B                 6               6    Male      97000
```
