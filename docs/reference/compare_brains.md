# compare_brains

compare_brains

## Usage

``` r
compare_brains(
  a,
  b,
  mask,
  ci = 0.95,
  legend_title = "Intensity",
  out_path = NULL,
  out_width = 14,
  out_height = 7,
  ...
)
```

## Arguments

- a:

  first image to compare

- b:

  second image to compare

- mask:

  mask image

- ci:

  confidence interval for bland-altman plots (default: 0.95)

- legend_title:

  legend title (default: intensity)

- out_path:

  path to save image

- out_width:

  width of saved image in inches (default: 11)

- out_height:

  height of saved image in inches (default: 8.5)

- ...:

  additional parameters for
  [`plot_brain()`](https://ekarinpongpipat.com/eepR/reference/plot_brain.md)

## Value

ggplot figure comparing two images
