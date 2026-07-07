# plot_steps

plot_steps

## Usage

``` r
plot_steps(
  in_path,
  out_path = NULL,
  subjid = "sub",
  title = NULL,
  subtitle = NULL
)
```

## Arguments

- in_path:

  path to input csv file of subjects by rows (required)

- out_path:

  path to save output image (optional)

- subjid:

  columns that identify the rows. if more than one, will combine into
  key1-value1_key2-value2\_...keyN-valueN

- title:

  title of plot

- subtitle:

  subtitle of plot

## Value

ggplot2 heatmap of steps
