classification_table_binary <- function(actual, predicted) {
  # actual <- df_class_table$y_actual[[8]]
  # predicted <- df_class_table$class[[8]]
  actual <- actual %>%
    unlist() %>%
    as.numeric() %>%
    as.matrix()
  predicted <- predicted %>%
    unlist() %>%
    as.numeric() %>%
    as.matrix()
  total <- nrow(actual)
  df <- tibble(actual, predicted) %>%
    mutate(response_type = case_when(
      actual == 1 & predicted == 1 ~ "true_positive",
      actual == 1 & predicted == 0 ~ "false_negative",
      actual == 0 & predicted == 1 ~ "false_positive",
      actual == 0 & predicted == 0 ~ "true_negative"
    )) %>%
    group_by(response_type) %>%
    summarize(count = n()) %>%
    ungroup()

  n_true <- df[str_detect(df$response_type, "true"),]$count %>% sum()
  n_false <- df[str_detect(df$response_type, "false"),]$count %>% sum()

  df <- df %>%
    add_row(., response_type = "true", count = n_true) %>%
    add_row(., response_type = "false", count = n_false) %>%
    mutate(rate = count/total)

  return(df)
}
