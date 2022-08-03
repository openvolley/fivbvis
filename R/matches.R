#' Get a list of volleyball matches
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyMatchList.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   cl <- list(Filter = c(NoTournament = 1257))
#'   v_get_volley_match_list(children = cl)
#' }
#'
#' @export
v_get_volley_match_list <- function(parent = list(Fields = paste0(v_fields("Volleyball Match"), collapse = " ")), children) {
  # <Request Type="GetVolleyMatchList"
  #          Fields="<list of the fields to return>">
  #          Version="<version of local list>">
  #     <Filter /> <!-- optional: contains the filter to use -->
  # </Request>
  req <- v_request2(type = "GetVolleyMatchList", parent, children)
  make_request(req, type = "json")
}

#' Get a volleyball match
#'
#' @details Parameters can be provided in two ways. The simple interface (retained for backwards compatibility) accepts `no` and optionally `fields`. More complex queries can be issued using the `parent` and `children` parameters.
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyMatch.html}
#' @param no integer: match number. Provide either `no` (and optionally `fields`) OR `parent` (and optionally `children`). See Details
#' @param fields character: fields to return. Only relevant if `no` has been provided
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node. Ignored if `no` has been provided
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation. Ignored if `no` has been provided
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'
#'   ## using the simple interface
#'   v_get_volley_match(13754)
#'
#'   ## or equivalently
#'   pl <- list(No = 13754, Fields = paste0(v_fields("Volleyball Match"), collapse = " "))
#'   v_get_volley_match(parent = pl)
#' }
#'
#' @export
v_get_volley_match <- function(no, fields, parent, children) {
  # <Request Type="GetVolleyMatch"
  #         No="<match number>">
  #         Fields="<Optional: list of the fields to return>" />
  # mandatory: "No"
  if (!missing(no)) {
    # old interface
    req <- v_request(type = "GetVolleyMatch", no = no, fields = fields)
    make_request(req, node_path = "//VolleyballMatch")
  } else {
    req <- v_request2(type = "GetVolleyMatch", parent, children)
    make_request(req, type = "json")
  }
}
