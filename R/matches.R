#' Get a volleyball match
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyMatch.html}
#' @param no integer: match number
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_volley_match(7604)
#' }
#'
#' @export
v_get_volley_match <- function(no, fields) {
    ## <Request Type="GetVolleyMatch"
    ##      No="<match number>">
    ##      Fields="<Optional: list of the fields to return>" />
    req <- v_request(type = "GetVolleyMatch", no = no, fields = fields)
    make_request(req, node_path = "//VolleyballMatch")
}


#' Get a list of volleyball matches
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyMatchList.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_volley_match_list()
#' }
#'
#' @export
v_get_volley_match_list <- function(fields = v_fields("Volleyball Match"), version, filter) {
    ## <Request Type="GetVolleyMatchList"
    ##          Fields="<list of the fields to return>">
    ##          Version="<version of local list>">
    ##   <Filter /> <!-- optional: contains the filter to use -->
    ## </Request>
    req <- v_request(type = "GetVolleyMatchList", fields = fields, version = version, filter = filter)
    make_request(req, node_path = "//VolleyballMatches")
}
