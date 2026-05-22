# plot_brain

plot_brain

## Usage

``` r
plot_brain(
  data,
  indices = NULL,
  legend_position = NULL,
  bg_color = "black",
  text_color = "white",
  out_path = NULL,
  out_width = 12,
  out_height = 3,
  ...
)
```

## Arguments

- data:

  3D brain data

- indices:

  slices index of i, j, and k to plot

- legend_position:

  position of the legend can be bottom or NULL (default)

- bg_color:

  background color (default: black)

- text_color:

  text color (default: white)

- out_path:

  path to save image (default: NULL)

- out_width:

  width to saved image in inches (default: 11)

- out_height:

  height of saved image in inches (default: 8.5)

- ...:

  extra options to pass to
  [`plot_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/plot_brain_slice.md)

## Value

ggplot2 figure of all three directions (i, j, k)

## See also

Other neuroimaging helpers:
[`compare_brains()`](https://ekarinpongpipat.com/eepR/reference/compare_brains.md),
[`convet_lut_fs2bids()`](https://ekarinpongpipat.com/eepR/reference/convet_lut_fs2bids.md),
[`extract_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/extract_brain_slice.md),
[`get_3dstats()`](https://ekarinpongpipat.com/eepR/reference/get_3dstats.md),
[`plot_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/plot_brain_slice.md),
[`split_dseg2mask()`](https://ekarinpongpipat.com/eepR/reference/split_dseg2mask.md)

## Examples

``` r
brain <- array(1:125, dim = c(5, 5, 5))
plot_brain(brain, indices = c(3, 3, 3))
```
