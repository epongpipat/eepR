# nice_table_html_short

nice_table_html_short

## Usage

``` r
nice_table_html_short(table, height = "200px")
```

## Arguments

- table:

  a data.frame/table to pass through kable

- height:

  height of the scroll box

## Value

a short scrollable HTML table

## See also

Other table helpers:
[`nice_table()`](https://ekarinpongpipat.com/eepR/reference/nice_table.md),
[`nice_table_html()`](https://ekarinpongpipat.com/eepR/reference/nice_table_html.md)

## Examples

``` r
nice_table_html_short(mtcars, height = "150px")
#> <div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:150px; overflow-x: scroll; width:100%; "><table class="table table-striped table-hover table-condensed table-responsive" style="margin-left: auto; margin-right: auto;">
#>  <thead>
#>   <tr>
#>    <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">  </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> mpg </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> cyl </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> disp </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> hp </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> drat </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> wt </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> qsec </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> vs </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> am </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> gear </th>
#>    <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> carb </th>
#>   </tr>
#>  </thead>
#> <tbody>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160.0 </td>
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
#>    <td style="text-align:right;"> 160.0 </td>
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
#>    <td style="text-align:right;"> 108.0 </td>
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
#>    <td style="text-align:right;"> 258.0 </td>
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
#>    <td style="text-align:right;"> 360.0 </td>
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
#>    <td style="text-align:right;"> 225.0 </td>
#>    <td style="text-align:right;"> 105 </td>
#>    <td style="text-align:right;"> 2.76 </td>
#>    <td style="text-align:right;"> 3.460 </td>
#>    <td style="text-align:right;"> 20.22 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Duster 360 </td>
#>    <td style="text-align:right;"> 14.3 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 360.0 </td>
#>    <td style="text-align:right;"> 245 </td>
#>    <td style="text-align:right;"> 3.21 </td>
#>    <td style="text-align:right;"> 3.570 </td>
#>    <td style="text-align:right;"> 15.84 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Merc 240D </td>
#>    <td style="text-align:right;"> 24.4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 146.7 </td>
#>    <td style="text-align:right;"> 62 </td>
#>    <td style="text-align:right;"> 3.69 </td>
#>    <td style="text-align:right;"> 3.190 </td>
#>    <td style="text-align:right;"> 20.00 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Merc 230 </td>
#>    <td style="text-align:right;"> 22.8 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 140.8 </td>
#>    <td style="text-align:right;"> 95 </td>
#>    <td style="text-align:right;"> 3.92 </td>
#>    <td style="text-align:right;"> 3.150 </td>
#>    <td style="text-align:right;"> 22.90 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Merc 280 </td>
#>    <td style="text-align:right;"> 19.2 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 167.6 </td>
#>    <td style="text-align:right;"> 123 </td>
#>    <td style="text-align:right;"> 3.92 </td>
#>    <td style="text-align:right;"> 3.440 </td>
#>    <td style="text-align:right;"> 18.30 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Merc 280C </td>
#>    <td style="text-align:right;"> 17.8 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 167.6 </td>
#>    <td style="text-align:right;"> 123 </td>
#>    <td style="text-align:right;"> 3.92 </td>
#>    <td style="text-align:right;"> 3.440 </td>
#>    <td style="text-align:right;"> 18.90 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Merc 450SE </td>
#>    <td style="text-align:right;"> 16.4 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 275.8 </td>
#>    <td style="text-align:right;"> 180 </td>
#>    <td style="text-align:right;"> 3.07 </td>
#>    <td style="text-align:right;"> 4.070 </td>
#>    <td style="text-align:right;"> 17.40 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 3 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Merc 450SL </td>
#>    <td style="text-align:right;"> 17.3 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 275.8 </td>
#>    <td style="text-align:right;"> 180 </td>
#>    <td style="text-align:right;"> 3.07 </td>
#>    <td style="text-align:right;"> 3.730 </td>
#>    <td style="text-align:right;"> 17.60 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 3 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Merc 450SLC </td>
#>    <td style="text-align:right;"> 15.2 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 275.8 </td>
#>    <td style="text-align:right;"> 180 </td>
#>    <td style="text-align:right;"> 3.07 </td>
#>    <td style="text-align:right;"> 3.780 </td>
#>    <td style="text-align:right;"> 18.00 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 3 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Cadillac Fleetwood </td>
#>    <td style="text-align:right;"> 10.4 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 472.0 </td>
#>    <td style="text-align:right;"> 205 </td>
#>    <td style="text-align:right;"> 2.93 </td>
#>    <td style="text-align:right;"> 5.250 </td>
#>    <td style="text-align:right;"> 17.98 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Lincoln Continental </td>
#>    <td style="text-align:right;"> 10.4 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 460.0 </td>
#>    <td style="text-align:right;"> 215 </td>
#>    <td style="text-align:right;"> 3.00 </td>
#>    <td style="text-align:right;"> 5.424 </td>
#>    <td style="text-align:right;"> 17.82 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Chrysler Imperial </td>
#>    <td style="text-align:right;"> 14.7 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 440.0 </td>
#>    <td style="text-align:right;"> 230 </td>
#>    <td style="text-align:right;"> 3.23 </td>
#>    <td style="text-align:right;"> 5.345 </td>
#>    <td style="text-align:right;"> 17.42 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Fiat 128 </td>
#>    <td style="text-align:right;"> 32.4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 78.7 </td>
#>    <td style="text-align:right;"> 66 </td>
#>    <td style="text-align:right;"> 4.08 </td>
#>    <td style="text-align:right;"> 2.200 </td>
#>    <td style="text-align:right;"> 19.47 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Honda Civic </td>
#>    <td style="text-align:right;"> 30.4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 75.7 </td>
#>    <td style="text-align:right;"> 52 </td>
#>    <td style="text-align:right;"> 4.93 </td>
#>    <td style="text-align:right;"> 1.615 </td>
#>    <td style="text-align:right;"> 18.52 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Toyota Corolla </td>
#>    <td style="text-align:right;"> 33.9 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 71.1 </td>
#>    <td style="text-align:right;"> 65 </td>
#>    <td style="text-align:right;"> 4.22 </td>
#>    <td style="text-align:right;"> 1.835 </td>
#>    <td style="text-align:right;"> 19.90 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Toyota Corona </td>
#>    <td style="text-align:right;"> 21.5 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 120.1 </td>
#>    <td style="text-align:right;"> 97 </td>
#>    <td style="text-align:right;"> 3.70 </td>
#>    <td style="text-align:right;"> 2.465 </td>
#>    <td style="text-align:right;"> 20.01 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Dodge Challenger </td>
#>    <td style="text-align:right;"> 15.5 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 318.0 </td>
#>    <td style="text-align:right;"> 150 </td>
#>    <td style="text-align:right;"> 2.76 </td>
#>    <td style="text-align:right;"> 3.520 </td>
#>    <td style="text-align:right;"> 16.87 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> AMC Javelin </td>
#>    <td style="text-align:right;"> 15.2 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 304.0 </td>
#>    <td style="text-align:right;"> 150 </td>
#>    <td style="text-align:right;"> 3.15 </td>
#>    <td style="text-align:right;"> 3.435 </td>
#>    <td style="text-align:right;"> 17.30 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Camaro Z28 </td>
#>    <td style="text-align:right;"> 13.3 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 350.0 </td>
#>    <td style="text-align:right;"> 245 </td>
#>    <td style="text-align:right;"> 3.73 </td>
#>    <td style="text-align:right;"> 3.840 </td>
#>    <td style="text-align:right;"> 15.41 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Pontiac Firebird </td>
#>    <td style="text-align:right;"> 19.2 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 400.0 </td>
#>    <td style="text-align:right;"> 175 </td>
#>    <td style="text-align:right;"> 3.08 </td>
#>    <td style="text-align:right;"> 3.845 </td>
#>    <td style="text-align:right;"> 17.05 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Fiat X1-9 </td>
#>    <td style="text-align:right;"> 27.3 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 79.0 </td>
#>    <td style="text-align:right;"> 66 </td>
#>    <td style="text-align:right;"> 4.08 </td>
#>    <td style="text-align:right;"> 1.935 </td>
#>    <td style="text-align:right;"> 18.90 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Porsche 914-2 </td>
#>    <td style="text-align:right;"> 26.0 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 120.3 </td>
#>    <td style="text-align:right;"> 91 </td>
#>    <td style="text-align:right;"> 4.43 </td>
#>    <td style="text-align:right;"> 2.140 </td>
#>    <td style="text-align:right;"> 16.70 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 5 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Lotus Europa </td>
#>    <td style="text-align:right;"> 30.4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 95.1 </td>
#>    <td style="text-align:right;"> 113 </td>
#>    <td style="text-align:right;"> 3.77 </td>
#>    <td style="text-align:right;"> 1.513 </td>
#>    <td style="text-align:right;"> 16.90 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 5 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Ford Pantera L </td>
#>    <td style="text-align:right;"> 15.8 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 351.0 </td>
#>    <td style="text-align:right;"> 264 </td>
#>    <td style="text-align:right;"> 4.22 </td>
#>    <td style="text-align:right;"> 3.170 </td>
#>    <td style="text-align:right;"> 14.50 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 5 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Ferrari Dino </td>
#>    <td style="text-align:right;"> 19.7 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 145.0 </td>
#>    <td style="text-align:right;"> 175 </td>
#>    <td style="text-align:right;"> 3.62 </td>
#>    <td style="text-align:right;"> 2.770 </td>
#>    <td style="text-align:right;"> 15.50 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 5 </td>
#>    <td style="text-align:right;"> 6 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Maserati Bora </td>
#>    <td style="text-align:right;"> 15.0 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 301.0 </td>
#>    <td style="text-align:right;"> 335 </td>
#>    <td style="text-align:right;"> 3.54 </td>
#>    <td style="text-align:right;"> 3.570 </td>
#>    <td style="text-align:right;"> 14.60 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 5 </td>
#>    <td style="text-align:right;"> 8 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Volvo 142E </td>
#>    <td style="text-align:right;"> 21.4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 121.0 </td>
#>    <td style="text-align:right;"> 109 </td>
#>    <td style="text-align:right;"> 4.11 </td>
#>    <td style="text-align:right;"> 2.780 </td>
#>    <td style="text-align:right;"> 18.60 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#> </tbody>
#> </table></div>
```
