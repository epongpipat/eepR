# plot_brain

plot_brain

## Usage

``` r
plot_brain(data, indices = NULL, legend_position = NULL, ...)
```

## Arguments

- data:

  3D brain data

- indices:

  slices index of i, j, and k to plot

- legend_position:

  position of the legend can be bottom or NULL (default)

- ...:

  extra options to pass to \`plot_brain_slice\`

## Value

ggplot2 figure of all three directions (i, j, k)
