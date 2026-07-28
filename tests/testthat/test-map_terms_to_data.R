test_that("map_terms_to_data works for raw and transformed predictor terms", {
  data <- carData::Salaries
  fit <- lm(salary ~ scale(yrs.since.phd, scale = F) * rank + I(scale(yrs.since.phd, scale = F)^2) * rank, data = data)
  
  # Raw variable
  expect_equal(map_terms_to_data(fit, "yrs.since.phd"), "yrs.since.phd")
  expect_equal(map_terms_to_data(fit, "rank"), "rank")
  
  # Transformed term
  expect_equal(map_terms_to_data(fit, "scale(yrs.since.phd, scale = F)"), "yrs.since.phd")
  expect_equal(map_terms_to_data(fit, "I(scale(yrs.since.phd, scale = F)^2)"), "yrs.since.phd")
  
  # Multiple terms
  expect_equal(map_terms_to_data(fit, c("scale(yrs.since.phd, scale = F)", "rank")), c("yrs.since.phd", "rank"))
  
  # Errors for non-existent / typos
  expect_error(map_terms_to_data(fit, "discipline"))
  expect_error(map_terms_to_data(fit, "I(scale(yrs.since.phd, scale = F), ^2)"))
})
