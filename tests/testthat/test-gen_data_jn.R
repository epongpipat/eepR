test_that("gen_data_jn works for continuous focal variables and handles moderators and significance", {
  data <- carData::Salaries

  # --- Test Case 1: Continuous focal with continuous moderator ---
  fit1 <- lm(salary ~ yrs.since.phd * yrs.service, data = data)
  
  # Specify moderator values directly
  m_vals <- c(5, 15, 25)
  contrast_mat1 <- gen_contrast_ss(fit1, x = "yrs.since.phd", m = list(yrs.service = m_vals))
  glht_obj1 <- multcomp::glht(fit1, linfct = contrast_mat1)
  tidy_res1 <- tidy_es(glht_obj1, ci = 0.95)
  
  res1 <- gen_data_jn(tidy_res1, ci = 0.95)
  
  # Verify data frame structure and S3 class
  expect_s3_class(res1, "jn_df")
  expect_s3_class(res1, "data.frame")
  
  expected_cols <- c("x", "predicted", "std.error", "df", "statistic", "p.value", "conf.low", "conf.high", "sig")
  expect_true(all(expected_cols %in% colnames(res1)))
  
  # Verify values: the primary moderator column should be renamed to 'x'
  expect_equal(res1$x, m_vals)
  
  # Verify significance matching p-value (ci = 0.95, alpha = 0.05)
  expect_equal(res1$sig, res1$p.value < 0.05)

  # Check with different CI
  tidy_res1_90 <- tidy_es(glht_obj1, ci = 0.90)
  res1_90 <- gen_data_jn(tidy_res1_90, ci = 0.90)
  expect_equal(res1_90$sig, res1_90$p.value < 0.10)
  
  # Test S3 plotting functionality
  p1 <- plot(res1)
  expect_s3_class(p1, "ggplot")
  
  # --- Test Case 2: Error handling ---
  # Error if data is missing or not a data.frame
  expect_error(gen_data_jn())
  expect_error(gen_data_jn("not a dataframe"))
  
  # Error if rh column is missing
  expect_error(gen_data_jn(data.frame(a = 1)))
  
  # Error if rh column does not contain @ (no moderators)
  tidy_res_no_mod <- tidy_es(fit1) # lm tidy_es, rh is parameter names
  expect_error(gen_data_jn(tidy_res_no_mod))
  
  # Error if focal predictor x is categorical (has multiple unique values of x)
  fit_cat <- lm(salary ~ rank * yrs.service, data = data)
  c_cat <- gen_contrast_ss(fit_cat, x = "rank", m = list(yrs.service = c(10, 20)))
  c_cat <- c_cat[!grepl("rankAsstProf", rownames(c_cat)), ]
  tidy_res_cat <- tidy_es(multcomp::glht(fit_cat, c_cat))
  expect_error(gen_data_jn(tidy_res_cat))
})

