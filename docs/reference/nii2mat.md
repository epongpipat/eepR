# nii2mat Convert a NIfTI File into a 2D Time-by-Voxel Matrix

Reads a 3D or 4D NIfTI volume, applies a spatial 3D binary mask if
available, and flattens the in-mask data into a 2D matrix. The last
dimension (Time or Diffusion direction) is structured as rows, and the
active spatial voxels are structured as columns. Handles single-volume
(3D) inputs by returning a 1-row matrix.

## Usage

``` r
nii2mat(in_path, in_mask = NULL, out_path = NULL, overwrite = FALSE)
```

## Arguments

- in_path:

  Input path to 3D or 4D NIfTI file.

- in_mask:

  Input path to 3D binary mask NIfTI file. Optional. If NULL, all voxels
  are included.

- out_path:

  Optional input path to save the 2D matrix output (.rds format
  recommended).

- overwrite:

  Logical. If TRUE, overwrites an existing file at out_path. Default is
  FALSE.

## Value

A 2D numeric matrix with dimensions `[T x V]`.

## See also

Other conversions between NIfTI and 2D-matrix:
[`mat2nii()`](https://ekarinpongpipat.com/eepR/reference/mat2nii.md)

## Examples
