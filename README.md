
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fivbvis

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
![openvolley](https://img.shields.io/badge/openvolley-darkblue.svg?logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMTAiIGhlaWdodD0iMjEwIj48cGF0aCBkPSJNOTcuODMzIDE4Ny45OTdjLTQuNTUtLjM5Ni0xMi44MTItMS44ODYtMTMuNTgxLTIuNDQ5LS4yNDItLjE3Ny0xLjY5Mi0uNzUzLTMuMjIyLTEuMjgxLTI4LjY5Ni05Ljg5NS0zNS4xNy00NS45ODctMTMuODY4LTc3LjMyMyAyLjY3Mi0zLjkzIDIuNTc5LTQuMTktMS4zOTQtMy45MDYtMTIuNjQxLjktMjcuMiA2Ljk1Mi0zMy4wNjYgMTMuNzQ1LTUuOTg0IDYuOTI3LTcuMzI3IDE0LjUwNy00LjA1MiAyMi44NjIuNzE2IDEuODI2LS45MTgtLjE3LTEuODktMi4zMS03LjM1Mi0xNi4xNzQtOS4xODEtMzguNTYtNC4zMzctNTMuMDc0LjY5MS0yLjA3IDEuNDE1LTMuODY2IDEuNjEtMy45ODkuMTk0LS4xMjMuNzgyLTEuMDUzIDEuMzA3LTIuMDY2IDMuOTQ1LTcuNjE3IDkuNDU4LTEyLjg2MiAxNy44MzktMTYuOTcgMTIuMTcyLTUuOTY4IDI1LjU3NS01LjgyNCA0MS40My40NDUgNi4zMSAyLjQ5NSA4LjgwMiAzLjgwMSAxNi4wNDcgOC40MTMgNC4zNCAyLjc2MiA0LjIxMiAyLjg3NCAzLjU5NC0zLjE3My0yLjgyNi0yNy42ODEtMTYuOTA3LTQyLjE4NS0zNi4wNjgtMzcuMTUxLTQuMjU0IDEuMTE3IDUuMjQtMy4zMzggMTEuNjYtNS40NzMgMTMuMTgtNC4zOCAzOC45MzctNS43NzIgNDYuMDc0LTEuNDg4IDEuMjQ3LjU0NyAyLjIyOCAxLjA5NSAzLjI3NSAxLjYzIDQuMjkgMi4xMDcgMTEuNzMzIDcuNjk4IDE0LjI2NSAxMS40MjcuNDA3LjYgMS4yNyAxLjg2NiAxLjkxNyAyLjgxNCAxMS4zMDggMTYuNTY1IDguNjIzIDQxLjkxLTYuODM4IDY0LjU1Mi0zLjI0OSA0Ljc1OC0zLjI1OCA0Ljc0MiAyLjQ1IDQuMDE4IDMyLjQ4Mi00LjEyMiA0OC41MTUtMjEuOTM1IDM5LjU3OC00My45NzQtMS4xNC0yLjgwOSAxLjU2NiAxLjA2IDMuNTE4IDUuMDMyIDI5LjY5MyA2MC40MTctMjIuNTggMTA3Ljg1My03OS40OTggNzIuMTQzLTUuMDg0LTMuMTktNS4xMjMtMy4xNTItMy45MDIgMy44ODMgNC43MjEgMjcuMjIgMjUuNzgzIDQzLjU2MiA0NC4wODkgMzQuMjEgMS4zNjItLjY5NiAyLjIxLS43NSAyLjIxLS4xNDMtNi43NiAzLjg1Ny0xNi4wMTggNi41NTMtMjMuMTI2IDguMDkxLTcuNTU1IDEuNTQ3LTE4LjM2NiAyLjE3Mi0yNi4wMiAxLjUwNnoiIGZpbGw9IiNmZmYiLz48ZWxsaXBzZSBjeD0iMTA1Ljk3NSIgY3k9IjEwNC40NDEiIHJ4PSI5NC44NCIgcnk9IjkyLjU0MiIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjEwLjc0Ii8+PC9zdmc+)
<!-- badges: end -->

fivbvis provides an R client to the FIVB VIS web service system.

## Installation

You can install fivbvis with:

``` r
options(repos = c(openvolley = "https://openvolley.r-universe.dev",
                  CRAN = "https://cloud.r-project.org"))

install.packages("fivbvis")

## or

install.packages("remotes") ## if needed
remotes::install_github("openvolley/fivbvis")
```

## Examples

Fetch list of tournaments:

``` r
library(fivbvis)
all_tournaments <- v_get_volley_tournament_list()
nrow(all_tournaments)
```

    #> [1] 1062

Get details for a specific tournament:

``` r
v_get_volley_tournament(1)
#> # A tibble: 1 × 56
#>   Actions BuyTicketsUrl City            Code     ContainsLiveComments
#>     <int> <lgl>         <chr>           <chr>                   <int>
#> 1    1023 NA            Algiers & Blida BU192005                    0
#>   ContainsLiveScores ContainsMatches ContainsMatchResults ContainsNews
#>                <int>           <int>                <int>        <int>
#> 1                  0               0                    0            0
#>   ContainsPictures ContainsPlayByPlay ContainsPlayers ContainsRanking
#>              <int>              <int>           <int>           <int>
#> 1                0                  0               0               0
#>   ContainsStatistics ContainsTeams ContainsVideos ContainsVideoTracking
#>                <int>         <int>          <int>                 <int>
#> 1                  0             0              0                     0
#>   CountryCode CountryName DeadlineO2 DeadlineO2A DeadlineO2bis
#>   <chr>       <chr>       <date>     <lgl>       <date>       
#> 1 DZ          Algeria     2005-05-20 NA          2005-08-22   
#>   DefaultPlayersRanking EndDate    EventLogos Gender IsFreeEntrance IsVisManaged
#>   <lgl>                 <date>     <lgl>       <int>          <int>        <int>
#> 1 NA                    2005-09-01 NA              0              0            0
#>   Logos MaxNbPlayersO2 MaxNbPlayersO2A MaxNbPlayersO2bis
#>   <lgl>          <int>           <int>             <int>
#> 1 NA                18               0                12
#>   MaxNbTeamOfficialsOnBench MaxNbTeams Name                                   
#>                       <int>      <int> <chr>                                  
#> 1                         5          0 Youth Boys' U19 World Championship 2005
#>      No NoArticlePresentation NoConfederation NoEvent NoImageLogo
#>   <int> <lgl>                 <lgl>           <lgl>   <lgl>      
#> 1     1 NA                    NA              NA      NA         
#>   NoImageFivbLogo NoImagePublicity OrganizerCode OrganizerType
#>   <lgl>           <lgl>            <lgl>                 <int>
#> 1 NA              NA               NA                        1
#>   PlayerDisplayMethod PublishOnMsdp Season ShortName
#>                 <int>         <int>  <int> <lgl>    
#> 1                   1             0   2005 NA       
#>   ShortNameOrName                         StartDate  Status TeamType
#>   <chr>                                   <date>      <int>    <int>
#> 1 Youth Boys' U19 World Championship 2005 2005-08-24      4        1
#>   TournamentLogos  Type WebSite Version
#>   <lgl>           <int> <lgl>     <int>
#> 1 NA                 16 NA            1
```

By default, results are cached in a per-session cache, so if we make the
same request again the local results are used, rather than
re-downloading:

``` r
v_options(verbose = TRUE)
v_get_volley_tournament(1)
#> using cached file /tmp/RtmpNUszJv/file41292d15f1be/4a69e890376e4ee5b0f67be41ee86963.rds
#>   Actions BuyTicketsUrl            City     Code ContainsLiveComments
#> 1    1023               Algiers & Blida BU192005                    0
#>   ContainsLiveScores ContainsMatches ContainsMatchResults ContainsNews
#> 1                  0               0                    0            0
#>   ContainsPictures ContainsPlayByPlay ContainsPlayers ContainsRanking
#> 1                0                  0               0               0
#>   ContainsStatistics ContainsTeams ContainsVideos ContainsVideoTracking
#> 1                  0             0              0                     0
#>   CountryCode CountryName DeadlineO2 DeadlineO2A DeadlineO2bis
#> 1          DZ     Algeria 2005-05-20                2005-08-22
#>   DefaultPlayersRanking    EndDate EventLogos Gender IsFreeEntrance
#> 1                       2005-09-01                 0              0
#>   IsVisManaged Logos MaxNbPlayersO2 MaxNbPlayersO2A MaxNbPlayersO2bis
#> 1            0                   18               0                12
#>   MaxNbTeamOfficialsOnBench MaxNbTeams                                    Name
#> 1                         5          0 Youth Boys' U19 World Championship 2005
#>   No NoArticlePresentation NoConfederation NoEvent NoImageLogo NoImageFivbLogo
#> 1  1                                                                          
#>   NoImagePublicity OrganizerCode OrganizerType PlayerDisplayMethod
#> 1                                            1                   1
#>   PublishOnMsdp Season ShortName                         ShortNameOrName
#> 1             0   2005           Youth Boys' U19 World Championship 2005
#>    StartDate Status TeamType TournamentLogos Type WebSite Version
#> 1 2005-08-24      4        1                   16               1
```

## Troubleshooting

Known issues:

### `internal error: Huge input lookup`

This indicates that the XML response from the FIVB server is too large
or deeply nested and is causing the parser to fail. By default the
parser restricts the nesting level that it allows, in order to prevent
crashes or other undesirable behaviour. But you can remove this
restriction by:

``` r
v_options(huge_xml = TRUE)
```

and then try your request again.
