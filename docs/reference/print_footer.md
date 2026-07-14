# print_footer

print_footer

## Usage

``` r
print_footer(start_datetime)
```

## Arguments

- start_datetime:

  start time from \`print_header()\`

## Value

Invisibly returns `NULL`; prints elapsed time.

## See also

Other console messaging helpers:
[`error_msg()`](https://ekarinpongpipat.com/eepR/reference/error_msg.md),
[`info_msg()`](https://ekarinpongpipat.com/eepR/reference/info_msg.md),
[`print_header()`](https://ekarinpongpipat.com/eepR/reference/print_header.md),
[`warning_msg()`](https://ekarinpongpipat.com/eepR/reference/warning_msg.md)

## Examples

``` r
start_time <- Sys.time()
print_footer(start_time)
#> 
#> date:        2026-07-14 13:11:34.981852 
#> hostname:    CVL91905 
#> user:        ekarinpongpipat 
#> duration:    00:00:00:0.001 
#> 
```
