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
#' @param fields character: fields to return
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



#' Request to get a beach volleyball World Tour ranking
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



#' Get a beach volleyball match
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachMatch.html}
#' @param no integer: match number
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_match(15592)
#' }
#'
#' @export
v_get_beach_match <- function(no, fields) {
  ## <Request Type="GetBeachMatch"
  ##      No="<match number>">
  ##      Fields="<Optional: list of the fields to return>" />
  req <- v_request(type = "GetBeachMatch", no = no, fields = fields)
  make_request(req, node_path = "//BeachMatch")
}



#' Get a list of beach volleyball matches
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachMatchList.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_match_list()
#' }
#'
#' @export
v_get_beach_match_list <- function(fields = v_fields("Beach Match"), version, filter) {
  ## <Request Type="GetBeachMatchList"
  ##          Fields="<list of the fields to return>">
  ##          Version="<version of local list>">
  ##   <Filter /> <!-- optional: contains the filter to use -->
  ## </Request>
  req <- v_request(type = "GetBeachMatchList", fields = fields, version = version, filter = filter)
  make_request(req, node_path = "//BeachMatch")
}



#' Get a beach volleyball round
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachRound.html}
#' @param no integer: round number
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_round(3054)
#' }
#'
#' @export
v_get_beach_round <- function(no, fields) {
  ## <Request Type="GetBeachRound"
  ##      No="<round number>">
  ##      Fields="<Optional: list of the fields to return>" />
  req <- v_request(type = "GetBeachRound", no = no, fields = fields)
  make_request(req, node_path = "//BeachRound")
}




#' Get a list of beach volleyball rounds
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachRoundList.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_round_list()
#' }
#'
#' @export
v_get_beach_round_list <- function(fields = v_fields("Beach Round"), version, filter) {
  ## <Request Type="GetBeachRoundList"
  ##          Fields="<list of the fields to return>">
  ##          Version="<version of local list>">
  ##   <Filter /> <!-- optional: contains the filter to use -->
  ## </Request>
  req <- v_request(type = "GetBeachRoundList", fields = fields, version = version, filter = filter)
  make_request(req, node_path = "//BeachRound")
}



#' Get a beach volleyball team
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachTeam.html}
#' @param no integer: team number
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_team(375442)
#' }
#'
#' @export
v_get_beach_team <- function(no, fields) {
  ## <Request Type="GetBeachTeam"
  ##      No="<team number>">
  ##      Fields="<Optional: list of the fields to return>" />
  req <- v_request(type = "GetBeachTeam", no = no, fields = fields)
  make_request(req, node_path = "//BeachTeam")
}



#' Get a list of beach volleyball teams
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachTeamList.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_team_list()
#' }
#'
#' @export
v_get_beach_team_list <- function(fields = v_fields("Beach Team"), version, filter) {
  ## <Request Type="GetBeachTeamList"
  ##          Fields="<list of the fields to return>">
  ##          Version="<version of local list>">
  ##   <Filter /> <!-- optional: contains the filter to use -->
  ## </Request>
  req <- v_request(type = "GetBeachTeamList", fields = fields, version = version, filter = filter)
  make_request(req, node_path = "//BeachTeam")
}



#' Request to get the ranking of a beach volleyball round
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachRoundRanking.html}
#' @param no integer: number of the beach volleyball round
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_round_ranking(980)
#' }
#'
#' @export
v_get_beach_round_ranking <- function(no, fields = v_fields("Beach Round Ranking")) {
  ## <Request Type="GetBeachRoundRanking"
  ##  No="<round number>"
  ##  Fields="<list of the fields to return>" />
  req <- v_request(type = "GetBeachRoundRanking", no = no, fields = fields)
  make_request(req, node_path = "//BeachRoundRankingEntry")
}



#' Request to get the ranking of a beach volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachTournamentRanking.html}
#' @param no integer: number of the beach volleyball tournament
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_beach_tournament_ranking(503)
#' }
#'
#' @export
v_get_beach_tournament_ranking <- function(no, fields = v_fields("Beach Tournament Ranking")) {
  ## <Request Type="GetBeachTournamentRanking"
  ##   No="<tournament number>"
  ##   Phase="<phase>">
  ##   Fields="<list of the fields to return>" />
  req <- v_request(type = "GetBeachTournamentRanking", no = no, fields = fields)
  make_request(req, node_path = "//BeachTournamentRankingEntry")
}
