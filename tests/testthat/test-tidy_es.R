test_that("tidy_es and tidy_es_cope_t support multiple comparison corrections (mcc)", {
  model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
  c <- rbind(
    AssocProf_minus_AsstProf = c(0, 1, 0, 0),
    Prof_minus_AsstProf      = c(0, 0, 1, 0),
    Prof_minus_AssocProf     = c(0, -1, 1, 0)
  )
  glht_obj <- multcomp::glht(model_fit, c)

  # 1. Default / single-step / tukey
  set.seed(42)
  res_default <- tidy_es(glht_obj)
  set.seed(42)
  res_single_step <- tidy_es(glht_obj, mcc = "single-step")
  set.seed(42)
  res_tukey <- tidy_es(glht_obj, mcc = "tukey")
  set.seed(42)
  res_tukey_hsd <- tidy_es(glht_obj, mcc = "tukey's HSD")

  expect_equal(res_default, res_single_step)
  expect_equal(res_default, res_tukey)
  expect_equal(res_default, res_tukey_hsd)

  # 2. None / uncorrected
  set.seed(42)
  res_none <- tidy_es(glht_obj, mcc = "none")
  set.seed(42)
  res_uncorrected <- tidy_es(glht_obj, mcc = "uncorrected")

  expect_equal(res_none, res_uncorrected)
  
  # Check that p-values differ between single-step and none
  expect_true(any(res_default$p != res_none$p))
  # Check that confidence intervals differ (simultaneous vs univariate)
  expect_true(any(res_default$b_ci_ll != res_none$b_ci_ll))
  expect_true(any(res_default$b_ci_ul != res_none$b_ci_ul))

  # 3. FDR / fdr
  set.seed(42)
  res_fdr <- tidy_es(glht_obj, mcc = "fdr")
  set.seed(42)
  res_FDR <- tidy_es(glht_obj, mcc = "FDR")

  expect_equal(res_fdr, res_FDR)
  
  # FDR p-values should differ from single-step
  expect_true(any(res_default$p != res_fdr$p))
  # FDR confidence intervals should be univariate (same as none)
  expect_equal(res_fdr$b_ci_ll, res_none$b_ci_ll)
  expect_equal(res_fdr$b_ci_ul, res_none$b_ci_ul)

  # 4. Error handling for invalid mcc option
  expect_error(tidy_es(glht_obj, mcc = "invalid_mcc"))
})

test_that("tidy_es_cope_F and tidy_es with test = 'F' calculate correct SS/MS values", {
  model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
  c <- gen_contrast_ss(model_fit, x = "rank")[-1, ]
  glht_obj <- multcomp::glht(model_fit, c)

  # 1. Direct call to tidy_es_cope_F
  res_direct <- tidy_es_cope_F(glht_obj, label = "rank")
  
  # Check if SS and MS are correct (compared to car::Anova)
  anova_res <- car::Anova(model_fit, type = 2)
  expected_ss <- anova_res["rank", "Sum Sq"]
  expected_ms <- expected_ss / 2
  
  expect_equal(res_direct$ss, expected_ss, tolerance = 1e-5)
  expect_equal(res_direct$ms, expected_ms, tolerance = 1e-5)
  expect_equal(res_direct$rh, "rank")

  # 2. Indirect call through tidy_es(..., test = "F")
  res_indirect <- tidy_es(glht_obj, test = "F", label = "rank")
  expect_equal(res_direct, res_indirect)
})

