# Plot Johnson-Neyman Data

Plot Johnson-Neyman Data

## Usage

``` r
# S3 method for class 'jn_df'
plot(x, scales = "fixed", ...)
```

## Arguments

- x:

  An object of class `jn_df` (the output from
  [`gen_data_jn()`](https://ekarinpongpipat.com/eepR/reference/gen_data_jn.md)).

- scales:

  Character vector specifying whether facet scales should be `"fixed"`,
  `"free_y"`, `"free_x"`, or `"free"`. Default is `"fixed"`.

- ...:

  Additional arguments (not used).

## Value

A `ggplot` object.

## See also

Other contrast or COPE helpers:
[`check_contrast_orthogonality()`](https://ekarinpongpipat.com/eepR/reference/check_contrast_orthogonality.md),
[`gen_contrast_blank()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_blank.md),
[`gen_contrast_ss()`](https://ekarinpongpipat.com/eepR/reference/gen_contrast_ss.md),
[`gen_data_jn()`](https://ekarinpongpipat.com/eepR/reference/gen_data_jn.md),
[`tidy_es_cope_F()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_F.md),
[`tidy_es_cope_t()`](https://ekarinpongpipat.com/eepR/reference/tidy_es_cope_t.md)
