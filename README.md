
<!-- README.md is generated from README.Rmd. Please edit that file -->

# testFars

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/Ruticc/testFars.svg?branch=master)](https://travis-ci.org/Ruticc/testFars)
<!-- badges: end -->

The goal of testFars is to facilitate the use of FARS data for
summarizing fatality statistics.

## Installation

You can install the released version of testFars from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("testFars")
```

``` r
library(testFars)
## basic example code
```

## Example

It helps you analyze data from fatality so for example you can summarize
the data by years and months. For more details see the vignette.

``` r
data_dir <- "/home/ruth/Dokumente/Learning/RProgramming/testFars/inst/extdata"
setwd(data_dir)

fars_summarize_years(c(2013,2014,2015))
#> Warning: `tbl_df()` is deprecated as of dplyr 1.0.0.
#> Please use `tibble::as_tibble()` instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_warnings()` to see where this warning was generated.
#> # A tibble: 12 x 4
#>    MONTH `2013` `2014` `2015`
#>    <dbl>  <int>  <int>  <int>
#>  1     1   2230   2168   2368
#>  2     2   1952   1893   1968
#>  3     3   2356   2245   2385
#>  4     4   2300   2308   2430
#>  5     5   2532   2596   2847
#>  6     6   2692   2583   2765
#>  7     7   2660   2696   2998
#>  8     8   2899   2800   3016
#>  9     9   2741   2618   2865
#> 10    10   2768   2831   3019
#> 11    11   2615   2714   2724
#> 12    12   2457   2604   2781
```
