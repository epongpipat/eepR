#' Create Data Grid for Model Predictions
#'
#' @md
#' @concept stats
#' @param model A fitted model object (lm, glm, lmer, lmerTest, etc.).
#' @param x Character vector specifying focal predictor(s) (e.g., "yrs.since.phd").
#' @param m Moderator specifications:
#' 
#'   - NULL (default): No moderators.
#'   - Named list: list(yrs.service = "sd", rank = "real").
#'   - Special list with "all": list(all = c(continuous = "sd", factor = "real")).
#' @param covariates Value, summary function, or named list of specific values 
#'   to hold unspecified covariates constant. Default is 0.

#' @return A data.frame grid ready for stats::predict().
#' @examples
#' fit <- lm(salary ~ yrs.since.phd * yrs.service, data = carData::Salaries)
#' gen_data_predict(fit, x = "yrs.since.phd", m = list(yrs.service = "sd"))
#' gen_data_predict(fit, x = "yrs.since.phd", m = list(yrs.service = c(10, 20)))
#' @export
gen_data_predict <- function(model, x, m = NULL, covariates = 0) {
  
  # 0. Parse 'covariates' syntax safely
  if (!is.list(covariates) && !is.null(names(covariates)) && any(names(covariates) != "")) {
    covariates <- as.list(covariates)
  }
  
  raw_df <- extract_model_data(model, include_response = FALSE)
  all_preds <- colnames(raw_df)
  
  # 0.5 Check if focal predictor(s) in x are in the model
  invalid_x <- setdiff(x, all_preds)
  if (length(invalid_x) > 0) {
    stop(sprintf("Error: Focal predictor(s) [%s] not found in the model.",
                 paste(invalid_x, collapse = ", ")))
  }
  
  grid_list <- list()
  
  # 1. Handle Focal Predictor(s)
  for (f_var in x) {
    val <- raw_df[[f_var]]
    grid_list[[f_var]] <- if (is.factor(val)) {
      levels(val)
    } else if (is.numeric(val)) {
      unique(val)
    } else {
      unique(val)
    }
  }
  
  # 2. Handle Moderators (`m`)
  if (!is.null(m)) {
    if (!is.list(m) || is.null(names(m)) || any(names(m) == "")) {
      stop("Error: 'm' must be a named list or NULL.")
    }
    
    # 2.1 Expand 'all' spec if present
    if ("all" %in% names(m)) {
      all_spec <- m[["all"]]
      if (is.null(names(all_spec))) {
        stop("Error: 'all' specification must be a named vector or list (e.g., c(continuous = 'sd', factor = 'real')).")
      }
      
      cat_key <- intersect(names(all_spec), c("factor", "categorical"))[1]
      if (!"continuous" %in% names(all_spec) || is.na(cat_key)) {
        stop("Error: 'all' specification must contain 'continuous' and 'factor' (or 'categorical') keys.")
      }
      
      cont_val <- all_spec[["continuous"]]
      cat_val <- all_spec[[cat_key]]
      
      mod_vars <- setdiff(all_preds, x)
      for (mv in mod_vars) {
        val <- raw_df[[mv]]
        if (is.numeric(val)) {
          m[[mv]] <- cont_val
        } else {
          m[[mv]] <- cat_val
        }
      }
      m[["all"]] <- NULL
    }
    
    # 2.2 Process each moderator variable in the list
    for (mod_name in names(m)) {
      val_spec <- m[[mod_name]]
      if (is.character(val_spec) && length(val_spec) == 1 && val_spec == "sd") {
        val <- raw_df[[mod_name]]
        if (!is.numeric(val)) {
          valid_opts <- if (is.factor(val)) levels(val) else unique(val)
          stop(sprintf("Error: 'sd' specification is only valid for numeric variables. Variable '%s' is a %s. For categorical variables, please specify 'real' or a character vector of specific levels. Valid levels are: [%s].",
                       mod_name, class(val)[1], paste(valid_opts, collapse = ", ")))
        }
        m_mean <- mean(val, na.rm = TRUE)
        m_sd   <- sd(val, na.rm = TRUE)
        grid_list[[mod_name]] <- c("-1SD" = m_mean - m_sd, "Mean" = m_mean, "+1SD" = m_mean + m_sd)
      } else if (is.character(val_spec) && length(val_spec) == 1 && val_spec == "real") {
        val <- raw_df[[mod_name]]
        grid_list[[mod_name]] <- if (is.factor(val)) levels(val) else unique(val)
      } else {
        orig_val <- raw_df[[mod_name]]
        if (is.factor(orig_val)) {
          invalid_levels <- setdiff(val_spec, levels(orig_val))
          if (length(invalid_levels) > 0) {
            stop(sprintf("Error: Invalid level(s) [%s] specified for factor variable '%s'. Valid levels are: [%s].",
                         paste(invalid_levels, collapse = ", "),
                         mod_name,
                         paste(levels(orig_val), collapse = ", ")))
          }
        } else if (is.character(orig_val)) {
          invalid_levels <- setdiff(val_spec, unique(orig_val))
          if (length(invalid_levels) > 0) {
            stop(sprintf("Error: Invalid value(s) [%s] specified for character variable '%s'. Valid values are: [%s].",
                         paste(invalid_levels, collapse = ", "),
                         mod_name,
                         paste(unique(orig_val), collapse = ", ")))
          }
        }
        grid_list[[mod_name]] <- val_spec
      }
    }
  }
  
  # 3. Hold remaining unspecified covariates constant using `covariates`
  remaining_vars <- setdiff(all_preds, names(grid_list))
  
  for (r_var in remaining_vars) {
    val <- raw_df[[r_var]]
    
    if (is.list(covariates) && r_var %in% names(covariates)) {
      val_spec <- covariates[[r_var]]
      if (is.factor(val)) {
        invalid_levels <- setdiff(val_spec, levels(val))
        if (length(invalid_levels) > 0) {
          stop(sprintf("Error: Invalid level(s) [%s] specified for factor variable '%s'. Valid levels are: [%s].",
                       paste(invalid_levels, collapse = ", "),
                       r_var,
                       paste(levels(val), collapse = ", ")))
        }
      } else if (is.character(val)) {
        invalid_levels <- setdiff(val_spec, unique(val))
        if (length(invalid_levels) > 0) {
          stop(sprintf("Error: Invalid value(s) [%s] specified for character variable '%s'. Valid values are: [%s].",
                       paste(invalid_levels, collapse = ", "),
                       r_var,
                       paste(unique(val), collapse = ", ")))
        }
      }
      grid_list[[r_var]] <- val_spec
    } else if (is.numeric(val)) {
      if (is.function(covariates)) {
        grid_list[[r_var]] <- covariates(val, na.rm = TRUE)
      } else if (is.numeric(covariates)) {
        grid_list[[r_var]] <- covariates
      } else {
        grid_list[[r_var]] <- 0
      }
    } else {
      grid_list[[r_var]] <- levels(factor(val))[1] # Default reference factor level
    }
  }
  
  pred_grid <- expand.grid(grid_list, stringsAsFactors = FALSE)
  
  # 4. Preserve factor levels to prevent contrasts compilation errors in model.matrix
  for (var_name in colnames(pred_grid)) {
    orig_val <- raw_df[[var_name]]
    if (is.factor(orig_val)) {
      pred_grid[[var_name]] <- factor(pred_grid[[var_name]], levels = levels(orig_val))
    } else if (is.character(orig_val)) {
      pred_grid[[var_name]] <- factor(pred_grid[[var_name]], levels = unique(orig_val))
    }
  }
  
  attr(pred_grid, "scale_params") <- attr(raw_df, "scale_params")
  rownames(pred_grid) <- NULL
  return(pred_grid)
}