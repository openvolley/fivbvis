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
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyMatch.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   pl <- list(No = 13754, Fields = paste0(v_fields("Volleyball Match"), collapse = " "))
#'   v_get_volley_match(parent = pl)
#' }
#'
#' @export
v_get_volley_match <- function(parent, children) {
  # <Request Type="GetVolleyMatch"
  #         No="<match number>">
  #         Fields="<Optional: list of the fields to return>" />
  # mandatory: "No"
  req <- v_request2(type = "GetVolleyMatch", parent, children)
  make_request(req, type = "json")
}
