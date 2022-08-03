#' Get a list of volleyball tournaments
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyTournamentList.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   cl <- list(Filter = c(Seasons = "2022"))
#'   v_get_volley_tournament_list(children = cl)
#' }
#'
#' @export
v_get_volley_tournament_list <- function(parent = list(Fields = paste0(v_fields("Volleyball Tournament"), collapse = " ")), children) {
  # <Request Type="GetVolleyTournamentList"
  #          Fields="<list of the fields to return>">
  #          Version="<version of local list>">
  #     <Filter /> <!-- optional: contains the filter to use -->
  # </Request>
  req <- v_request2(type = "GetVolleyTournamentList", parent, children)
  out <- make_request(req, type = "json")
  out <- v_remap(out, col = "gender", schema = "Event Gender")
  out <- v_remap(out, col = "organizerType", schema = "Organizer Type")
  v_remap(out, col = "status", schema = "Volley Tournament Status")
}

#' Get a volleyball tournament
#'
#' @details Parameters can be provided in two ways. The simple interface (retained for backwards compatibility) accepts `no` and optionally `fields`. More complex queries can be issued using the `parent` and `children` parameters.
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyTournament.html}
#' @param no integer: the tournament number ("No" as returned by `v_get_volley_tournament_list`). Provide either `no` (and optionally `fields`) OR `parent` (and optionally `children`). See Details
#' @param fields character: fields to return. Only relevant if `no` has been provided
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node. Ignored if `no` has been provided
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation. Ignored if `no` has been provided
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   ## using the simple interface
#'   v_get_volley_tournament(1257)
#'
#'   ## or equivalently
#'   pl <- list(No = 1257)
#'   v_get_volley_tournament(parent = pl)
#' }
#'
#' @export
v_get_volley_tournament <- function(no, fields, parent, children) {
  # <Request Type="GetVolleyTournament"
  #          No="<tournament number>">
  #          Fields="<Optional: list of the fields to return>" />
  # mandatory: "No"
  if (!missing(no)) {
    req <- v_request(type = "GetVolleyTournament", no = no, fields = fields)
    make_request(req, node_path = "//VolleyballTournament")
  } else {
    req <- v_request2(type = "GetVolleyTournament", parent, children)
    out <- make_request(req, type = "json")
    out <- v_remap(out, col = "gender", schema = "Event Gender")
    out <- v_remap(out, col = "organizerType", schema = "Organizer Type")
    v_remap(out, col = "status", schema = "Volley Tournament Status")
  }
}

#' Get the ranking of a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyTournamentRanking.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   pl <- list(
#'     NoTournament = "1182",
#'     Fields = paste(v_fields("Volleyball Tournament Ranking"), collapse = " ")
#'   )
#'   vb_tournament_ranking <- v_get_volley_tournament_ranking(parent = pl)
#' }
#'
#' @export
v_get_volley_tournament_ranking <- function(parent) {
  # <Request Type="GetVolleyTournamentRanking"
  #          NoTournament="<tournament number>"
  #          Fields="<list of the fields to return>" />
  # mandatory: "NoTournament"
  req <- v_request2(type = "GetVolleyTournamentRanking", parent)
  make_request(req, type = "json")
}
