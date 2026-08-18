test_that("glht2apa works correctly for t-tests and F-tests", {
  model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
  c <- rbind(
    AssocProf_minus_AsstProf = c(0, 1, 0, 0),
    Prof_minus_AsstProf      = c(0, 0, 1, 0)
  )
  glht_obj <- multcomp::glht(model_fit, c)

  # Test t-test path (default)
  res_t_html <- glht2apa(glht_obj, test = 't', format = 'html')
  expect_type(res_t_html, "character")
  expect_length(res_t_html, 2)
  expect_named(res_t_html, c("AssocProf_minus_AsstProf", "Prof_minus_AsstProf"))
  expect_true(all(grepl("<i>b</i>", res_t_html)))
  expect_true(all(grepl("<i>t</i>", res_t_html)))
  expect_true(all(grepl("<i>p</i>", res_t_html)))
  expect_true(all(grepl("<i>R<sup>2</sup><sub>Adj.</sub></i>", res_t_html)))

  res_t_plain <- glht2apa(glht_obj, test = 't', format = 'plain')
  expect_true(all(grepl("b =", res_t_plain)))
  expect_true(all(grepl("t\\(", res_t_plain)))
  expect_true(all(grepl("p =", res_t_plain)))
  expect_true(all(grepl("Adjusted R-Squared =", res_t_plain)))

  # Test F-test path
  res_F_html <- glht2apa(glht_obj, test = 'F', format = 'html')
  expect_type(res_F_html, "character")
  expect_length(res_F_html, 1)
  expect_true(grepl("<i>F</i>", res_F_html))
  expect_true(grepl("<i>p</i>", res_F_html))
  expect_true(grepl("<i>R<sup>2</sup><sub>Adj.</sub></i>", res_F_html))

  res_F_plain <- glht2apa(glht_obj, test = 'F', format = 'plain')
  expect_true(grepl("F\\(", res_F_plain))
  expect_true(grepl("p =", res_F_plain))
  expect_true(grepl("Adjusted R-Squared =", res_F_plain))

  # Test summary.glht object input
  sum_glht <- summary(glht_obj)
  expect_equal(glht2apa(sum_glht, test = 't'), res_t_html)
  
  sum_glht_F <- summary(glht_obj, test = multcomp::Ftest())
  expect_equal(glht2apa(sum_glht_F, test = 'F'), res_F_html)

  # Test model2apa integration
  expect_equal(model2apa(glht_obj, test = 't'), res_t_html)
  expect_equal(model2apa(glht_obj, test = 'F'), res_F_html)

  # Test terms filtering
  res_filter <- glht2apa(glht_obj, terms = "AssocProf_minus_AsstProf")
  expect_length(res_filter, 1)
  expect_named(res_filter, "AssocProf_minus_AsstProf")

  # Test errors
  expect_error(glht2apa(glht_obj, level = 1.5))
  expect_error(glht2apa(glht_obj, format = "invalid"))
  expect_error(glht2apa("not a glht model"))
})
