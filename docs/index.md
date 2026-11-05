# eepR

This package contains helper functions that I use regularly.

**Note**: This package will likely always be in a testing phase. Please
use this with caution.

## Install

``` r

# install.packages("remotes")
remotes::install_github("epongpipat/eepR")
```

### Dependencies

``` r

# install.packages("xfun")
deps <- c(
  "tidyverse",
  "easystats",
  "carData",
  "doParallel",
  "e1071",
  "furrr",
  "future",
  "ggnewscale",
  "ggtext",
  "glmnet",
  "gt",
  "kableExtra",
  "multcomp",
  "patchwork",
  "RNifti"
)
xfun::pkg_attach2(deps)
```
