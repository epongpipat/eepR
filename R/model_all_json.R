model_all_json_list <- function(x_path, y_path, model_path, out_path) {
  n_pad <- 3
  x_path <- "/Volumes/eep/"
  model_path <- "/Volumes/eep/kaggle/trends-assessment-prediction/models_list.json"
  stop_if_dne(x_path)
  x <- read.csv(x_path)

  stop_if_dne(y_path)
  y <- read.csv(y_path)

  stop_if_dne(model_path)
  models <- read_json(model_path)

  for (i in 1:length(models)) {
    models[[i]]$args$x <- x
    models[[i]]$args$y <- y
    fun_name <- glue("{models[[i]]$pkg}::{models[[i]]$fun}")
    model <- do.call(eval(parse(text = fun_name)), models[[i]]$args)
    save(model, out_path)

  }

}
