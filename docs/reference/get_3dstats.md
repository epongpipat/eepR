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
