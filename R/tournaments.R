#' Get a list of volleyball tournaments
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyTournamentList.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_volley_tournament_list()
#' }
#'
#' @export
v_get_volley_tournament_list <- function(fields = v_fields("Volleyball Tournament"), version, filter) {
    ## <Request Type="GetVolleyTournamentList"
    ## Fields="<list of the fields to return>">
    ##     Version="<version of local list>">
    ##         <Filter /> <!-- optional: contains the filter to use -->
    ## </Request>
    req <- v_request(type = "GetVolleyTournamentList", fields = fields, version = version, filter = filter)
    make_request(req, node_path = "//VolleyballTournament")
}

#' Get a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyTournament.html}
#' @param no integer: the tournament number ("No" as returned by `v_get_volley_tournament_list`
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_volley_tournament(1)
#' }
#'
#' @export
v_get_volley_tournament <- function(no, fields) {
    ## <Request Type="GetVolleyTournament"
    ## No="<tournament number>">
    ##     Fields="<Optional: list of the fields to return>" />
    req <- v_request(type = "GetVolleyTournament", no = no, fields = fields)
    make_request(req, node_path = "//VolleyballTournament")
}

#' Get the ranking of a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyTournamentRanking.html}
#' @param notournament integer: the tournament number ("No" as returned by `v_get_volley_tournament_list`
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_volley_tournament_ranking(1032)
#' }
#'
#' @export
v_get_volley_tournament_ranking <- function(notournament, fields = v_fields("Volleyball Tournament Ranking")) {
    ## <Request Type="GetVolleyTournamentRanking"
    ## No="<tournament number>"
    ## Fields="<list of the fields to return>" />
    req <- v_request(type = "GetVolleyTournamentRanking", NoTournament = notournament, fields = fields)
    make_request(req, node_path = "//VolleyballTournamentRanking")
}

