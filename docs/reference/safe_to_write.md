# safe_to_write

safe_to_write

## Usage

``` r
safe_to_write(f, overwrite = FALSE)
```

## Arguments

- f:

  path to file

- overwrite:

  logical, whether to overwrite if file already exists (default: FALSE)

## Value

logical, whether it is safe to write to the file

## See also

Other path helpers:
[`check_in_paths()`](https://ekarinpongpipat.com/eepR/reference/check_in_paths.md),
[`check_out_paths()`](https://ekarinpongpipat.com/eepR/reference/check_out_paths.md),
[`eval_cmd()`](https://ekarinpongpipat.com/eepR/reference/eval_cmd.md),
[`mkdir_if_dne()`](https://ekarinpongpipat.com/eepR/reference/mkdir_if_dne.md),
[`stop_if_dne()`](https://ekarinpongpipat.com/eepR/reference/stop_if_dne.md),
[`stop_if_e()`](https://ekarinpongpipat.com/eepR/reference/stop_if_e.md)

## Examples

``` r
safe_to_write(file.path(tempdir(), "new-file.txt"))
#> [1] TRUE
```
