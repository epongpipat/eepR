#' @title compare_all_models
#'
#' @param model_list list of models
#'
#' @return comparison of models
#' @export
#'
#' @examples
#' data <- carData::Salaries
#' model_1 <- lm(salary ~ yrs.since.phd, data)
#' model_2 <- lm(salary ~ yrs.since.phd * rank, data)
#' model_3 <- lm(salary ~ yrs.since.phd * rank * sex, data)
#' compare_all_models(list(model_1, model_2, model_3))
compare_all_models <- function(model_list) {
  n_models <- length(model_list)
  if (n_models == 1) {
    stop("need more than 1 model for model comparison")
  } else if (n_models == 2) {
    compare_models(model_list[[1]], model_list[[2]])
  } else {
    df <- NULL
    for (i in 1:n_models) {
      if (i + 1 > n_models) {
        break()
      }

      temp_df <- compare_models(model_list[[i]], model_list[[i+1]])
      if (i > 1) {
        temp_df$model[2] <- i+1
        temp_df <- temp_df[2,]
      }
      df <- rbind(df, temp_df)
    }
    return(df)
  }
}
