#' Extract Raw Variables from a Fitted Model
#'
#' @concept stats
#' @param model A fitted model object (lm, glm, lmer, lmerTest, etc.).
#' @param vars Optional character vector specifying variables to extract. 
#'   If NULL (default), returns all variables in the model frame.
#' @param include_response Logical. If TRUE (default), includes the response variable.
#' @param drop_na Logical. If TRUE (default), returns complete cases matching 
#'   the exact data frame used in model fitting.
#' @param unique Logical. If TRUE, returns unique rows/combinations. Default is FALSE.
#'
#' @return A data.frame containing raw variable values.
#' @examples
#' fit <- lm(salary ~ rank + yrs.since.phd, data = carData::Salaries)
#' extract_model_data(fit)
#' extract_model_data(fit, vars = c("rank", "yrs.since.phd"))
#' @export
extract_model_data <- function(model, 
                               vars = NULL, 
                               include_response = TRUE, 
                               drop_na = TRUE,
                               unique = FALSE) {
  
  # 1. Try to extract raw data from the model call
  data_obj <- NULL
  if (!is.null(model$call$data)) {
    data_obj <- tryCatch({
      eval(model$call$data, envir = environment(stats::formula(model)))
    }, error = function(e) NULL)
  }
  
  if (!is.null(data_obj) && is.data.frame(data_obj)) {
    # Get RHS (and LHS) raw variables
    terms_obj <- stats::terms(model)
    all_vars <- all.vars(terms_obj)
    
    if (!include_response) {
      resp_idx <- attr(terms_obj, "response")
      if (resp_idx > 0) {
        resp_var <- all.vars(terms_obj)[resp_idx]
        all_vars <- setdiff(all_vars, resp_var)
      }
    }
    
    valid_vars <- intersect(all_vars, colnames(data_obj))
    out_df <- data_obj[, valid_vars, drop = FALSE]
    
    # Filter/align rows to match the model frame (e.g. handles subset/drop_na)
    mf <- tryCatch(stats::model.frame(model), error = function(e) NULL)
    if (!is.null(mf)) {
      # Use rownames of the model frame to subset the data (handles na.action/subsetting)
      out_df <- out_df[rownames(mf), , drop = FALSE]
    }
    
  } else {
    # Fallback to model frame
    if (inherits(model, c("merMod", "lmerModLmerTest"))) {
      mf <- stats::model.frame(model)
    } else if (!is.null(stats::model.frame(model))) {
      mf <- stats::model.frame(model)
    } else {
      stop("Error: Unable to extract model frame from model.")
    }
    
    # Clean up scaled/transformed columns to recover raw variables
    col_names <- colnames(mf)
    clean_names <- col_names
    for (i in seq_along(col_names)) {
      col_name <- col_names[i]
      col <- mf[[col_name]]
      
      if (!is.null(attr(col, "scaled:center")) || !is.null(attr(col, "scaled:scale"))) {
        M <- attr(col, "scaled:center")
        S <- attr(col, "scaled:scale")
        if (is.null(M)) M <- 0 else M <- as.numeric(M)
        if (is.null(S)) S <- 1 else S <- as.numeric(S)
        col <- as.vector(col) * S + M
        mf[[col_name]] <- col
      }
      
      if (grepl("^scale\\(", col_name)) {
        clean_names[i] <- gsub("^scale\\(([^,)]+).*", "\\1", col_name)
      }
    }
    colnames(mf) <- clean_names
    
    out_df <- as.data.frame(mf)
  }
  
  if (drop_na) {
    out_df <- stats::na.omit(out_df)
  }
  
  # Filter variables
  if (!is.null(vars)) {
    missing_vars <- setdiff(vars, colnames(out_df))
    if (length(missing_vars) > 0) {
      stop(sprintf("Error: Variable(s) [%s] not found in model frame.", 
                   paste(missing_vars, collapse = ", ")))
    }
    out_df <- out_df[, vars, drop = FALSE]
  } else if (is.null(data_obj) && !include_response) {
    # If fallback was used and we do not want the response, drop it
    terms_obj <- stats::terms(model)
    resp_idx  <- attr(terms_obj, "response")
    if (resp_idx > 0) {
      out_df <- out_df[, -resp_idx, drop = FALSE]
    }
  }
  
  if (unique) {
    out_df <- base::unique(out_df)
  }
  
  # Extract scale parameters from the model frame
  scale_params <- list()
  mf <- tryCatch(stats::model.frame(model), error = function(e) NULL)
  if (!is.null(mf)) {
    for (col_name in colnames(mf)) {
      col <- mf[[col_name]]
      if (!is.null(attr(col, "scaled:center")) || !is.null(attr(col, "scaled:scale"))) {
        clean_name <- col_name
        if (grepl("^scale\\(", col_name)) {
          clean_name <- gsub("^scale\\(([^,)]+).*", "\\1", col_name)
        }
        scale_params[[clean_name]] <- list(
          center = attr(col, "scaled:center"),
          scale = attr(col, "scaled:scale")
        )
      }
    }
  }
  attr(out_df, "scale_params") <- scale_params
  
  rownames(out_df) <- NULL
  return(out_df)
}