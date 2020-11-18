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
    body <- minixml::xml_elem("Request", Type = "GetVolleyMatch")
    body <- body$update(No = no)
    if (!missing(fields) && !is.null(fields) && length(fields)) body <- body$update(Fields = paste(fields, collapse = " "))
    make_request(body = body)
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
    body <- minixml::xml_elem("Request", Type = "GetVolleyMatchList")
    body <- body$update(Fields = paste(fields, collapse = " "))
    make_request(body = body)
}



