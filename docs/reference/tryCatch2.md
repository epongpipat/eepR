# tryCatch2

tryCatch2

## Usage

``` r
tryCatch2(expr)
```

## Arguments

- expr:

  expression to evaluate with error printing

## Value

result of `expr`, or printed error if `expr` fails

## Examples

``` r
tryCatch2(1 + 1)
#> [1] 2
tryCatch2(stop("example error"))
#> <simpleError in doTryCatch(return(expr), name, parentenv, handler): example error>
```
