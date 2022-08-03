#' Get a list of registration of players in volleyball tournaments
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPlayerList.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   cl <- list(
#'     Filter = c(NoTournament = 1257),
#'     Relation = c(Name = "Player", Fields = "No TeamName FirstName LastName")
#'   )
#'   v_get_volley_player_list(children = cl)
#' }
#'
#' @export
v_get_volley_player_list <- function(parent = list(Fields = paste0(v_fields("Volleyball Player"), collapse = " ")), children) {
  # <Request Type="GetVolleyPlayerList"
  #          Fields="<list of the fields to return>">
  #          Version="<version of local list>">
  #     <Filter /> <!-- optional: contains the filter to use -->
  # </Request>
  req <- v_request2(type = "GetVolleyPlayerList", parent, children)
  out <- make_request(req, type = "json")
  v_remap(out, col = "position", schema = "Player Volley Pos")
}

#' Get a registration of a player in a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPlayer.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   pl <- list(No = 89538, Fields = paste0(v_fields("Volleyball Player"), collapse = " "))
#'   cl <- list(Relation = c(Name = "Player", Fields = "No TeamName FirstName LastName"))
#'   v_get_volley_player(parent = pl, children = cl)
#' }
#'
#' @export
v_get_volley_player <- function(parent, children) {
  # <Request Type="GetVolleyPlayer"
  #          No="<player number>">
  #          Fields="<Optional: list of the fields to return>" />
  # mandatory: "No"
  req <- v_request2(type = "GetVolleyPlayer", parent, children)
  out <- make_request(req, type = "json")
  v_remap(out, col = "position", schema = "Player Volley Pos")
}

#' Get a player
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetPlayer.html}
#' @param no integer: the number of the player
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_player(100002)
#' }
#'
#' @export
v_get_player <- function(no, fields) {
  ## <Request Type="GetPlayer"
  ##          No="<player number>"
  ##          Fields="<optional: list of the fields to return>" />
  req <- v_request(type = "GetPlayer", no = no, fields = fields)
  out <- make_request(req, node_path = "//Player")
  out <- v_remap(out, col = "VolleyPosition", schema = "Player Volley Position")
  v_remap(out, col = "BeachPosition", schema = "Player Beach Position")
}

#' Get the ranking of the players in a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPlayersRankingList.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   pl <- list(No = 229, NumberOfScorers = 20, NumberOfPlayers = 20,
#'              Skills = "Block Dig Libero Reception Scorer Service Set Spike")
#'   vb_player_ranking <- v_get_volley_player_ranking(parent = pl)
#' }
#'
#' @export
v_get_volley_player_ranking <- function(parent) {
  # <Request Type="GetVolleyPlayersRankingList"
  #          No="<the number of the ranking>"
  #          NoTournament="<the number of the tournament>"
  #          NumberOfPlayers="<the number of players to return>";
  #          NumberOfScorers="<the number of scorers to return>";
  #          Skills="<the skills to return>" />
  # mandatory: "No"
  req <- XML::addChildren(XML::xmlNode("Requests"), kids = list(v_request2(type = "GetVolleyPlayersRankingList", parent)))
  out <- make_request(req, return_type = "content")
  xml_parse_options <- c(XML::RECOVER, if (isTRUE(v_options()$huge_xml)) c(XML::COMPACT, XML::HUGE))
  out <- XML::xmlToList(XML::xmlParse(out, asText = TRUE, options = xml_parse_options))[[1]]
  out <- purrr::set_names(out, purrr::map_chr(out, ~ .x[[".attrs"]][1]))
  out <- purrr::map(out, function(z) {
    out <- dplyr::bind_rows(z[c(names(z) == "Player")])
    v_remap(out, col = "CourtPosition", schema = "Player Volley Pos")
  })
}
