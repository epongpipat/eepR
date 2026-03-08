# extract_brain_slice

extract_brain_slice

## Usage

``` r
extract_brain_slice(data, dir, slice)
```

## Arguments

- data:

  3D brain data

- dir:

  direction to extract slice (choices: i, j, or k)

- slice:

  integer from 1 to slice max

## Value

data.frame of the slice in long format (columns: x, y, value)
