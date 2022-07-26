#' Get a list of volleyball pools
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPoolList.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   cl <- list(Filter = c(NoTournament = 1257))
#'   v_get_volley_pool_list(children = cl)
#' }
#'
#' @export
v_get_volley_pool_list <- function(parent = list(Fields = paste0(v_fields("Volleyball Pool"), collapse = " ")), children) {
  # <Request Type="GetVolleyPoolList"
  #          Fields="<list of the fields to return>">
  #          Version="<version of local list>">
  #     <Filter /> <!-- optional: contains the filter to use -->
  # </Request>
  req <- v_request2(type = "GetVolleyPoolList", parent, children)
  make_request(req, type = "json")
}

#' Get a volleyball pool
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPool.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#' @param children list: Named list of named charactor vectors. Add child nodes such as Filter, Relation.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   pl <- list(No = 13754, Fields = paste0(v_fields("Volleyball Pool"), collapse = " "))
#'   v_get_volley_pool(parent = pl)
#' }
#'
#' @export
v_get_volley_pool <- function(parent, children) {
  # <Request Type="GetVolleyPool"
  #          No="<pool number>">
  #          Fields="<Optional: list of the fields to return>" />
  # mandatory: "No"
  req <- v_request2(type = "GetVolleyPool", parent, children)
  make_request(req, type = "json")
}

#' Get the ranking of a volleyball pool
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetVolleyPoolRanking.html}
#' @param parent list: List of named charactor vectors. Specify attributes of Request Node.
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   pl <- list(NoPool = "3354", Fields = paste(v_fields("Volleyball Pool Ranking"), collapse = " "))
#    v_get_volley_pool_ranking(parent = pl)
#' }
#'
#' @export
v_get_volley_pool_ranking <- function(parent) {
  # <Request Type="GetVolleyPoolRanking"
  #          NoPool="<pool number>"
  #          Fields="<list of the fields to return>" />
  # mandatory: "NoPool"
  req <- v_request2(type = "GetVolleyPoolRanking", parent)
  make_request(req, type = "json")
}
