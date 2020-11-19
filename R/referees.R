#' Get a list of referees
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#Beach%20Live_xsd~e-BeachLive~e-Referee.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_referee_list()
#' }
#'
#' @export
v_get_referee_list <- function(fields = v_fields("Referee"), version, filter) {
    ## <Request Type="GetRefereeList"
    ##          Fields="<list of the fields to return>">
    ##          Version="<version of local list>">
    ##   <Filter /> <!-- optional: contains the filter to use -->
    ## </Request>
    body <- minixml::xml_elem("Request", Type = "GetRefereeList")
    body <- body$update(Fields = paste(fields, collapse = " "))
    body <- minixml::xml_elem("Requests")$append(body)
    make_request(body = body, node_path = "//Referee")
}


