# error_msg

error_msg

## Usage

``` r
error_msg(msg)
```

## Arguments

- msg:

  error message to print

## Value

Invisibly returns `NULL`; prints a formatted error message.

## See also

Other console messaging helpers:
[`info_msg()`](https://ekarinpongpipat.com/eepR/reference/info_msg.md),
[`print_footer()`](https://ekarinpongpipat.com/eepR/reference/print_footer.md),
[`print_header()`](https://ekarinpongpipat.com/eepR/reference/print_header.md),
[`warning_msg()`](https://ekarinpongpipat.com/eepR/reference/warning_msg.md)

## Examples

``` r
try(error_msg("example error"))
#> Error in error_msg("example error") : 
#>   [2026-07-14 12:44:08] [ERROR] example error
#> 
```
