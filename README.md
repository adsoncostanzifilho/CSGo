
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CSGo <img src="man/img/logo.png" width="120px" align="right" />

<br>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/CSGo)](https://CRAN.R-project.org/package=CSGo)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

R client for accessing Steam’s REST API specifically for the
Counter-Strike Global Offensive Game (CS Go) data. Check out the [Steam
documentation
website](https://developer.valvesoftware.com/wiki/Steam_Web_API) for
more information.

## Package Functionality

The goal of `CSGo` is to provide an easy way to connect and pull data
from the Steam API specifically for the Counter-Strike Global Offensive
Game (CS Go).

## Responsible use

The `CSGo` package should be used in strict accordance with [Steam Api
Terms of Use](https://steamcommunity.com/dev/apiterms).

## Installation

To get the current released version from
[CRAN](https://CRAN.R-project.org/package=CSGo):

``` r
install.packages("CSGo")
```

To get the current development version from
[GitHub](https://github.com/adsoncostanzifilho/CSGo):

``` r
# install.packages("devtools")
devtools::install_github("adsoncostanzifilho/CSGo")
```

## Example

The first step to use the `CSGo` package is to have your own credentials
(API key) to pull the CSGo data from the Steam API.

For more information about how to get your own API Key run in your R
`vignette("auth", package = "CSGo")`.

Now that you already have your API Key you should be able to collect
your own CSGo data as well as your friends’ data.

``` r
library(CSGo)

# to get my own statistics
my_stats <- get_stats_user(api_key = 'your_key', user_id = '76561198263364899')

# to get the statistics of all my "public" friends
friends_stats <- get_stats_friends(api_key = 'your_key', user_id = '76561198263364899')
```

*PS*: Take a look at the `vignette("usecase", package = "CSGo")` to get
some ideas.
