#' Create Simple Slopes Contrast Matrix (COPE Matrix)
#'
#' @md
#' @concept stats
#' @family contrast or COPE helpers
#' @param model A fitted model object (lm, glm, lmer, lmerTest, etc.).
#' @param x Character string specifying the focal predictor for the slope (e.g., "yrs.since.phd").
#' @param m Moderator specification:
#' 
#'   - NULL (default): No moderators. Returns overall focal predictor slopes.
#'   - Named list: list(yrs.service = "sd", rank = "real").
#'   - Special list with "all": list(all = c(continuous = "sd", factor = "real")).
#' @param covariates Value, summary function, or named list of specific values 
#'   to hold unspecified covariates constant. Default is 0.
#' @param digits Integer specifying the number of decimal places to round continuous 
#'   numeric variables in row names. Default is 4.
#'
#' @return A numeric matrix where rows correspond to simple slope contrasts at moderator values.
#' @examples
#' fit <- lm(salary ~ yrs.since.phd * yrs.service, data = carData::Salaries)
#' gen_contrast_ss(fit, x = "yrs.since.phd", m = list(yrs.service = "sd"))
#' @export
gen_contrast_ss <- function(model, x, m = NULL, covariates = 0, digits = 4) {
  
  raw_df <- extract_model_data(model, include_response = FALSE)
  raw_vars <- colnames(raw_df)
  
  # Get terms from the model frame to resolve potential transformed predictor names
  mf <- tryCatch(stats::model.frame(model), error = function(e) NULL)
  if (!is.null(mf)) {
    terms_obj <- stats::terms(model)
    resp_idx <- attr(terms_obj, "response")
    all_mf_cols <- colnames(mf)
    if (resp_idx > 0 && length(all_mf_cols) >= resp_idx) {
      predictor_terms <- all_mf_cols[-resp_idx]
    } else {
      predictor_terms <- all_mf_cols
    }
  } else {
    predictor_terms <- raw_vars
  }
  
  # Map focal predictor x to its raw variable name
  raw_x <- map_terms_to_data(model, x)
  
  # Map moderator names in m (if any) to their raw variable names
  if (!is.null(m) && is.list(m) && !is.null(names(m))) {
    m_names <- names(m)
    new_m_names <- sapply(m_names, function(mn) {
      if (mn == "all") {
        "all"
      } else {
        map_terms_to_data(model, mn)
      }
    })
    names(m) <- new_m_names
  }
  
  is_moderated_by_self <- !is.null(m) && (raw_x %in% names(m))
  
  if (is_moderated_by_self) {
    matched_term <- raw_x
  } else {
    if (x %in% raw_vars) {
      candidates <- predictor_terms[sapply(predictor_terms, function(t) grepl(x, t, fixed = TRUE))]
      if (length(candidates) > 0) {
        matched_term <- candidates[which.min(nchar(candidates))]
      } else {
        matched_term <- x
      }
    } else {
      matched_term <- x
    }
  }
  focal_name <- x
  
  all_preds <- raw_vars
  
  # 1. Validate and expand 'm' syntax safely
  if (!is.null(m)) {
    if (!is.list(m) || is.null(names(m)) || any(names(m) == "")) {
      stop("Error: 'm' must be a named list or NULL.")
    }
    
    # 1.1 Expand 'all' spec if present
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
      
      mod_vars <- setdiff(all_preds, raw_x)
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
  }
  
  # 1.5 Check if moderators in m actually interact with x in the model
  if (!is.null(m) && is.list(m) && length(m) > 0) {
    m_names <- names(m)
    inter_terms <- extract_interaction_terms(model, x)
    valid_moderators <- unique(names(inter_terms))
    
    for (mod in m_names) {
      if (!(mod %in% valid_moderators)) {
        if (mod != raw_x) {
          stop(sprintf("Error: Moderator '%s' does not interact with focal predictor '%s' in the model.",
                       mod, x))
        } else {
          stop(sprintf("Error: Focal predictor '%s' is specified as a moderator, but it does not interact with itself (no non-linear or polynomial terms for '%s' in the model).",
                       x, x))
        }
      }
    }
  }
  
  # 2. Build prediction data grid across moderator levels
  pred_grid <- gen_data_predict(model, x = raw_x, m = m, covariates = covariates)
  
  # 3. Extract fixed-effect parameter names
  if (inherits(model, c("merMod", "lmerModLmerTest"))) { 
    param_names <- names(lme4::fixef(model))
  } else if (!is.null(stats::coef(model))) {
    param_names <- names(stats::coef(model))
  } else {
    stop("Error: Cannot extract parameter estimates from model.")
  }
  
  is_x_factor <- !is.numeric(raw_df[[raw_x]])
  
  # 4. Compute design matrix X
  model_contrasts <- tryCatch({
    attr(stats::model.matrix(model), "contrasts")
  }, error = function(e) {
    NULL
  })
  if (is.null(model_contrasts)) {
    model_contrasts <- if (inherits(model, c("merMod", "lmerModLmerTest"))) {
      attr(model@frame, "contrasts")
    } else {
      model$contrasts
    }
  }
  
  terms_no_resp <- stats::delete.response(stats::terms(model))
  env <- environment(terms_no_resp)
  scale_params <- attr(pred_grid, "scale_params")
  
  if (!is.null(scale_params) && length(scale_params) > 0) {
    # Save original scale function if it existed
    had_scale <- "scale" %in% names(env)
    orig_scale <- if (had_scale) env$scale else NULL
    
    env$scale <- function(x, center = TRUE, scale = TRUE) {
      var_name <- deparse(substitute(x))
      var_name <- trimws(var_name)
      if (var_name %in% names(scale_params)) {
        params <- scale_params[[var_name]]
        tgt_center <- if (is.null(params$center)) FALSE else params$center
        tgt_scale  <- if (is.null(params$scale)) FALSE else params$scale
        base::scale(x, center = tgt_center, scale = tgt_scale)
      } else {
        base::scale(x, center = center, scale = scale)
      }
    }
    
    X <- stats::model.matrix(terms_no_resp, data = pred_grid, contrasts.arg = model_contrasts)
    
    if (had_scale) {
      env$scale <- orig_scale
    } else {
      rm("scale", envir = env)
    }
  } else {
    X <- stats::model.matrix(terms_no_resp, data = pred_grid, contrasts.arg = model_contrasts)
  }
  
  # Set columns in X corresponding to zero_factors to 0
  zero_factors <- attr(pred_grid, "zero_factors")
  if (!is.null(zero_factors) && length(zero_factors) > 0) {
    for (zf in zero_factors) {
      zf_escaped <- zf
      for (char in c(".", "\\", "+", "*", "?", "^", "$", "(", ")", "[", "]", "{", "}", "|", "-")) {
        zf_escaped <- gsub(char, paste0("\\", char), zf_escaped, fixed = TRUE)
      }
      pattern <- paste0("(^|:)", zf_escaped, "([0-9]+)?(:|$)")
      cols_to_zero <- grep(pattern, colnames(X))
      if (length(cols_to_zero) > 0) {
        X[, cols_to_zero] <- 0
      }
    }
  }
  
  if (is_x_factor) {
    # Categorical focal predictor contrast logic
    levels_x <- if (is.factor(raw_df[[raw_x]])) levels(raw_df[[raw_x]]) else unique(raw_df[[raw_x]])
    ref_level <- levels_x[1]
    comp_levels <- levels_x
    
    m_vars <- setdiff(colnames(pred_grid), raw_x)
    if (length(m_vars) > 0) {
      mod_grid <- unique(pred_grid[, m_vars, drop = FALSE])
    } else {
      mod_grid <- data.frame(row.names = 1)
    }
    
    slope_rows <- list()
    grid_rows <- list()
    
    for (r in 1:nrow(mod_grid)) {
      cond_ref <- pred_grid[[raw_x]] == ref_level
      if (length(m_vars) > 0) {
        for (mv in m_vars) {
          cond_ref <- cond_ref & (pred_grid[[mv]] == mod_grid[r, mv])
        }
      }
      ref_idx <- which(cond_ref)
      
      if (length(ref_idx) == 1) {
        for (L in comp_levels) {
          cond_comp <- pred_grid[[raw_x]] == L
          if (length(m_vars) > 0) {
            for (mv in m_vars) {
              cond_comp <- cond_comp & (pred_grid[[mv]] == mod_grid[r, mv])
            }
          }
          comp_idx <- which(cond_comp)
          
          if (length(comp_idx) == 1) {
            contrast_vec <- X[comp_idx, ] - X[ref_idx, ]
            slope_rows[[length(slope_rows) + 1]] <- contrast_vec
            grid_rows[[length(grid_rows) + 1]] <- pred_grid[comp_idx, , drop = FALSE]
          }
        }
      }
    }
    
    slope_mat <- do.call(rbind, slope_rows)
    slope_grid <- do.call(rbind, grid_rows)
    
  } else {
    # Continuous focal predictor derivative logic
    
    # Try analytical derivative first
    analytical_success <- FALSE
    terms_obj <- stats::terms(model)
    term_labels <- attr(terms_obj, "term.labels")
    factors <- attr(terms_obj, "factors")
    
    if (matched_term %in% term_labels && matched_term %in% rownames(factors)) {
      slope_mat <- matrix(0, nrow = nrow(X), ncol = ncol(X))
      colnames(slope_mat) <- colnames(X)
      assign_indices <- attr(X, "assign")
      
      for (j in 1:ncol(X)) {
        a <- assign_indices[j]
        if (a > 0) {
          label <- term_labels[a]
          if (factors[matched_term, label] > 0) {
            # This column involves the focal term
            col_name <- colnames(X)[j]
            parts <- strsplit(col_name, ":")[[1]]
            parts_rem <- setdiff(parts, matched_term)
            
            if (length(parts_rem) == 0) {
              slope_mat[, j] <- 1
            } else {
              match_found <- FALSE
              for (col in colnames(X)) {
                p <- strsplit(col, ":")[[1]]
                if (length(p) == length(parts_rem) && all(p %in% parts_rem) && all(parts_rem %in% p)) {
                  slope_mat[, j] <- X[, col]
                  match_found <- TRUE
                  break
                }
              }
              if (!match_found) {
                # Fallback: multiply individual columns
                vals <- rep(1, nrow(X))
                for (tp in parts_rem) {
                  if (tp %in% colnames(X)) {
                    vals <- vals * X[, tp]
                  } else {
                    matched <- grep(paste0("^", tp), colnames(X), value = TRUE)
                    if (length(matched) > 0) {
                      vals <- vals * X[, matched[1]]
                    }
                  }
                }
                slope_mat[, j] <- vals
              }
            }
          }
        }
      }
      slope_grid <- pred_grid
      analytical_success <- TRUE
    }
    
    if (!analytical_success) {
      # Fallback to Continuous focal predictor numeric derivative logic
      h <- 1e-5
      
      if (!is.null(scale_params) && length(scale_params) > 0) {
        had_scale <- "scale" %in% names(env)
        orig_scale <- if (had_scale) env$scale else NULL
        
        env$scale <- function(x, center = TRUE, scale = TRUE) {
          var_name <- deparse(substitute(x))
          var_name <- trimws(var_name)
          if (var_name %in% names(scale_params)) {
            params <- scale_params[[var_name]]
            tgt_center <- if (is.null(params$center)) FALSE else params$center
            tgt_scale  <- if (is.null(params$scale)) FALSE else params$scale
            base::scale(x, center = tgt_center, scale = tgt_scale)
          } else {
            base::scale(x, center = center, scale = scale)
          }
        }
        
        pred_grid_shift <- pred_grid
        pred_grid_shift[[raw_x]] <- pred_grid_shift[[raw_x]] + h
        X_shift <- stats::model.matrix(terms_no_resp, data = pred_grid_shift, contrasts.arg = model_contrasts)
        
        if (had_scale) {
          env$scale <- orig_scale
        } else {
          rm("scale", envir = env)
        }
      } else {
        pred_grid_shift <- pred_grid
        pred_grid_shift[[raw_x]] <- pred_grid_shift[[raw_x]] + h
        X_shift <- stats::model.matrix(terms_no_resp, data = pred_grid_shift, contrasts.arg = model_contrasts)
      }
      
      slope_mat <- (X_shift - X) / h
      slope_grid <- pred_grid
    }
  }
  
  # Align columns with model estimate names
  missing_cols <- setdiff(param_names, colnames(slope_mat))
  for (col in missing_cols) {
    slope_mat <- cbind(slope_mat, 0)
    colnames(slope_mat)[ncol(slope_mat)] <- col
  }
  slope_mat <- slope_mat[, param_names, drop = FALSE]
  
  # Reduce to unique contrast rows (rounding to handle floating point precision differences)
  unique_indices <- !duplicated(round(slope_mat, 5))
  slope_mat <- slope_mat[unique_indices, , drop = FALSE]
  unique_mods <- slope_grid[unique_indices, , drop = FALSE]
  
  # Build clean row names:
  m_vars_all <- colnames(slope_grid)
  varying_vars <- sapply(m_vars_all, function(v) length(base::unique(unique_mods[[v]])) > 1)
  m_vars_varying <- m_vars_all[varying_vars]
  
  # Always show any explicitly specified moderators, plus any that vary
  m_vars_to_show <- union(names(m), m_vars_varying)
  
  row_labels <- sapply(1:nrow(unique_mods), function(row_idx) {
    mod_vars_to_show <- m_vars_to_show
    if (is_x_factor) {
      mod_vars_to_show <- setdiff(mod_vars_to_show, raw_x)
    }
    
    focal_label <- if (is_x_factor) paste0(focal_name, as.character(unique_mods[row_idx, raw_x])) else focal_name
    
    if (length(mod_vars_to_show) > 0) {
      formatted_pairs <- sapply(mod_vars_to_show, function(nm) {
        val <- unique_mods[row_idx, nm]
        if (is.character(val) || is.factor(val)) {
          paste0(nm, "==\"", as.character(val), "\"")
        } else {
          formatted_val <- if (is.numeric(val)) {
            abs_val <- abs(val)
            if (val != 0 && (abs_val < 1e-4 || abs_val >= 1e+5)) {
              format(val, scientific = TRUE, digits = digits + 1)
            } else {
              as.character(round(val, digits))
            }
          } else {
            as.character(val)
          }
          formatted_val <- trimws(formatted_val)
          paste0(nm, "==", formatted_val)
        }
      })
      paste0(focal_label, "@", paste(formatted_pairs, collapse = "&"))
    } else {
      focal_label
    }
  })
  rownames(slope_mat) <- row_labels
  
  return(slope_mat)
}