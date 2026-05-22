# get_3dstats

obtain summary metrics of data file from discrete segmentation. summary
metrics include non-zero voxels, min, max, median, mean

## Usage

``` r
get_3dstats(in_data, in_dseg, in_lut = NULL, out_path, overwrite = FALSE)
```

## Arguments

- in_data:

  input path to data nifti file

- in_dseg:

  input path to discrete segmentation nifti file

- in_lut:

  input path to look up table

- out_path:

  output path to save stats tsv file

- overwrite:

  flag to overwrite (default: 0)

## Value

A data.frame of regional 3D summary statistics; optionally writes it to
`out_path`.

## See also

Other neuroimaging helpers:
[`compare_brains()`](https://ekarinpongpipat.com/eepR/reference/compare_brains.md),
[`convet_lut_fs2bids()`](https://ekarinpongpipat.com/eepR/reference/convet_lut_fs2bids.md),
[`extract_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/extract_brain_slice.md),
[`plot_brain()`](https://ekarinpongpipat.com/eepR/reference/plot_brain.md),
[`plot_brain_slice()`](https://ekarinpongpipat.com/eepR/reference/plot_brain_slice.md),
[`split_dseg2mask()`](https://ekarinpongpipat.com/eepR/reference/split_dseg2mask.md)
