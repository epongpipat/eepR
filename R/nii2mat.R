#' @title nii2mat
#' Convert a NIfTI File into a 2D Time-by-Voxel Matrix
#'
#' @description
#' Reads a 3D or 4D NIfTI volume, applies a spatial 3D binary mask if available, and flattens
#' the in-mask data into a 2D matrix. The last dimension (Time or Diffusion direction)
#' is structured as rows, and the active spatial voxels are structured as columns.
#' Handles single-volume (3D) inputs by returning a 1-row matrix.
#' @concept neuroimaging
#' @param in_path Input path to 3D or 4D NIfTI file.
#' @param in_mask Input path to 3D binary mask NIfTI file. Optional. If NULL, all voxels are included.
#' @param out_path Optional input path to save the 2D matrix output (.rds format recommended).
#' @param overwrite Logical. If TRUE, overwrites an existing file at out_path. Default is FALSE.
#'
#' @return A 2D numeric matrix with dimensions \code{[T x V]}.
#' @export
#' @family conversions between NIfTI and 2D-matrix
#' @importFrom RNifti readNifti
#'
#' @examples
#' # mat <- nii2mat("sub-01_task-rest_bold.nii.gz", "sub-01_brain_mask.nii.gz")
nii2mat <- function(in_path, in_mask = NULL, out_path = NULL, overwrite = FALSE) {

  # 1. checks
  if (!file.exists(in_path)) {
    stop(sprintf("Input file does not exist: (%s)", in_path))
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

  # 2. Read data
  img <- readNifti(in_path)
  dims_raw <- dim(img)

  # Coerce single-volume (3D) to a 4D structure safely [X, Y, Z, 1]
  dims_4d <- if (length(dims_raw) == 3) c(dims_raw, 1) else dims_raw
  t_dim <- dims_4d[4]
  total_spatial_voxels <- prod(dims_4d[1:3])

  # 3. Handle Mask Evaluation Logic
  if (!is.null(in_mask)) {
    mask <- RNifti::readNifti(in_mask)
    dims_mask <- dim(mask)
    if (!all(dims_4d[1:3] == dims_mask[1:3])) {
      stop(sprintf("Spatial dimension mismatch! Image spatial size: [%s] vs Mask size: [%s]",
                   paste(dims_4d[1:3], collapse="x"), paste(dims_mask[1:3], collapse="x")))
    }
    logical_mask <- as.logical(mask > 0)
  } else {
    # If no mask is passed, generate an all-inclusive TRUE logical mask
    logical_mask <- rep(TRUE, total_spatial_voxels)
  }

  # 4. Matrix Structuring
  raw_data <- as.array(img)
  dim(raw_data) <- c(total_spatial_voxels, t_dim)

  # Extract inside mask with drop=FALSE protection, then transpose to [Time x Voxel]
  matrix_2d <- t(raw_data[logical_mask, , drop = FALSE])

  # 5. Output Management
  if (!is.null(out_path)) {
    message(sprintf("Saving matrix to: %s", out_path))
    saveRDS(matrix_2d, file = out_path, compress = TRUE)
    return(invisible(matrix_2d))
  }

  return(matrix_2d)
}
