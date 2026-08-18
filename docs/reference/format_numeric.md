# format_numeric

formats a numeric value into a clean string, using scientific notation
(with HTML formatting or plain text) for small/large numbers

## Usage

``` r
format_numeric(x, digits = 3, format = "html")
```

## Arguments

- x:

  numeric value to format

- digits:

  specify digit to round statistics (default: 3)

- format:

  specify format (default: html) (options: html, plain)

## Value

Character string with formatted number.
