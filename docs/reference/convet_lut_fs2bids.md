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
