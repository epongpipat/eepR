test_that("extract_interaction_terms works correctly", {
  data <- carData::Salaries
  
  # Standard interactions
  fit1 <- lm(salary ~ yrs.since.phd * rank, data = data)
  res1 <- extract_interaction_terms(fit1, "yrs.since.phd")
  expect_equal(unname(res1), "yrs.since.phd:rank")
  expect_equal(names(res1), "rank")
  
  # Polynomial terms (self-moderation)
  fit2 <- lm(salary ~ yrs.since.phd + I(yrs.since.phd^2), data = data)
  res2 <- extract_interaction_terms(fit2, "yrs.since.phd")
  expect_equal(unname(res2), "I(yrs.since.phd^2)")
  expect_equal(names(res2), "yrs.since.phd")
  
  # Complex model with both types of interactions
  fit3 <- lm(salary ~ scale(yrs.since.phd, scale = F) * rank + I(scale(yrs.since.phd, scale = F)^2) * rank, data = data)
  res3 <- extract_interaction_terms(fit3, "yrs.since.phd")
  
  expect_true("I(scale(yrs.since.phd, scale = F)^2)" %in% res3)
  expect_true("scale(yrs.since.phd, scale = F):rank" %in% res3)
  expect_true("rank:I(scale(yrs.since.phd, scale = F)^2)" %in% res3)
  
  # Names check
  expect_true("rank" %in% names(res3))
  expect_true("yrs.since.phd" %in% names(res3))
})
