test_that("plot_steps works with a data.frame", {
  df <- data.frame(
    sub = c("sub01", "sub02", "sub03"),
    `1. Step 1` = c(1, 1, 1),
    `2. Step 2` = c(1, 1, 0),
    `3. Step 3` = c(1, 0, 0),
    check.names = FALSE
  )
  
  fig <- plot_steps(df)
  expect_true(inherits(fig, "ggplot") || inherits(fig, "patchwork"))
})

test_that("plot_steps works with a file path", {
  df <- data.frame(
    sub = c("sub01", "sub02", "sub03"),
    `1. Step 1` = c(1, 1, 1),
    `2. Step 2` = c(1, 1, 0),
    `3. Step 3` = c(1, 0, 0),
    check.names = FALSE
  )
  
  temp_file <- tempfile(fileext = ".csv")
  write.csv(df, temp_file, row.names = FALSE)
  on.exit(unlink(temp_file))
  
  fig <- plot_steps(temp_file)
  expect_true(inherits(fig, "ggplot") || inherits(fig, "patchwork"))
})

test_that("plot_steps throws error on invalid input", {
  expect_error(plot_steps(12345))
  expect_error(plot_steps("nonexistent_file.csv"))
})
