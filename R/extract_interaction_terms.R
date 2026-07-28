#' Extract Interaction Terms Involving a Predictor
#' 
#' @md
#' @concept stats
#' @param model A fitted model object.
#' @param predictor Character string of the focal predictor name.
#' @return A named character vector of term labels representing interaction/polynomial 
#'   terms involving the predictor. The names correspond to the moderator variables.
#' @export
extract_interaction_terms <- function(model, predictor) {
  raw_pred <- map_terms_to_data(model, predictor)
  
  # Get actual raw variables in the dataset
  raw_df <- extract_model_data(model, include_response = FALSE)
  raw_vars <- colnames(raw_df)
  
  terms_obj <- stats::terms(model)
  term_labels <- attr(terms_obj, "term.labels")
  
  interact_terms <- character(0)
  
  for (label in term_labels) {
    vars_all <- all.vars(parse(text = label))
    # Filter to only keep variables present in the dataset
    vars <- intersect(vars_all, raw_vars)
    
    if (raw_pred %in% vars) {
      other_vars <- setdiff(vars, raw_pred)
      if (length(other_vars) > 0) {
        # Interaction with other variables
        for (ov in other_vars) {
          interact_terms <- c(interact_terms, setNames(label, ov))
        }
      } else {
        # Check for self-interaction / polynomial / non-linear terms
        is_self_interact <- grepl("poly\\(|I\\(|\\^|log\\(|sqrt\\(|\\*", label)
        if (is_self_interact) {
          interact_terms <- c(interact_terms, setNames(label, raw_pred))
        }
      }
    }
  }
  
  return(interact_terms)
}
