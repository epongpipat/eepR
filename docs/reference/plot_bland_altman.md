# plot_bland_altman

plot_bland_altman

## Usage

``` r
plot_bland_altman(a, b, data, ci = 0.95, txt_offset = 0.25)
```

## Arguments

- a:

  first variable in comparison

- b:

  second variable in comparison

- data:

  data of the variables

- ci:

  confidence interval (default: 0.95)

- txt_offset:

  text offset for labels (default: 0.25)

## Examples

``` r
# note: not the best example, since it should be conceptually similar metrics
plot_bland_altman('yrs.since.phd', 'yrs.service', carData::Salaries)
```
