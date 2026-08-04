test_that("plot_heatmap works with default parameters", {
  # Simulate a 10-node lookup table
  sim_lut <- data.frame(
    index = 1:10,
    name = paste0("parcel", 1:10),
    color = rep(c("red", "blue"), each = 5),
    network = rep(c("NetA", "NetB"), each = 5),
    stringsAsFactors = FALSE
  )
  
  # Simulate a 10x10 matrix
  sim_matrix <- matrix(runif(100), nrow = 10, ncol = 10)
  rownames(sim_matrix) <- sim_lut$name
  colnames(sim_matrix) <- sim_lut$name
  
  fig <- plot_heatmap(
    affine_matrix = sim_matrix,
    lut = sim_lut,
    group_by = "network",
    border_width = 2
  )
  
  expect_s3_class(fig, "ggplot")
  
  # Check that scales are present
  scales_aesthetics <- sapply(fig$scales$scales, function(s) s$aesthetics[1])
  expect_true("fill" %in% scales_aesthetics)
  expect_true(any(grepl("fill_ggnewscale", scales_aesthetics)))
})

test_that("plot_heatmap options to turn off guides work", {
  sim_lut <- data.frame(
    index = 1:10,
    name = paste0("parcel", 1:10),
    color = rep(c("red", "blue"), each = 5),
    network = rep(c("NetA", "NetB"), each = 5),
    stringsAsFactors = FALSE
  )
  sim_matrix <- matrix(runif(100), nrow = 10, ncol = 10)
  rownames(sim_matrix) <- sim_lut$name
  colnames(sim_matrix) <- sim_lut$name
  
  # 1. Turn off regular fill guide
  fig_no_legend <- plot_heatmap(
    affine_matrix = sim_matrix,
    lut = sim_lut,
    group_by = "network",
    border_width = 2,
    legend = FALSE
  )
  
  # Find the main fill scale (its aesthetics is exactly "fill")
  scales <- fig_no_legend$scales$scales
  fill_scale_idx <- which(sapply(scales, function(s) identical(s$aesthetics, "fill")))
  expect_true(length(fill_scale_idx) == 1)
  expect_equal(scales[[fill_scale_idx]]$guide, "none")
  
  # 2. Turn off group legend guide
  fig_no_group_legend <- plot_heatmap(
    affine_matrix = sim_matrix,
    lut = sim_lut,
    group_by = "network",
    border_width = 2,
    legend_group_by = FALSE
  )
  
  # Find the group fill scales (their aesthetics starts with "fill_ggnewscale")
  group_scales <- fig_no_group_legend$scales$scales[sapply(fig_no_group_legend$scales$scales, function(s) any(grepl("fill_ggnewscale", s$aesthetics)))]
  expect_true(length(group_scales) > 0)
  for (gs in group_scales) {
    expect_equal(gs$guide, "none")
  }
})
