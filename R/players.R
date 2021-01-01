#' Get a list of registration of players in volleyball tournaments
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPlayerList.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_volley_player_list()
#' }
#'
#' @export
v_get_volley_player_list <- function(fields = c(v_fields("Volleyball Player"), "FirstName", "LastName"), version, filter) {
    ## <Request Type="GetVolleyPlayerList"
    ##          Fields="<list of the fields to return>">
    ##          Version="<version of local list>">
    ##   <Filter /> <!-- optional: contains the filter to use -->
    ## </Request>
    req <- v_request(type = "GetVolleyPlayerList", fields = fields, version = version, filter = filter)
    with_names <- any(c("FirstName", "LastName") %in% fields)
    if (with_names) {
        req <- req$append(minixml::xml_elem("Relation", Name = "Player", Fields = "No FirstName LastName"))
        ## we need to parse this differently because the Player info is embedded as a child of each VolleyballPlayer node, grr
        out <- make_request(request = req, return_type = "content")
        plx <- unique(XML:::xmlAttrsToDataFrame(XML::getNodeSet(XML::xmlParse(out, asText = TRUE), path = "//Player")))
        plx <- plx[, setdiff(names(plx), "Version")]
        out <- XML:::xmlAttrsToDataFrame(XML::getNodeSet(XML::xmlParse(out, asText = TRUE), path = "//VolleyballPlayer"))
        ## now left-join player info to the main output
        merge(out, plx, by.x = "NoPlayer", by.y = "No", all.x = TRUE, all.y = FALSE)
    } else {
        make_request(request = req, node_path = "//VolleyballPlayer")
    }
}

#' Get a registration of a player in a volleyball tournament
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPlayer.html}
#' @param no integer: the number of the player registration
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_volley_player(2508)
#' }
#'
#' @export
v_get_volley_player <- function(no, fields) {
    ## <Request Type="GetVolleyPlayer"
    ##      No="<player number>">
    ##      Fields="<Optional: list of the fields to return>" />
    req <- v_request(type = "GetVolleyPlayer", no = no, fields = fields)
    out <- make_request(req, node_path = "//VolleyballPlayer")
    v_remap(out, col = "Position", schema = "Player Volley Position")
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

## TODO https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPlayersRankingList.html
