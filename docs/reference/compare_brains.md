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

## See also

Other neuroimaging helpers:
[`convet_lut_fs2bids()`](https://ekarinpongpipat.com/eepR/reference/convet_lut_fs2bids.md),
[`extract_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/extract_brain_slice.md),
[`get_3dstats()`](https://ekarinpongpipat.com/eepR/reference/get_3dstats.md),
[`plot_brain()`](https://ekarinpongpipat.com/eepR/reference/plot_brain.md),
[`plot_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/plot_brain_slice.md),
[`split_dseg2mask()`](https://ekarinpongpipat.com/eepR/reference/split_dseg2mask.md)
