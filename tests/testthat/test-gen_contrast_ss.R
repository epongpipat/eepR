test_that("gen_contrast_ss works for continuous and categorical variables, custom contrasts, covariates, and polynomials", {
  data <- carData::Salaries

  # --- Test Case 1: One-way Continuous Focal (no moderators, no covariates) ---
  fit1 <- lm(salary ~ yrs.since.phd, data = data)
  c1 <- gen_contrast_ss(fit1, x = "yrs.since.phd")
  expect_equal(dim(c1), c(1L, 2L))
  expect_equal(unname(c1[1, "(Intercept)"]), 0)
  expect_equal(unname(c1[1, "yrs.since.phd"]), 1)

  # --- Test Case 2: One-way Categorical Focal with Treatment contrasts ---
  fit2 <- lm(salary ~ rank, data = data)
  c2 <- gen_contrast_ss(fit2, x = "rank")
  expect_equal(dim(c2), c(3L, 3L))
  expect_equal(unname(c2["rankAsstProf", ]), c(0, 0, 0))
  expect_equal(unname(c2["rankAssocProf", ]), c(0, 1, 0))
  expect_equal(unname(c2["rankProf", ]), c(0, 0, 1))

  # --- Test Case 3: One-way Categorical Focal with Sum/Effects coding ---
  df_sum <- data
  contrasts(df_sum$rank) <- contr.sum(levels(df_sum$rank))
  colnames(contrasts(df_sum$rank)) <- levels(df_sum$rank)[1:2]
  fit3 <- lm(salary ~ rank, data = df_sum)
  c3 <- gen_contrast_ss(fit3, x = "rank")
  expect_equal(dim(c3), c(3L, 3L))
  expect_equal(unname(c3["rankAsstProf", ]), c(0, 0, 0))
  expect_equal(unname(c3["rankAssocProf", ]), c(0, -1, 1))
  expect_equal(unname(c3["rankProf", ]), c(0, -2, -1))

  # --- Test Case 4: One-way Categorical Focal with Custom Coding Matrix ---
  df_custom <- data
  c_custom <- cbind('AsstvsTenured' = c(-2, 1, 1)/3, 'AssocvsFull' = c(0, -1, 1)/2)
  contrasts(df_custom$rank) <- c_custom
  fit4 <- lm(salary ~ rank, data = df_custom)
  c4 <- gen_contrast_ss(fit4, x = "rank")
  expect_equal(dim(c4), c(3L, 3L))
  expect_equal(unname(c4["rankAsstProf", ]), c(0, 0, 0))
  expect_equal(unname(c4["rankAssocProf", ]), c(0, 1, -0.5))
  expect_equal(unname(c4["rankProf", ]), c(0, 1, 0.5))

  # --- Test Case 5: Continuous Focal + Continuous Covariates ---
  fit5 <- lm(salary ~ yrs.since.phd + yrs.service, data = data)
  c5 <- gen_contrast_ss(fit5, x = "yrs.since.phd")
  expect_equal(dim(c5), c(1L, 3L))
  expect_equal(unname(c5[1, "yrs.service"]), 0)

  # --- Test Case 6: Continuous Focal + Categorical Covariates ---
  fit6 <- lm(salary ~ yrs.since.phd + rank, data = df_custom)
  c6 <- gen_contrast_ss(fit6, x = "yrs.since.phd")
  expect_equal(dim(c6), c(1L, 4L))
  expect_equal(unname(c6[1, "rankAsstvsTenured"]), 0)
  expect_equal(unname(c6[1, "rankAssocvsFull"]), 0)

  # --- Test Case 7: Categorical Focal + Continuous Covariates ---
  fit7 <- lm(salary ~ rank + yrs.since.phd, data = df_custom)
  c7 <- gen_contrast_ss(fit7, x = "rank")
  expect_equal(dim(c7), c(3L, 4L))
  expect_equal(unname(c7[, "yrs.since.phd"]), c(0, 0, 0))

  # --- Test Case 8: Categorical Focal + Categorical Covariates ---
  df_custom$sex_cc <- df_custom$sex
  contrasts(df_custom$sex_cc) <- cbind('female_cc' = c(0.5, -0.5))
  fit8 <- lm(salary ~ rank + sex_cc, data = df_custom)
  c8 <- gen_contrast_ss(fit8, x = "rank")
  expect_equal(dim(c8), c(3L, 4L))
  expect_equal(unname(c8[, "sex_ccfemale_cc"]), c(0, 0, 0))

  # --- Test Case 9: Polynomial Continuous Focal ---
  fit9 <- lm(salary ~ scale(yrs.since.phd, scale = F) * I(scale(yrs.since.phd, scale = F)^2), data = data)
  c9_overall <- gen_contrast_ss(fit9, x = "yrs.since.phd")
  expect_equal(dim(c9_overall), c(1L, 4L))
  c9_moderated <- gen_contrast_ss(fit9, x = "yrs.since.phd", m = list("yrs.since.phd" = "real"))
  expect_equal(dim(c9_moderated), c(53L, 4L))

  # --- Test Case 10: Error checking ---
  fit10 <- lm(salary ~ rank + sex, data = data)
  expect_error(gen_contrast_ss(fit10, x = "yrs.since.phd"))

  fit11 <- lm(salary ~ scale(yrs.since.phd, scale = F) + rank, data = data)
  expect_error(gen_contrast_ss(fit11, x = "yrs.since.phd", m = list("rank" = "real")))
  expect_error(gen_contrast_ss(fit11, x = "yrs.since.phd", m = "sd"))

  # --- Test Case 11: Full term and transformed predictor names with strict exact matching ---
  fit_test <- lm(salary ~ scale(yrs.since.phd, scale = F) * rank + I(scale(yrs.since.phd, scale = F)^2) * rank, data = data)
  
  c_term1 <- gen_contrast_ss(fit_test, x = "scale(yrs.since.phd, scale = F)", m = list(rank = "real"))
  expect_true(any(grepl("scale(yrs.since.phd, scale = F)", rownames(c_term1), fixed = TRUE)))
  expect_equal(unname(c_term1[, "scale(yrs.since.phd, scale = F)"]), c(1, 1, 1))
  expect_equal(unname(c_term1[, "I(scale(yrs.since.phd, scale = F)^2)"]), c(0, 0, 0))
  expect_equal(unname(c_term1["scale(yrs.since.phd, scale = F)@rank==\"AsstProf\"", "scale(yrs.since.phd, scale = F):rankAssocProf"]), 0)
  expect_equal(unname(c_term1["scale(yrs.since.phd, scale = F)@rank==\"AssocProf\"", "scale(yrs.since.phd, scale = F):rankAssocProf"]), 1)
  
  c_term2 <- gen_contrast_ss(fit_test, x = "I(scale(yrs.since.phd, scale = F)^2)", m = list(rank = "real"))
  expect_true(any(grepl("I(scale(yrs.since.phd, scale = F)^2)", rownames(c_term2), fixed = TRUE)))
  expect_equal(unname(c_term2[, "I(scale(yrs.since.phd, scale = F)^2)"]), c(1, 1, 1))
  expect_equal(unname(c_term2[, "scale(yrs.since.phd, scale = F)"]), c(0, 0, 0))
  expect_equal(unname(c_term2["I(scale(yrs.since.phd, scale = F)^2)@rank==\"AssocProf\"", "rankAssocProf:I(scale(yrs.since.phd, scale = F)^2)"]), 1)

  # Check that typos throw an error under strict exact matching
  expect_error(gen_contrast_ss(fit_test, x = "I(scale(yrs.since.phd, scale = F), ^2)"))

  # Check that passing raw variable name "yrs.since.phd" without self-moderation evaluates only the linear term
  c_raw <- gen_contrast_ss(fit_test, x = "yrs.since.phd", m = list(rank = "real"))
  expect_equal(unname(c_raw[, "scale(yrs.since.phd, scale = F)"]), c(1, 1, 1))
  expect_equal(unname(c_raw[, "I(scale(yrs.since.phd, scale = F)^2)"]), c(0, 0, 0))

  # Check that passing raw variable name "yrs.since.phd" WITH self-moderation evaluates the full polynomial (non-zero quadratic)
  c_raw_self <- gen_contrast_ss(fit_test, x = "yrs.since.phd", m = list(yrs.since.phd = "real"))
  expect_true(all(c_raw_self[, "I(scale(yrs.since.phd, scale = F)^2)"] != 0))

  # Check that passing transformed term or raw variable under self-moderation matches exactly in values
  c_term_self <- gen_contrast_ss(fit_test, x = "scale(yrs.since.phd, scale = F)", m = list(yrs.since.phd = "real"))
  expect_equal(unname(c_term_self), unname(c_raw_self))

  # Check that passing transformed term name as a moderator behaves exactly the same as raw variable name under self-moderation
  c_term_self_mod <- gen_contrast_ss(fit_test, x = "scale(yrs.since.phd, scale = F)", m = list("scale(yrs.since.phd, scale = F)" = "real"))
  expect_equal(unname(c_term_self_mod), unname(c_raw_self))
})

