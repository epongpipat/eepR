# check_contrast_orthogonality

checks to make sure that a contrast of a factor is orthogonal.

## Usage

``` r
check_contrast_orthogonality(x)
```

## Arguments

- x:

  contrast table/matrix

## Value

logical (TRUE if both rules are met and FALSE if not)

## Details

checks to make sure that a contrast of a factor is orthogonal by
ensuring (1) sum of each contrast equals 0 and (2) sum of each product
of each contrast pair equals 0

## Examples

``` r
contrast_example <- data.frame(c1 = c(1/3, 1/3, -2/3),
                               c2 = c(-1/2, 1/2, 0))
check_contrast_orthogonality(contrast_example)
#> rule 1. sum of each contrast equals 0 ✓ 
#> rule 2. sum of products of contrast pairs equals 0 ✓ 
#> [1] TRUE
```
