# stop_if_dne

stop_if_dne

## Usage

``` r
stop_if_dne(file)
```

## Arguments

- file:

  file path to check

## Value

Invisibly returns `NULL`; errors if `file` does not exist.

## See also

Other path helpers:
[`check_in_paths()`](https://ekarinpongpipat.com/eepR/reference/check_in_paths.md),
[`check_out_paths()`](https://ekarinpongpipat.com/eepR/reference/check_out_paths.md),
[`eval_cmd()`](https://ekarinpongpipat.com/eepR/reference/eval_cmd.md),
[`mkdir_if_dne()`](https://ekarinpongpipat.com/eepR/reference/mkdir_if_dne.md),
[`safe_to_write()`](https://ekarinpongpipat.com/eepR/reference/safe_to_write.md),
[`stop_if_e()`](https://ekarinpongpipat.com/eepR/reference/stop_if_e.md)

## Examples

``` r
stop_if_dne(tempdir())
```
