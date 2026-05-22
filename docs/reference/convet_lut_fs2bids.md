# convet_lut_fs2bids

converts look up table (LUT) from freesurfer-format (No., Label Name, R,
G, B, A) to BIDS-format (index, name, color \[hex\], alpha)

## Usage

``` r
convet_lut_fs2bids(lut, out_path = NULL, overwrite = FALSE)
```

## Arguments

- lut:

  input path to look up table in freesurfer format

- out_path:

  output path to look up table in BIDS format (default: NULL)

- overwrite:

  flag to overwrite (default: 0)

## Value

A data.frame with BIDS-style LUT columns; optionally writes it to
`out_path`.

## See also

Other neuroimaging helpers:
[`compare_brains()`](https://ekarinpongpipat.com/eepR/reference/compare_brains.md),
[`extract_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/extract_brain_slice.md),
[`get_3dstats()`](https://ekarinpongpipat.com/eepR/reference/get_3dstats.md),
[`plot_brain()`](https://ekarinpongpipat.com/eepR/reference/plot_brain.md),
[`plot_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/plot_brain_slice.md),
[`split_dseg2mask()`](https://ekarinpongpipat.com/eepR/reference/split_dseg2mask.md)
