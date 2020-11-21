#' Get a beach tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachTournament.html}
#' @param no integer: the number of the tournament
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_tournament(502)
#' }
#'
#' @export
v_get_beach_tournament <- function(no, fields) {
    ## <Request Type="GetBeachTournament"
    ##      No="<tournament number>">
    ##      Fields="<Optional: list of the fields to return>" />
    req <- v_request(type = "GetBeachTournament", no = no, fields = fields)
    make_request(req, node_path = "//BeachTournament")
}



#' Get a list of beach tournaments
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachTournament.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_tournament_list()
#' }
#'
#' @export
v_get_beach_tournament_list <- function(fields = v_fields("Beach Tournament"), version, filter) {
  ## <Request Type="GetBeachTournamentList"
  ##          Fields="<list of the fields to return>">
  ##          Version="<version of local list>">
  ##   <Filter /> <!-- optional: contains the filter to use -->
  ## </Request>
  req <- v_request(type = "GetBeachTournamentList", fields = fields, version = version, filter = filter)
  make_request(request = req, node_path = "//BeachTournament")
}




#' Request to get a beach volleyball Olympic Selection ranking
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachOlympicSelectionRanking.html}
#' @param gender character: gender of the olympic ranking selection
#' @param gamesyear integer: year to return ranking selection. if this parameter is not specified, the web service will return the ranking for the latest olympic games with a ranking.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_olympic_selection_ranking("W")
#' }
#'
#' @export
v_get_beach_olympic_selection_ranking <- function(gender, gamesyear, fields = v_fields("Beach Olympic Selection Ranking")) {
    if (missing(gamesyear)) gamesyear <- NULL
    ## <Request Type="GetBeachOlympicSelectionRanking"
    ## Gender="<gender>"
    ## GamesYear="<year of the Olympic Games>"
    ## OnlySelected="<boolean value>"
    ## ReferenceDate="<ranking reference data>"
    ## Fields="list of the fields to return" />
    req <- v_request(type = "GetBeachOlympicSelectionRanking", Gender = gender, GamesYear = gamesyear, fields = fields, old_style = TRUE)
    make_request(req, node_path = "//BeachOlympicSelectionRankingEntry")
}



#' Request to get a beach volleyball Olympic Selection ranking
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachWorldTourRanking.html}
#' @param gender character: gender of the teams to retrieve the ranking for
#' @param number integer: number of entries to return
#' @param referencedate date: reference date of the ranking when the ranking has been calculated. YYY-MM-DD. if there is no World Tour ranking calculated at the specified date, the returned ranking will be empty. if this parameter is not specified, the web service will return the ranking for the latest reference date.
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_world_tour_ranking("W")
#' }
#'
#' @export
v_get_beach_world_tour_ranking <- function(gender, number, referencedate, fields = v_fields("Beach World Tour Ranking")) {
    if (missing(number)) number <- NULL
    if (missing(referencedate)) referencedate <- NULL
    ## <Request Type="GetBeachWorldTourRanking"
    ## Gender="<gender>"
    ## Number="<number of entries to return>"
    ## ReferenceDate="<ranking reference data>
    ## Fields="list of the fields to return" />
    req <- v_request(type = "GetBeachWorldTourRanking", Gender = gender, Number = number, ReferenceDate = referencedate, fields = fields, old_style = TRUE)
    make_request(req, node_path = "//BeachWorldTourRankingEntry")
}

## TODO https://www.fivb.org/VisSDK/VisWebService/#GetBeachMatch.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetBeachMatchList.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetBeachRound.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetBeachRoundList.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetBeachRoundRanking.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetBeachTeam.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetBeachTeamList.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetBeachTournamentRanking.html
