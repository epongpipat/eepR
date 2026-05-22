#' @title mat2nii
#' Reconstruct a NIfTI File from a 2D Time-by-Voxel Matrix
#'
#' @description
#' Takes a 2D matrix where rows represent timepoints (or directions) and columns
#' represent voxels, and projects it back into 3D/4D NIfTI space. Uses a required
#' reference image to inherit spatial dimensions and orientation headers. If an optional
#' binary mask is provided, voxels are mapped back to their specific coordinates.
#' @concept neuroimaging
#' @param matrix_2d A 2D numeric matrix with dimensions \code{[T x V]}.
#' @param in_reference Path to a 3D NIfTI file used as the master spatial geometry
#'        and orientation template (e.g., a T1w or a reference functional volume). Required.
#' @param in_mask Optional path to a 3D binary mask NIfTI file. If provided, matrix columns
#'        are mapped back to active mask coordinates. If NULL, columns are mapped to the full volume.
#' @param out_path Optional input path to save the reconstructed NIfTI file (.nii or .nii.gz).
#' @param overwrite Logical. If TRUE, overwrites an existing file at out_path. Default is FALSE.
#'
#' @return An \code{internalimage} object from the \code{RNifti} package, invisibly returned
#'         if written to disk, or directly returned if \code{out_path} is \code{NULL}.
#' @export
#' @family conversions between NIfTI and 2D-matrix
#' @importFrom RNifti readNifti writeNifti asNifti
#'
#' @examples
#' # Example 1: Reconstructing a masked time-series using a T1 reference and a brain mask
#' # nii_obj <- mat2nii(bold_matrix, in_reference = "T1w.nii.gz", in_mask = "brain_mask.nii.gz")
#'
#' # Example 2: Reconstructing an unmasked, full-volume matrix using a T1 reference
#' # nii_obj <- mat2nii(full_matrix, in_reference = "T1w.nii.gz", in_mask = NULL)
mat2nii <- function(matrix_2d, in_reference, in_mask = NULL, out_path = NULL, overwrite = FALSE) {

  # 1. Parameter and File Validation
  if (!is.matrix(matrix_2d)) {
    stop("Error: 'matrix_2d' must be a standard 2D R matrix.")
  }

  if (missing(in_reference) || is.null(in_reference)) {
    stop("Error: 'in_reference' is required to define spatial dimensions and orientation metrics.")
  }

  if (!file.exists(in_reference)) {
    stop(sprintf("Reference template file does not exist: (%s)", in_reference))
  }

  if (!is.null(in_mask)) {
    if (!file.exists(in_mask)) {
      stop(sprintf("Mask file does not exist: (%s)", in_mask))
    }
  }

  if (!is.null(out_path)) {
    if (file.exists(out_path) && !overwrite) {
      stop(sprintf("Output file exists and overwrite is set to FALSE: (%s)", out_path))
    }
  }

  t_dim <- nrow(matrix_2d)
  matrix_cols <- ncol(matrix_2d)

  # 2. Extract Master Geometry Settings
  ref_nifti <- RNifti::readNifti(in_reference)
  target_spatial_dims <- dim(ref_nifti)[1:3]
  total_spatial_voxels <- prod(target_spatial_dims)

  # 3. Spatial Array Projection Logic
  if (!is.null(in_mask)) {
    message("Applying spatial mask coordinates for reconstruction...")
    mask_nifti <- RNifti::readNifti(in_mask)

    if (!all(dim(mask_nifti)[1:3] == target_spatial_dims)) {
      stop("Spatial dimension mismatch between 'in_reference' and 'in_mask'.")
    }

    logical_mask <- as.logical(mask_nifti > 0)
    in_mask_count <- sum(logical_mask)

    if (matrix_cols != in_mask_count) {
      stop(sprintf("Dimension Mismatch! Matrix has %d columns, but the provided mask has %d active voxels.",
                   matrix_cols, in_mask_count))
    }

    # Allocate full spatial grid and map active entries
    full_spatial_grid <- matrix(0, nrow = total_spatial_voxels, ncol = t_dim)
    full_spatial_grid[logical_mask, ] <- t(matrix_2d)

  } else {
    message("No mask specified. Mapping matrix columns directly to full volume space...")

    if (matrix_cols != total_spatial_voxels) {
      stop(sprintf("Dimension Mismatch! Matrix has %d columns, but target reference requires %d voxels (%s).",
                   matrix_cols, total_spatial_voxels, paste(target_spatial_dims, collapse="x")))
    }

    full_spatial_grid <- t(matrix_2d)
  }

  # 4. Shape back to native NIfTI dimensions
  if (t_dim == 1) {
    dim(full_spatial_grid) <- target_spatial_dims
  } else {
    dim(full_spatial_grid) <- c(target_spatial_dims, t_dim)
  }

  # 5. Build NIfTI Object inheriting complete header data from master reference
  output_nifti <- RNifti::asNifti(full_spatial_grid, reference = ref_nifti)

  # 6. Output Management
  if (!is.null(out_path)) {
    message(sprintf("Writing NIfTI image out to: %s", out_path))
    RNifti::writeNifti(output_nifti, out_path)
    return(invisible(output_nifti))
  }

  return(output_nifti)
}
