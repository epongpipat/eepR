# convet_lut_fs2bids

converts look up table (LUT) from freesurfer-format (No., Label Name, R,
G, B, A) to BIDS-format (index, name, color \[hex\], alpha)

## Usage

``` r
convet_lut_fs2bids(in_path, out_path, overwrite)
```

## Arguments

- in_path:

  input path to look up table in freesurfer format

- out_path:

  output path to look up table in BIDS format

- overwrite:

  flag to overwrite (default: 0)
