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
v_get_volley_player_list <- function(fields = v_fields("Volleyball Player"), version, filter) {
    ## <Request Type="GetVolleyPlayerList"
    ##          Fields="<list of the fields to return>">
    ##          Version="<version of local list>">
    ##   <Filter /> <!-- optional: contains the filter to use -->
    ## </Request>
    body <- minixml::xml_elem("Request", Type = "GetVolleyPlayerList")
    body <- body$update(Fields = paste(fields, collapse = " "))
    make_request(body = body, node_path = "//VolleyballPlayer")
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
    body <- minixml::xml_elem("Request", Type = "GetVolleyPlayer")
    body <- body$update(No = no)
    if (!missing(fields) && !is.null(fields) && length(fields)) body <- body$update(Fields = paste(fields, collapse = " "))
    make_request(body = body, node_path = "//VolleyballPlayer")
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
    body <- minixml::xml_elem("Request", Type = "GetPlayer")
    body <- body$update(No = no)
    if (!missing(fields) && !is.null(fields) && length(fields)) body <- body$update(Fields = paste(fields, collapse = " "))
    make_request(body = body, node_path = "//Player")
}

## TODO https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPlayersRankingList.html

## Player Volley Position
## Value Name Description
## 0 Unknown Unknown.
## 1 Setter Setter.
## 2 WingSpiker Wing spiker.
## 3 MiddleBlocker Middle blocker.
## 4 Libero Libero.
## 5 Universal Universal.
## 6 OppositeSpiker Opposite spiker.
