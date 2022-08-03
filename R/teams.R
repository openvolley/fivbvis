#' Get a list of registrations of teams in a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyTeamList.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   cl <- list(Filter = c(NoTournament = 1257))
#'   v_get_volley_team_list(children = cl)
#' }
#'
#' @export
v_get_volley_team_list <- function(parent = list(Fields = paste0(v_fields("Volleyball Team"), collapse = " ")), children) {
  # <Request Type="GetVolleyTeamList"
  #          Fields="<list of the fields to return>">
  #          Version="<version of local list>">
  #     <Filter /> <!-- optional: contains the filter to use -->
  # </Request>
  req <- v_request2(type = "GetVolleyTeamList", parent, children)
  make_request(req, type = "json")
}

#' Get a registration of a team in a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyTeam.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   pl <- list(No = 5120, Fields = paste0(v_fields("Volleyball Team"), collapse = " "))
#'   v_get_volley_team(parent = pl) %>% select(Code, Name)
#' }
#'
#' @export
v_get_volley_team <- function(parent, children) {
  # <Request Type="GetVolleyTeam"
  #          No="<team number>">
  #          Fields="<Optional: list of the fields to return>" />
  # mandatory: "No"
  req <- v_request2(type = "GetVolleyTeam", parent, children)
  make_request(req, type = "json")
}

#' Get the ranking of the teams in a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/Fivb.Vis.DataWPF/Fivb.Vis.DataWPF~Fivb.Vis.Volley.GetVolleyTeamsRankingListRequest_members.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   pl <- list(No = 229, NumberOfScorers = 20, NumberOfPlayers = 20, Skills = "Block Dig Libero Reception Scorer Service Set Spike")
#'   vb_team_ranking <- v_get_volley_team_ranking(parent = pl)
#' }
#'
#' @export
v_get_volley_team_ranking <- function(parent) {
  # <Request Type="GetVolleyTeamsRankingList"
  #          No="<the number of the ranking>"
  #          NoTournament="<the number of the tournament>"
  #          NumberOfPlayers="<the number of players to return>";
  #          NumberOfScorers="<the number of scorers to return>";
  #          Skills="<the skills to return>" />
  # mandatory: "No"
  req <- XML::addChildren(XML::xmlNode("Requests"), kids = list(v_request2(type = "GetVolleyTeamsRankingList", parent)))
  out <- make_request(req, return_type = "content")
  xml_parse_options <- c(XML::RECOVER, if (isTRUE(v_options()$huge_xml)) c(XML::COMPACT, XML::HUGE))
  out <- XML::xmlToList(XML::xmlParse(out, asText = TRUE, options = xml_parse_options))[[1]]
  out <- purrr::set_names(out, purrr::map_chr(out, ~ .x[[".attrs"]][1]))
  purrr::map(out, function(z) {
    dplyr::bind_rows(z[c(names(z) == "Team")])
  })
}
