# mat2nii Reconstruct a NIfTI File from a 2D Time-by-Voxel Matrix

Takes a 2D matrix where rows represent timepoints (or directions) and
columns represent voxels, and projects it back into 3D/4D NIfTI space.
Uses a required reference image to inherit spatial dimensions and
orientation headers. If an optional binary mask is provided, voxels are
mapped back to their specific coordinates.

## Usage

``` r
mat2nii(
  matrix_2d,
  in_reference,
  in_mask = NULL,
  out_path = NULL,
  overwrite = FALSE
)
```

## Arguments

- matrix_2d:

  A 2D numeric matrix with dimensions `[T x V]`.

- in_reference:

  Path to a 3D NIfTI file used as the master spatial geometry and
  orientation template (e.g., a T1w or a reference functional volume).
  Required.

- in_mask:

  Optional path to a 3D binary mask NIfTI file. If provided, matrix
  columns are mapped back to active mask coordinates. If NULL, columns
  are mapped to the full volume.

- out_path:

  Optional input path to save the reconstructed NIfTI file (.nii or
  .nii.gz).

- overwrite:

  Logical. If TRUE, overwrites an existing file at out_path. Default is
  FALSE.

## Value

An `internalimage` object from the `RNifti` package, invisibly returned
if written to disk, or directly returned if `out_path` is `NULL`.

## See also

Other conversions between NIfTI and 2D-matrix:
[`nii2mat()`](https://ekarinpongpipat.com/eepR/reference/nii2mat.md)

## Examples

``` r
# Example 1: Reconstructing a masked time-series using a T1 reference and a brain mask
# nii_obj <- mat2nii(bold_matrix, in_reference = "T1w.nii.gz", in_mask = "brain_mask.nii.gz")

# Example 2: Reconstructing an unmasked, full-volume matrix using a T1 reference
# nii_obj <- mat2nii(full_matrix, in_reference = "T1w.nii.gz", in_mask = NULL)
```
