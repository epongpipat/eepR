# eval_cmd

eval_cmd

## Usage

``` r
eval_cmd(cmd, out_paths, overwrite = FALSE, print = FALSE)
```

## Arguments

- cmd:

  string expression to evaluate

- out_paths:

  vector or list of output paths

- overwrite:

  flag to overwrite output paths (default: FALSE)

- print:

  flag to print command only (default: FALSE)

## Value

Invisibly returns `NULL`; evaluates `cmd` for its side effects.

## See also

Other path helpers:
[`check_in_paths()`](https://ekarinpongpipat.com/eepR/reference/check_in_paths.md),
[`check_out_paths()`](https://ekarinpongpipat.com/eepR/reference/check_out_paths.md),
[`mkdir_if_dne()`](https://ekarinpongpipat.com/eepR/reference/mkdir_if_dne.md),
[`safe_to_write()`](https://ekarinpongpipat.com/eepR/reference/safe_to_write.md),
[`stop_if_dne()`](https://ekarinpongpipat.com/eepR/reference/stop_if_dne.md),
[`stop_if_e()`](https://ekarinpongpipat.com/eepR/reference/stop_if_e.md)

## Examples

``` r
out_path <- file.path(tempdir(), "eval-cmd-example.txt")
eval_cmd(
  "writeLines('hello', out_path)",
  out_paths = out_path,
  overwrite = TRUE
)
#> 
#> [CMD]    writeLines('hello', out_path)
#> Error in eval(parse(text = cmd), envir = .GlobalEnv): object 'out_path' not found
```
