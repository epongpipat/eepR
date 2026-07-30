#' Map Model Terms to Raw Data Variables
#' 
#' @md
#' @concept stats
#' @param model A fitted model object (lm, glm, lmer, lmerTest, etc.).
#' @param terms Character vector of one or more term/variable names.
#' @return A character vector of corresponding raw variable names from the model frame.
#' @export
map_terms_to_data <- function(model, terms) {
  raw_df <- extract_model_data(model, include_response = FALSE)
  raw_vars <- colnames(raw_df)
  
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
  
  mapped <- sapply(terms, function(name) {
    if (name %in% raw_vars) {
      return(name)
    }
    
    # Check if the name is a specific contrast column/term in the model
    param_names <- tryCatch({
      if (inherits(model, c("merMod", "lmerModLmerTest"))) {
        names(lme4::fixef(model))
      } else {
        names(stats::coef(model))
      }
    }, error = function(e) NULL)
    
    if (!is.null(param_names) && name %in% param_names) {
      raw_candidates <- raw_vars[sapply(raw_vars, function(v) {
        grepl(paste0("^", gsub(".", "\\.", v, fixed = TRUE)), name)
      })]
      if (length(raw_candidates) > 0) {
        return(raw_candidates[which.max(nchar(raw_candidates))])
      }
    }
    
    if (name %in% predictor_terms) {
      parsed_vars <- tryCatch({
        all.vars(parse(text = name))
      }, error = function(e) character(0))
      
      raw_candidates <- intersect(parsed_vars, raw_vars)
      if (length(raw_candidates) == 0) {
        raw_candidates <- raw_vars[sapply(raw_vars, function(v) grepl(v, name, fixed = TRUE))]
      }
      
      if (length(raw_candidates) > 0) {
        return(raw_candidates[which.max(nchar(raw_candidates))])
      }
    }
    
    stop(sprintf("Error: Variable(s) [%s] not found in model frame.", name))
  })
  
  return(unname(mapped))
}
