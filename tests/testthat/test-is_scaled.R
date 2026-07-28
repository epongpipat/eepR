test_that("is_centered works correctly", {
  expect_true(unname(is_centered(scale(c(1, 2, 3), scale = FALSE))))
  expect_false(unname(is_centered(c(-2, -3, -4))))
  expect_false(unname(is_centered(c(1, 2, 3))))
  
  # Matrix input
  mat <- cbind(scale(c(1, 2, 3), scale = FALSE), c(1, 2, 3))
  expect_equal(unname(is_centered(mat)), c(TRUE, FALSE))
})

test_that("is_z_scored works correctly", {
  expect_true(unname(is_z_scored(scale(c(1, 2, 3)))))
  expect_false(unname(is_z_scored(c(-2, -2.5, -3))))
  expect_false(unname(is_z_scored(c(1, 2, 3))))
  
  # Matrix input
  mat <- cbind(scale(c(1, 2, 3)), c(1, 2, 3))
  expect_equal(unname(is_z_scored(mat)), c(TRUE, FALSE))
})

test_that("is_ss1 works correctly", {
  expect_false(unname(is_ss1(c(0.5, 0.5))))
  expect_true(unname(is_ss1(c(1/sqrt(2), 1/sqrt(2)))))
  
  # Matrix input
  mat <- cbind(c(1/sqrt(2), 1/sqrt(2)), c(0.5, 0.5))
  expect_equal(unname(is_ss1(mat)), c(TRUE, FALSE))
})

test_that("is_scaled routes and validates correctly", {
  expect_true(unname(is_scaled(scale(c(1, 2, 3), scale = FALSE), type = "centered")))
  expect_true(unname(is_scaled(scale(c(1, 2, 3)), type = "z")))
  expect_true(unname(is_scaled(c(1/sqrt(2), 1/sqrt(2)), type = "ss1")))
  
  # Invalid type option
  expect_error(is_scaled(c(1, 2, 3), type = "invalid_option"))
})
