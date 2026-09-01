# apa_table

covert a data table to APA format

## Usage

``` r
apa_table(table)
```

## Arguments

- table:

  input data table

## Value

gt object

## Details

black border on the top and bottom of the columns, black border on the
bottom of the table, and font is Times size 12

## Examples

``` r
apa_table(renamed_tidy(lm(mpg ~ wt, data = mtcars)))


  

lh
```

op

rh

b

se

t

p

mpg

\~

(Intercept)

37.285126

1.877627

19.857575

8.241799e-19

mpg

\~

wt

-5.344472

0.559101

-9.559044

1.293959e-10