test_that("gen_data_jn works with lmerTest S4 models and supports plotting", {
  skip_if_not_installed("lmerTest")
  skip_if_not_installed("lme4")
  
  data <- carData::Salaries
  set.seed(42)
  data$subject <- factor(rep(1:10, length.out = nrow(data)))
  
  fit_lmer <- lmerTest::lmer(salary ~ scale(yrs.since.phd, scale = F) * yrs.service + (1 | subject), data = data)
  
  contrast_mat_lmer <- gen_contrast_ss(fit_lmer, x = "yrs.since.phd", m = list(yrs.service = c(10, 20)))
  glht_obj_lmer <- multcomp::glht(fit_lmer, linfct = contrast_mat_lmer)
  tidy_res_lmer <- tidy_es(glht_obj_lmer)
  
  res_lmer <- gen_data_jn(tidy_res_lmer)
  
  expect_s3_class(res_lmer, "jn_df")
  expect_equal(res_lmer$x, c(10, 20))
  expect_true(all(c("predicted", "std.error", "df", "statistic", "p.value", "conf.low", "conf.high", "sig") %in% colnames(res_lmer)))
  
  p_lmer <- plot(res_lmer)
  expect_s3_class(p_lmer, "ggplot")
  
  # Test with explicit transformed term name
  contrast_mat_lmer_tr <- gen_contrast_ss(fit_lmer, x = "scale(yrs.since.phd, scale = F)", m = list(yrs.service = c(10, 20)))
  glht_obj_lmer_tr <- multcomp::glht(fit_lmer, linfct = contrast_mat_lmer_tr)
  tidy_res_lmer_tr <- tidy_es(glht_obj_lmer_tr)
  
  res_lmer_transformed <- gen_data_jn(tidy_res_lmer_tr)
  expect_equal(res_lmer_transformed$x, c(10, 20))
  
  p_lmer_tr <- plot(res_lmer_transformed)
  expect_s3_class(p_lmer_tr, "ggplot")
  
  # Test the specific polynomial / multi-moderator model that previously threw factor scaling errors
  fit_poly <- lm(salary ~ scale(yrs.since.phd, scale = F) * scale(yrs.service, scale = F) + I(scale(yrs.since.phd, scale = F)^2) * scale(yrs.service, scale = F), data = carData::Salaries)
  c_poly <- gen_contrast_ss(fit_poly, x = "yrs.since.phd", m = list(yrs.since.phd = "real", yrs.service = "sd"))
  df_es_poly <- tidy_es(multcomp::glht(fit_poly, c_poly), mcc = 'none')
  
  res_poly <- gen_data_jn(df_es_poly)
  expect_s3_class(res_poly, "jn_df")
  expect_s3_class(plot(res_poly), "ggplot")
  expect_s3_class(plot(res_poly, scales = "free_y"), "ggplot")
  expect_s3_class(plot(res_poly, nrow = 2, ncol = 2), "ggplot")
  expect_s3_class(plot(res_poly, font_family = "Arial"), "ggplot")
  expect_s3_class(plot(res_poly, font_family = "Helvetica"), "ggplot")
  expect_s3_class(plot(res_poly, legend.position = "bottom"), "ggplot")
  expect_s3_class(plot(res_poly, legend.position = "right"), "ggplot")
  expect_error(plot(res_poly, legend.position = "top"))
  expect_s3_class(plot(res_poly, slope.symbol = "b"), "ggplot")
  expect_s3_class(plot(res_poly, slope.symbol = "beta"), "ggplot")
  expect_s3_class(plot(res_poly, slope.symbol = "bhat"), "ggplot")
  expect_s3_class(plot(res_poly, slope.symbol = "betahat"), "ggplot")
  expect_error(plot(res_poly, slope.symbol = "invalid"))
  expect_s3_class(plot(res_poly, font_size_max = 6), "ggplot")
  expect_s3_class(plot(res_poly, font_size_max = 8), "ggplot")
  expect_s3_class(plot(res_poly, x_digits = 2, y_digits = 1), "ggplot")
  expect_s3_class(plot(res_poly, x_scientific = FALSE, y_scientific = FALSE), "ggplot")
})

test_that("lmer sum contrasts preserve all factor levels in gen_contrast_ss and gen_data_jn", {
  skip_if_not_installed("lme4")
  library(lme4)
  
  set.seed(456)
  n_test <- 200
  df_test <- data.frame(
    y = rnorm(n_test),
    Age = rnorm(n_test, 40, 10),
    Time = sample(0:2, n_test, replace = TRUE),
    Difficulty = factor(sample(c("Easy", "Hard"), n_test, replace = TRUE)),
    Network = factor(sample(c("A", "B", "C", "D"), n_test, replace = TRUE), levels = c("A", "B", "C", "D")),
    Subject = factor(sample(1:10, n_test, replace = TRUE))
  )
  contrasts(df_test$Network) <- contr.sum(4)
  
  fit_test <- lmer(y ~ Age * Time * Difficulty * Network + (1 | Subject), data = df_test)
  
  c_test <- gen_contrast_ss(fit_test, 'Age', m = list('Time' = 0:1, 'Difficulty' = 'real', 'Network' = 'real'))
  df_coef_test <- tidy_es(multcomp::glht(fit_test, c_test), mcc = 'none')
  df_jn_test <- gen_data_jn(df_coef_test)
  
  expect_equal(sort(unique(df_jn_test$facet)), c("A", "B", "C", "D"))
})

