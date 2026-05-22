# mkdir_if_dne

recursively create directories if it does not exist

## Usage

``` r
mkdir_if_dne(dir, recursive = TRUE)
```

## Arguments

- dir:

  directory path to create if missing

- recursive:

  logical, whether to create parent directories

## Value

Invisibly returns `NULL`; creates `dir` if needed.

## See also

Other path helpers:
[`check_in_paths()`](https://ekarinpongpipat.com/eepR/reference/check_in_paths.md),
[`check_out_paths()`](https://ekarinpongpipat.com/eepR/reference/check_out_paths.md),
[`eval_cmd()`](https://ekarinpongpipat.com/eepR/reference/eval_cmd.md),
[`safe_to_write()`](https://ekarinpongpipat.com/eepR/reference/safe_to_write.md),
[`stop_if_dne()`](https://ekarinpongpipat.com/eepR/reference/stop_if_dne.md),
[`stop_if_e()`](https://ekarinpongpipat.com/eepR/reference/stop_if_e.md)

## Examples

``` r
out_dir <- file.path(tempdir(), "eepR-example-dir")
mkdir_if_dne(out_dir)
dir.exists(out_dir)
#> [1] TRUE
```
