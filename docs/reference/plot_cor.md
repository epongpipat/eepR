# plot_cor

plot_cor

## Usage

``` r
plot_cor(x, y, data)
```

## Arguments

- x:

  x variable

- y:

  y variable

- data:

  data that contains the x and y variables

## Value

ggplot2 figure with correlation statistics

## Examples

``` r
plot_cor('yrs.service', 'yrs.since.phd', carData::Salaries)
#> `geom_smooth()` using formula = 'y ~ x'
```
