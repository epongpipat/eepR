# nice_table_html

nice_table_html

## Usage

``` r
nice_table_html(table)
```

## Arguments

- table:

  a data.frame/table to pass through kable

## Value

a scrollable HTML table

## See also

Other table helpers:
[`nice_table()`](https://ekarinpongpipat.com/eepR/reference/nice_table.md),
[`nice_table_html_short()`](https://ekarinpongpipat.com/eepR/reference/nice_table_html_short.md)

## Examples

``` r
nice_table_html(head(mtcars))
#> <div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; "><table class="table table-striped table-hover table-condensed table-responsive" style="color: black; margin-left: auto; margin-right: auto;">
#>  <thead>
#>   <tr>
#>    <th style="text-align:left;">  </th>
#>    <th style="text-align:right;"> mpg </th>
#>    <th style="text-align:right;"> cyl </th>
#>    <th style="text-align:right;"> disp </th>
#>    <th style="text-align:right;"> hp </th>
#>    <th style="text-align:right;"> drat </th>
#>    <th style="text-align:right;"> wt </th>
#>    <th style="text-align:right;"> qsec </th>
#>    <th style="text-align:right;"> vs </th>
#>    <th style="text-align:right;"> am </th>
#>    <th style="text-align:right;"> gear </th>
#>    <th style="text-align:right;"> carb </th>
#>   </tr>
#>  </thead>
#> <tbody>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.620 </td>
#>    <td style="text-align:right;"> 16.46 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 Wag </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.875 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Datsun 710 </td>
#>    <td style="text-align:right;"> 22.8 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 108 </td>
#>    <td style="text-align:right;"> 93 </td>
#>    <td style="text-align:right;"> 3.85 </td>
#>    <td style="text-align:right;"> 2.320 </td>
#>    <td style="text-align:right;"> 18.61 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet 4 Drive </td>
#>    <td style="text-align:right;"> 21.4 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 258 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.08 </td>
#>    <td style="text-align:right;"> 3.215 </td>
#>    <td style="text-align:right;"> 19.44 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet Sportabout </td>
#>    <td style="text-align:right;"> 18.7 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 360 </td>
#>    <td style="text-align:right;"> 175 </td>
#>    <td style="text-align:right;"> 3.15 </td>
#>    <td style="text-align:right;"> 3.440 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Valiant </td>
#>    <td style="text-align:right;"> 18.1 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 225 </td>
#>    <td style="text-align:right;"> 105 </td>
#>    <td style="text-align:right;"> 2.76 </td>
#>    <td style="text-align:right;"> 3.460 </td>
#>    <td style="text-align:right;"> 20.22 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#> </tbody>
#> </table></div>
```
