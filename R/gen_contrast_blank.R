#' Create a Blank COPE / Contrast Matrix from a Model or Predictor Names
#'
#' @concept stats
#' @family contrast or COPE helpers
#' @param model A fitted model object (lm, glm, lmer, lmerTest, etc.) OR a character vector of parameter names.
#' @param contrasts Number of rows (integer), character vector of row names,
#'   or NULL/FALSE for no row names. Default is 1 (numeric, so no row names).
#'
#' @return A numeric matrix filled with zeros matching the model's fixed-effect parameters.
#' @examples
#' fit <- lm(salary ~ rank + yrs.since.phd, data = carData::Salaries)
#' gen_contrast_blank(fit, contrasts = 2)
#' gen_contrast_blank(fit, contrasts = c("ContrastA", "ContrastB"))
#' @export
gen_contrast_blank <- function(model, contrasts = 1) {

  # 1. Extract fixed-effect parameter names
  if (is.character(model)) {
    param_names <- model
  } else if (inherits(model, c("merMod", "lmerModLmerTest"))) {
    # Works for both lme4 and lmerTest objects
    param_names <- names(lme4::fixef(model))
  } else if (!is.null(stats::coef(model))) {
    # Standard models (lm, glm, nls, etc.)
    param_names <- names(stats::coef(model))
  } else {
    stop("Error: 'model' must be a fitted model object (lm, glm, lmer, lmerTest, etc.) or a character vector of parameter names.")
  }

  # 2. Parse contrasts argument
  contrast_names <- NULL

  if (is.null(contrasts) || isFALSE(contrasts)) {
    n_rows <- 1
  } else if (is.numeric(contrasts) && length(contrasts) == 1) {
    if (contrasts < 1 || contrasts %% 1 != 0) {
      stop("Error: If 'contrasts' is numeric, it must be a positive integer.")
    }
    n_rows <- contrasts
    # Row names automatically left as NULL for numeric counts
  } else if (is.character(contrasts)) {
    n_rows <- length(contrasts)
    contrast_names <- contrasts
  } else {
    stop("Error: 'contrasts' must be a positive integer, a character vector of names, or NULL/FALSE.")
  }

  # 3. Build zero matrix
  n_cols <- length(param_names)
  cope_mat <- matrix(0, nrow = n_rows, ncol = n_cols)

  # 4. Assign dimnames
  colnames(cope_mat) <- param_names
  if (!is.null(contrast_names)) {
    rownames(cope_mat) <- contrast_names
  }

  return(cope_mat)
}
