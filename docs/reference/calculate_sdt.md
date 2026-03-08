# calculate_sdt

calculate signal detection theory (SDT) metrics such as d' and c

## Usage

``` r
calculate_sdt(n_tp, n_tn, n_fp, n_fn)
```

## Arguments

- n_tp:

  number of true positives (or hit)

- n_tn:

  number of true negatives (or correct rejection)

- n_fp:

  number of false positives (or false alarm)

- n_fn:

  number of false negatives (or miss)

## Value

data.frame of signal detection theory metrics along with all the
variables created along the way

## Examples

``` r
calculate_sdt(25, 26, 5, 4)
#> # A tibble: 1 × 14
#>       n   n_t   n_f accuracy   tpr   tnr   fpr   fnr tpr_adj fpr_adj tpr_z
#>   <dbl> <dbl> <dbl>    <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl> <dbl>
#> 1    60    51     9     0.85 0.862 0.839 0.161 0.138   0.862   0.161  1.09
#> # ℹ 3 more variables: fpr_z <dbl>, d_prime <dbl>, c <dbl>
```
