# split_dseg2mask

split_dseg2mask

## Usage

``` r
split_dseg2mask(in_dseg, in_lut, out_prefix, overwrite = FALSE)
```

## Arguments

- in_dseg:

  path to discrete segmentation file

- in_lut:

  path to look up table .tsv file (bids format)

- out_prefix:

  output prefix of the mask files

- overwrite:

  flag to overwrite output files (default: FALSE)

## Value

Invisibly returns `NULL`; writes one mask NIfTI per LUT entry.

## See also

Other neuroimaging helpers:
[`compare_brains()`](https://ekarinpongpipat.com/eepR/reference/compare_brains.md),
[`convet_lut_fs2bids()`](https://ekarinpongpipat.com/eepR/reference/convet_lut_fs2bids.md),
[`extract_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/extract_brain_slice.md),
[`get_3dstats()`](https://ekarinpongpipat.com/eepR/reference/get_3dstats.md),
[`plot_brain()`](https://ekarinpongpipat.com/eepR/reference/plot_brain.md),
[`plot_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/plot_brain_slice.md)
