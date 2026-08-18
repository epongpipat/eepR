test_that("format_numeric formats zero and decimals correctly", {
  # Zero value
  expect_equal(format_numeric(0, digits = 3), "0.000")
  expect_equal(format_numeric(0, digits = 2), "0.00")

  # Standard rounding (within thresholds)
  expect_equal(format_numeric(0.1234, digits = 3), "0.123")
  expect_equal(format_numeric(-0.5, digits = 3), "-0.500")

  # Scientific notation - small numbers (HTML vs plain)
  expect_equal(format_numeric(0.00012, digits = 3, format = "html"), "1.2×10<sup>-4</sup>")
  expect_equal(format_numeric(0.00012, digits = 3, format = "plain"), "1.2×10^-4")

  # Scientific notation - large numbers (HTML vs plain)
  expect_equal(format_numeric(12345.67, digits = 3, format = "html"), "1.235×10<sup>4</sup>")
  expect_equal(format_numeric(12345.67, digits = 3, format = "plain"), "1.235×10^4")

  # Negative scientific numbers
  expect_equal(format_numeric(-0.00012, digits = 3, format = "html"), "-1.2×10<sup>-4</sup>")
  expect_equal(format_numeric(-0.00012, digits = 3, format = "plain"), "-1.2×10^-4")

  # NA handling
  expect_equal(format_numeric(NA), NA_character_)
})
