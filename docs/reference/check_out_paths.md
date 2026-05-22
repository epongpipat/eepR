# check_out_paths

check_out_paths

## Usage

``` r
check_out_paths(paths, overwrite = 0)
```

## Arguments

- paths:

  paths to check

- overwrite:

  boolean

## Value

Invisibly returns `NULL`; errors or warns if output paths already exist.

## See also

Other path helpers:
[`check_in_paths()`](https://ekarinpongpipat.com/eepR/reference/check_in_paths.md),
[`eval_cmd()`](https://ekarinpongpipat.com/eepR/reference/eval_cmd.md),
[`mkdir_if_dne()`](https://ekarinpongpipat.com/eepR/reference/mkdir_if_dne.md),
[`safe_to_write()`](https://ekarinpongpipat.com/eepR/reference/safe_to_write.md),
[`stop_if_dne()`](https://ekarinpongpipat.com/eepR/reference/stop_if_dne.md),
[`stop_if_e()`](https://ekarinpongpipat.com/eepR/reference/stop_if_e.md)

## Examples

``` r
check_out_paths(file.path(tempdir(), "new-file.txt"))
```
