# stop_if_e

stop_if_e

## Usage

``` r
stop_if_e(file)
```

## Arguments

- file:

  file path to check

## Value

Invisibly returns `NULL`; errors if `file` exists.

## See also

Other path helpers:
[`check_in_paths()`](https://ekarinpongpipat.com/eepR/reference/check_in_paths.md),
[`check_out_paths()`](https://ekarinpongpipat.com/eepR/reference/check_out_paths.md),
[`eval_cmd()`](https://ekarinpongpipat.com/eepR/reference/eval_cmd.md),
[`mkdir_if_dne()`](https://ekarinpongpipat.com/eepR/reference/mkdir_if_dne.md),
[`safe_to_write()`](https://ekarinpongpipat.com/eepR/reference/safe_to_write.md),
[`stop_if_dne()`](https://ekarinpongpipat.com/eepR/reference/stop_if_dne.md)

## Examples

``` r
stop_if_e(file.path(tempdir(), "missing-file.txt"))
```
