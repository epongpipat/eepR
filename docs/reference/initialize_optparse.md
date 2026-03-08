# initialize_optparse

creates an optparse template from a function and its arguments

## Usage

``` r
initialize_optparse(func_name, func_path = NULL, out_path = NULL)
```

## Arguments

- func_name:

  name of function \[type: string\]

- func_path:

  path to function (optional)

- out_path:

  path to write optparsed file (optional)

## Examples

``` r
initialize_optparse("pmid2doi")
#> #!/usr/local/bin/Rscript --vanilla
#> 
#> suppressMessages(require(optparse))
#> option_list <- list(
#>   make_option(opt_str = c('--pmid'))
#> )
#> opts <- parse_args(OptionParser(option_list = option_list))
#> pmid2doi(opts$pmid)
```