test_that("gen_contrast_ss works with lmerTest S4 models", {
  skip_if_not_installed("lmerTest")
  skip_if_not_installed("lme4")
  
  data <- carData::Salaries
  set.seed(42)
  data$subject <- factor(rep(1:10, length.out = nrow(data)))
  
  fit_lmer <- lmerTest::lmer(salary ~ scale(yrs.since.phd, scale = F) * rank + (1 | subject), data = data)
  
  c_lmer <- gen_contrast_ss(fit_lmer, x = "yrs.since.phd", m = list(rank = "real"))
  expect_equal(dim(c_lmer), c(3L, 6L))
  expect_equal(unname(c_lmer[, "scale(yrs.since.phd, scale = F)"]), c(1, 1, 1))
})

test_that("gen_contrast_ss sets unspecified factor covariates to 0", {
  skip_if_not_installed("lme4")
  library(lme4)
  
  set.seed(789)
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
  
  c_test <- gen_contrast_ss(fit_test, 'Age', m = list('Time' = 0:1, 'Difficulty' = 'real'))
  
  cols_network <- grep("(^|:)Network([0-9]+)?(:|$)", colnames(c_test))
  expect_true(length(cols_network) > 0)
  expect_equal(unname(colSums(c_test[, cols_network, drop = FALSE])), rep(0, length(cols_network)))
})

