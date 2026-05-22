# check_in_paths

check_in_paths

## Usage

``` r
check_in_paths(paths)
```

## Arguments

- paths:

  paths to check

## Value

Invisibly returns `NULL`; errors if any input path is missing.

## See also

Other path helpers:
[`check_out_paths()`](https://ekarinpongpipat.com/eepR/reference/check_out_paths.md),
[`eval_cmd()`](https://ekarinpongpipat.com/eepR/reference/eval_cmd.md),
[`mkdir_if_dne()`](https://ekarinpongpipat.com/eepR/reference/mkdir_if_dne.md),
[`safe_to_write()`](https://ekarinpongpipat.com/eepR/reference/safe_to_write.md),
[`stop_if_dne()`](https://ekarinpongpipat.com/eepR/reference/stop_if_dne.md),
[`stop_if_e()`](https://ekarinpongpipat.com/eepR/reference/stop_if_e.md)

## Examples

``` r
check_in_paths(tempdir())
```