test_that("gen_contrast_ss validates covariates argument inputs", {
  skip_if_not_installed("lme4")
  library(lme4)
  
  set.seed(999)
  n_test <- 100
  df_test <- data.frame(
    y = rnorm(n_test),
    Age = rnorm(n_test, 40, 10),
    Time = sample(0:2, n_test, replace = TRUE),
    Difficulty = factor(sample(c("Easy", "Hard"), n_test, replace = TRUE)),
    Subject = factor(sample(1:10, n_test, replace = TRUE))
  )
  
  # Fit model where Time interacts with Age, but Difficulty does NOT interact with Age
  fit_test <- lmer(y ~ Age * Time + Difficulty + (1 | Subject), data = df_test)
  
  # 1. Expect error if a covariate length is not exactly 1
  expect_error(
    gen_contrast_ss(fit_test, 'Age', m = list('Time' = 0:1), covariates = list(Difficulty = c(0, 1))),
    "Each covariate specification in 'covariates' must have a length of exactly 1"
  )
  
  # 2. Expect error if a specified covariate does not interact with the focal predictor in the model
  expect_error(
    gen_contrast_ss(fit_test, 'Age', m = list('Time' = 0:1), covariates = list(Difficulty = 0)),
    "Covariate 'Difficulty' does not interact with focal predictor 'Age' in the model"
  )
  
  # 3. Named vectors should work identically
  expect_error(
    gen_contrast_ss(fit_test, 'Age', m = list('Time' = 0:1), covariates = c(Difficulty = 0)),
    "Covariate 'Difficulty' does not interact with focal predictor 'Age' in the model"
  )
})

test_that("gen_contrast_ss allows specifying factor level and custom contrast columns in covariates", {
  data <- carData::Salaries
  data$rank <- factor(data$rank)
  contrasts(data$rank) <- contr.sum(3)
  
  fit <- lm(salary ~ scale(yrs.since.phd, scale = FALSE) * rank + I(scale(yrs.since.phd, scale = FALSE)^2) * rank, data = data)
  
  # 1. Specifying factor level directly (e.g. rank = 'Prof')
  c_prof <- gen_contrast_ss(fit, x = "yrs.since.phd", covariates = list(rank = "Prof"))
  expect_equal(unname(c_prof[, "scale(yrs.since.phd, scale = FALSE):rank1"]), -1)
  expect_equal(unname(c_prof[, "scale(yrs.since.phd, scale = FALSE):rank2"]), -1)
  
  # 2. Specifying custom contrast columns directly (e.g. rank1 = 1, rank2 = 0)
  c_custom <- gen_contrast_ss(fit, x = "yrs.since.phd", covariates = list(rank1 = 1, rank2 = 0))
  expect_equal(unname(c_custom[, "scale(yrs.since.phd, scale = FALSE):rank1"]), 1)
  expect_equal(unname(c_custom[, "scale(yrs.since.phd, scale = FALSE):rank2"]), 0)
})



